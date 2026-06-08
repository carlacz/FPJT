# -------------------------------------------------------------------------
# Title:    Data preparation - FPJT PsychoPy online
# Author:   Carla Czilczer
# Date:     04.06.2026
# R ver.:   4.5.2
#
# Purpose:
# Prepare PsychoPy/Pavlovia experiment output (.csv files) so that:
# - trial-level FPJT test data are available in long format (data_long_tbl)
# - demographic and summary data are summarized in wide format (data_wide)
#
# Usage:
# Place this script next to a folder named "data".
# Place all PsychoPy/Pavlovia .csv files in that "data" folder.
# The script writes data.rdata containing data_long_tbl and data_wide.
# -------------------------------------------------------------------------

# =========================================================================
# PREPARATIONS
# =========================================================================

# Clear workspace
rm(list = ls())

# -------- Set working directory to the fixed 'data' folder next to this script --------
# This assumes you run the script from the folder where it is saved.
# If a folder called "data" exists there, the script switches into it.

if (dir.exists("data")) {
  setwd("data")
}

message("Working directory: ", normalizePath(getwd()))

# -------- Workflow: read multiple PsychoPy CSV files and merge --------

csv_pattern <- "\\.csv$"
files <- list.files(pattern = csv_pattern, full.names = TRUE)

if (length(files) == 0L) {
  stop("No CSV files found. Put your PsychoPy .csv files into the data folder.")
}

# Read one CSV file safely.
# Empty or unreadable files are skipped.
read_one_file <- function(f) {
  x <- tryCatch(
    read.csv(f,
             stringsAsFactors = FALSE,
             check.names = TRUE,
             fileEncoding = "UTF-8-BOM"),
    error = function(e) NULL
  )
  
  if (is.null(x) || nrow(x) == 0L) {
    warning("Skipping empty/unreadable file: ", basename(f))
    return(NULL)
  }
  
  names(x) <- trimws(names(x))
  x$source_file <- rep(basename(f), nrow(x))
  x
}

data_list <- lapply(files, read_one_file)
data_list <- Filter(Negate(is.null), data_list)

if (length(data_list) == 0L) {
  stop("No usable CSV files found. All matching CSV files were empty or unreadable.")
}

# Combine files even if PsychoPy files differ slightly in their columns.
# Missing columns are filled with NA before row-binding.
all_cols <- unique(unlist(lapply(data_list, names)))

data_list <- lapply(data_list, function(x) {
  missing_cols <- setdiff(all_cols, names(x))
  if (length(missing_cols) > 0L) {
    for (col in missing_cols) x[[col]] <- NA
  }
  x[, all_cols, drop = FALSE]
})

df <- do.call(rbind, data_list)

message("Imported ", length(data_list), " usable file(s). Combined rows: ", nrow(df),
        " | columns: ", ncol(df))

# ==========================================================================
# DATA WRANGLING
# ==========================================================================

# -------- Helper functions -------------------------------------------------

first_nonempty <- function(x) {
  x <- as.character(x)
  x <- trimws(x)
  x <- x[!is.na(x) & nzchar(x) & x != "NaN"]
  if (length(x) >= 1L) x[[1]] else NA_character_
}

as_num <- function(x) {
  suppressWarnings(as.numeric(as.character(x)))
}

as_int <- function(x) {
  suppressWarnings(as.integer(as.numeric(as.character(x))))
}

rename_if_exists <- function(df, old, new) {
  if (old %in% names(df)) names(df)[names(df) == old] <- new
  df
}

get_col <- function(df, col) {
  if (col %in% names(df)) df[[col]] else rep(NA, nrow(df))
}

# -------- Participant ID ---------------------------------------------------
# PsychoPy usually stores the participant ID in 'participant'.
# For comparability with the OpenSesame scripts, this is renamed to subject_nr.

if ("participant" %in% names(df)) {
  df$subject_nr <- as.character(df$participant)
} else if ("subject_nr" %in% names(df)) {
  df$subject_nr <- as.character(df$subject_nr)
} else {
  stop("Required participant ID column missing. Expected 'participant' or 'subject_nr'.")
}

# Remove broken/non-data rows if they do not contain a participant ID.
df <- df[!is.na(df$subject_nr) & nzchar(trimws(df$subject_nr)), , drop = FALSE]

# -------- Demographics and summaries (wide) --------------------------------
# Create one row per subject with first non-empty value for each demographic field.
# PsychoPy column names are mapped to short output names.

subjects <- unique(df$subject_nr)
data_wide <- data.frame(subject_nr = subjects, stringsAsFactors = FALSE)

# Optional 
for (out_col in c("language", "selected_response_mode", "selected_feedback")) {
  if (out_col %in% names(df)) {
    data_wide[[out_col]] <- vapply(subjects, function(s) {
      first_nonempty(df[[out_col]][df$subject_nr == s])
    }, FUN.VALUE = character(1), USE.NAMES = FALSE)
  }
}

if ("age_textbox.text" %in% names(df)) {
  data_wide$age <- vapply(subjects, function(s) {
    first_nonempty(df$age_textbox.text[df$subject_nr == s])
  }, FUN.VALUE = character(1), USE.NAMES = FALSE)
  data_wide$age <- as_int(data_wide$age)
}

if ("gender_slider.response" %in% names(df)) {
  data_wide$gender <- vapply(subjects, function(s) {
    first_nonempty(df$gender_slider.response[df$subject_nr == s])
  }, FUN.VALUE = character(1), USE.NAMES = FALSE)
  
  # PsychoPy stores this slider response numerically in the CSV.
  # Coding should match the experiment setup.
  data_wide$gender <- as_int(data_wide$gender)
}

if ("laterality_slider.response" %in% names(df)) {
  data_wide$handedness <- vapply(subjects, function(s) {
    first_nonempty(df$laterality_slider.response[df$subject_nr == s])
  }, FUN.VALUE = character(1), USE.NAMES = FALSE)
  
  # PsychoPy stores this slider response numerically in the CSV.
  # Coding should match the experiment setup.
  data_wide$handedness <- as_int(data_wide$handedness)
}

# Number of comprehension-check attempts.
if ("CC_attempt" %in% names(df)) {
  data_wide$n_CC <- vapply(subjects, function(s) {
    first_nonempty(df$CC_attempt[df$subject_nr == s])
  }, FUN.VALUE = character(1), USE.NAMES = FALSE)
  data_wide$n_CC <- as_int(data_wide$n_CC)
}

# Familiarization accuracy: mean of famil_answer across familiarization trials.
if ("famil_answer" %in% names(df)) {
  data_wide$fam_accuracy <- vapply(subjects, function(s) {
    vals <- as_num(df$famil_answer[df$subject_nr == s])
    vals <- vals[!is.na(vals)]
    if (length(vals) > 0L) mean(vals) else NA_real_
  }, FUN.VALUE = numeric(1), USE.NAMES = FALSE)
}

message("Created wide table with ", nrow(data_wide), " participant(s).")

# -------- Create trial-level (long) table ---------------------------------
# The online FPJT output stores test responses in response.*.
# Practice trials are not included in data_long_tbl.

common_cols <- c("subject_nr", "item", "n_audios", "solution", "n_audio_false", 
                 "a2", "a3", "a4", "a5", "a6", "a7", "bodypart_false",
                 "fpjt_image", "source_file", "selected_response_mode",
                 "correct_one", "correct_both")

# Test block
test_rows <- rep(FALSE, nrow(df))
if ("response.keys" %in% names(df)) {
  test_rows <- !is.na(df$response.keys) & nzchar(trimws(as.character(df$response.keys)))
}

test_tbl <- data.frame(stringsAsFactors = FALSE)
if (any(test_rows)) {
  test_tbl <- df[test_rows, intersect(common_cols, names(df)), drop = FALSE]
  test_tbl$n_trial <- as_int(get_col(df[test_rows, , drop = FALSE], "trials_loop.thisTrialN")) + 1L
  test_tbl$fpjt_correct <- as_int(get_col(df[test_rows, , drop = FALSE], "response.corr"))
  test_tbl$fpjt_rt <- as_num(get_col(df[test_rows, , drop = FALSE], "response.rt"))
  test_tbl$trial_response <- as.character(get_col(df[test_rows, , drop = FALSE], "response.keys"))
}

if (nrow(test_tbl) == 0L) {
  stop("No FPJT test response rows found. Expected non-empty 'response.keys'.")
}

data_long_tbl <- test_tbl

# -------- Derive solution --------------------------------------------------
# In the experiment, correct_both is used when selected_response_mode == "Both hands";
# otherwise correct_one is used. If selected_response_mode is missing in a trial row,
# the first available subject-level selected_response_mode is used.

if (!"selected_response_mode" %in% names(data_long_tbl)) {
  data_long_tbl$selected_response_mode <- NA_character_
}

if ("selected_response_mode" %in% names(data_wide)) {
  mode_lookup <- data_wide$selected_response_mode
  names(mode_lookup) <- data_wide$subject_nr
  missing_mode <- is.na(data_long_tbl$selected_response_mode) | !nzchar(trimws(data_long_tbl$selected_response_mode))
  data_long_tbl$selected_response_mode[missing_mode] <- mode_lookup[as.character(data_long_tbl$subject_nr[missing_mode])]
}

if (all(c("correct_both", "correct_one") %in% names(data_long_tbl))) {
  data_long_tbl$solution <- ifelse(
    trimws(as.character(data_long_tbl$selected_response_mode)) == "Both hands",
    as.character(data_long_tbl$correct_both),
    as.character(data_long_tbl$correct_one)
  )
} else if ("correct_both" %in% names(data_long_tbl)) {
  data_long_tbl$solution <- as.character(data_long_tbl$correct_both)
} else if ("correct_one" %in% names(data_long_tbl)) {
  data_long_tbl$solution <- as.character(data_long_tbl$correct_one)
} else {
  data_long_tbl$solution <- NA_character_
  message("Warning: no correct_both/correct_one columns found. 'solution' set to NA.")
}

# -------- Keep only relevant columns --------------------------------------

wanted <- c("subject_nr", "n_trial", "item", "n_audios",
            "fpjt_correct", "fpjt_rt", "solution", "trial_response",
            "n_audio_false", "a2", "a3", "a4", "a5", "a6", "a7",
            "bodypart_false")

available <- intersect(wanted, names(data_long_tbl))
missing <- setdiff(wanted, available)

if (length(missing) > 0L) {
  message("Warning: missing columns - they will be omitted: ",
          paste(missing, collapse = ", "))
}

data_long_tbl <- data_long_tbl[, available, drop = FALSE]

# -------- Type adjustments (simple) ---------------------------------------

if ("subject_nr" %in% names(data_long_tbl)) {
  data_long_tbl$subject_nr <- as.factor(as.character(data_long_tbl$subject_nr))
}

for (col in c("n_trial", "n_audios", "fpjt_correct", "n_audio_false")) {
  if (col %in% names(data_long_tbl)) {
    data_long_tbl[[col]] <- as_int(data_long_tbl[[col]])
  }
}

if ("fpjt_rt" %in% names(data_long_tbl)) {
  data_long_tbl$fpjt_rt <- as_num(data_long_tbl$fpjt_rt)
}

for (col in c("item", "solution", "trial_response", "a2", "a3", "a4", "a5", "a6", "a7",
              "bodypart_false")) {
  if (col %in% names(data_long_tbl)) {
    data_long_tbl[[col]] <- as.factor(as.character(data_long_tbl[[col]]))
  }
}

# Sort rows by subject and trial number.
if (all(c("subject_nr", "n_trial") %in% names(data_long_tbl))) {
  data_long_tbl <- data_long_tbl[order(data_long_tbl$subject_nr,
                                       data_long_tbl$n_trial), , drop = FALSE]
  row.names(data_long_tbl) <- NULL
}

message("Created long table with ", nrow(data_long_tbl), " FPJT test trial row(s).")

# -------- Variable documentation ------------------------------------------
# data_long_tbl (one row per FPJT test trial) - columns:
#  - subject_nr             : participant ID : factor
#  - n_trial                : test trial index, 1-based : integer
#  - item                   : FPJT item identifier : factor
#  - n_audios               : number of auditory instructions in the trial : integer
#  - fpjt_correct           : correctness flag (1 = correct, 0 = incorrect) : integer
#  - fpjt_rt                : response time in seconds : numeric
#  - solution               : correct response key for selected response mode : factor
#  - trial_response         : key pressed by participant : factor
#  - n_audio_false          : instruction position containing the mismatch; 0 = no mismatch : integer
#  - a2-a7                  : body-part categories for auditory instructions 2-7 : factor
#  - bodypart_false         : body part containing the mismatch; none = no mismatch : factor
#
# data_wide (one row per subject) - columns:
#  - subject_nr             : participant ID : character
#  - language               : selected language : character
#  - selected_response_mode : response-mode setting : character
#  - selected_feedback      : feedback setting : character
#  - age                    : participant age in years : integer
#  - gender                 : participant gender coded as integer
#                             (female = 1, male = 2, transgender = 3, nonbinary = 4,
#                             other = 5, none = 6) : integer
#  - handedness             : participant handedness/laterality coded as integer
#                             (left = 1, ambidextrous = 2, right = 3) : integer
#  - handedness             : participant handedness/laterality slider response : integer
#  - n_CC                   : number of comprehension-check attempts : integer
#  - fam_accuracy           : familiarization accuracy, mean of famil_answer : numeric

# -------- Save results ----------------------------------------------------

output_file <- "data.rdata"
save(data_long_tbl, data_wide, file = output_file)

message("Saved data_long_tbl and data_wide to: ", file.path(getwd(), output_file))
