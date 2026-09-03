# -------------------------------------------------------------------------
# Title:    Data preparation - FPJT OpenSesame online
# Author:   Carla Czilczer
# Date:     03.09.2026
# R ver.:   4.5.2
#
# Purpose:
# Prepare OpenSesame online experiment output (JSON in data.txt) so that:
# - trial-level FPJT test data are available in long format (data_long_tbl)
# - demographic and summary data are summarized in wide format (data_wide)
#
# Usage:
# Place this script next to a folder named "data".
# The data folder must contain one file named "data.txt". This file may
# contain the data of multiple participants.
# The script writes data.rdata containing data_long_tbl and data_wide.
# -------------------------------------------------------------------------

# =========================================================================
# PREPARATIONS
# =========================================================================
# setwd()

# Clear workspace
rm(list = ls())

# Dependencies (install if missing)
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  install.packages("jsonlite", repos = "https://cloud.r-project.org")
}

library(jsonlite)

# The JATOS export contains one separate JSON object per line.
json_lines <- readLines(
  "data/data.txt",
  warn = FALSE,
  encoding = "UTF-8"
)

# Remove empty lines if present.
json_lines <- json_lines[nzchar(trimws(json_lines))]

if (length(json_lines) == 0L) {
  stop("Input file is empty: data/data.txt")
}

# Read all participants and combine their trial data.
json <- lapply(json_lines, fromJSON, flatten = TRUE)

df <- rbind_pages(lapply(json, function(x) {
  as.data.frame(x$data, stringsAsFactors = FALSE)
}))

message("Loaded ", nrow(df), " rows and ", ncol(df), " columns.")

# =========================================================================
# DATA WRANGLING
# =========================================================================

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

get_col <- function(df, col) {
  if (col %in% names(df)) df[[col]] else rep(NA, nrow(df))
}

first_available_col <- function(df, candidates) {
  for (col in candidates) {
    if (col %in% names(df)) {
      values <- as.character(df[[col]])
      if (any(!is.na(values) & nzchar(trimws(values)) & values != "NaN")) {
        return(col)
      }
    }
  }
  NA_character_
}

if (!"subject_nr" %in% names(df)) {
  stop("Required participant ID column 'subject_nr' is missing.")
}

df$subject_nr <- as.character(df$subject_nr)
df <- df[!is.na(df$subject_nr) & nzchar(trimws(df$subject_nr)), , drop = FALSE]

# -------- Demographics and summaries (wide) --------------------------------

subjects <- unique(df$subject_nr)
data_wide <- data.frame(subject_nr = subjects, stringsAsFactors = FALSE)

# Language; use selected_language only as fallback for older output files.
language_col <- first_available_col(df, c("language", "selected_language"))
data_wide$language <- vapply(subjects, function(s) {
  if (is.na(language_col)) return(NA_character_)
  first_nonempty(df[[language_col]][df$subject_nr == s])
}, FUN.VALUE = character(1), USE.NAMES = FALSE)

for (out_col in c("selected_response_mode", "selected_feedback",
                  "age", "gender", "handedness")) {
  data_wide[[out_col]] <- vapply(subjects, function(s) {
    first_nonempty(get_col(df[df$subject_nr == s, , drop = FALSE], out_col))
  }, FUN.VALUE = character(1), USE.NAMES = FALSE)
}

data_wide$age <- as_int(data_wide$age)

# Number of comprehension-check attempts.
# max() is used because CC_attempt starts at 0 and increases with each attempt.
data_wide$n_CC <- vapply(subjects, function(s) {
  vals <- as_int(get_col(df[df$subject_nr == s, , drop = FALSE], "CC_attempt"))
  vals <- vals[!is.na(vals)]
  if (length(vals) > 0L) max(vals) else NA_integer_
}, FUN.VALUE = integer(1), USE.NAMES = FALSE)

# Familiarization accuracy: mean across familiarization trial rows only.
data_wide$fam_accuracy <- vapply(subjects, function(s) {
  subject_rows <- df$subject_nr == s
  if ("phase" %in% names(df)) {
    subject_rows <- subject_rows & as.character(df$phase) == "familiarisation"
  }
  vals <- as_num(get_col(df[subject_rows, , drop = FALSE], "famil_answer"))
  vals <- vals[!is.na(vals)]
  if (length(vals) > 0L) mean(vals) else NA_real_
}, FUN.VALUE = numeric(1), USE.NAMES = FALSE)

message("Created wide table with ", nrow(data_wide), " participant(s).")

# -------- Create trial-level (long) table ---------------------------------
# Practice trials are not included in data_long_tbl.

if ("block_type" %in% names(df)) {
  test_rows <- !is.na(df$block_type) & as.character(df$block_type) == "testblock"
} else if ("phase" %in% names(df)) {
  test_rows <- !is.na(df$phase) & as.character(df$phase) == "test"
} else {
  stop("No 'block_type' or 'phase' column found to identify FPJT test trials.")
}

test_df <- df[test_rows, , drop = FALSE]

if (nrow(test_df) == 0L) {
  stop("No FPJT test trial rows found.")
}

# The following item variables must be logged by the experiment because the
# randomized item order cannot be reconstructed afterwards from response data.
required_item_cols <- c("item", "n_audios", "n_audio_false",
                        "a2", "a3", "a4", "a5", "a6", "a7",
                        "bodypart_false")
missing_item_cols <- setdiff(required_item_cols, names(test_df))

if (length(missing_item_cols) > 0L) {
  stop("Required FPJT item columns are missing from the OpenSesame data: ",
       paste(missing_item_cols, collapse = ", "),
       "\nThese variables must be initialized before the automatic logger is prepared. ",
       "The randomized item order cannot be reconstructed from this file.")
}

# Use the FPJT variables directly. Raw OpenSesame response columns are retained
# only as fallbacks for files created before the short variables were logged.
correct_col <- first_available_col(test_df, c("fpjt_correct", "correct_test_response"))
rt_col <- first_available_col(test_df, c("fpjt_rt", "response_time_test_response"))
response_col <- first_available_col(test_df, c("trial_response", "response_test_response"))

if (is.na(correct_col) || is.na(rt_col) || is.na(response_col)) {
  stop("Required FPJT response columns are missing. Expected fpjt_correct/fpjt_rt/",
       "trial_response or the corresponding OpenSesame response columns.")
}

data_long_tbl <- data.frame(
  subject_nr = as.character(test_df$subject_nr),
  n_trial = as_int(get_col(test_df, "n_trial")),
  item = as.character(test_df$item),
  n_audios = as_int(test_df$n_audios),
  fpjt_correct = as_int(test_df[[correct_col]]),
  fpjt_rt = as_num(test_df[[rt_col]]) / 1000,
  solution = as.character(get_col(test_df, "correct_key")),
  trial_response = tolower(as.character(test_df[[response_col]])),
  n_audio_false = as_int(test_df$n_audio_false),
  a2 = as.character(test_df$a2),
  a3 = as.character(test_df$a3),
  a4 = as.character(test_df$a4),
  a5 = as.character(test_df$a5),
  a6 = as.character(test_df$a6),
  a7 = as.character(test_df$a7),
  bodypart_false = as.character(test_df$bodypart_false),
  stringsAsFactors = FALSE
)

# Derive trial number from row order only if n_trial is unavailable.
if (all(is.na(data_long_tbl$n_trial))) {
  data_long_tbl$n_trial <- ave(
    seq_len(nrow(data_long_tbl)),
    data_long_tbl$subject_nr,
    FUN = seq_along
  )
  data_long_tbl$n_trial <- as_int(data_long_tbl$n_trial)
}

# Derive the correct key only as a fallback for older output files.
missing_solution <- is.na(data_long_tbl$solution) |
  !nzchar(trimws(data_long_tbl$solution)) |
  data_long_tbl$solution == "NaN"

if (any(missing_solution)) {
  response_mode <- as.character(get_col(test_df, "selected_response_mode"))
  for (i in which(missing_solution)) {
    response <- data_long_tbl$trial_response[i]
    correct <- data_long_tbl$fpjt_correct[i]
    keys <- if (!is.na(response_mode[i]) &&
                trimws(response_mode[i]) == "Both hands") c("s", "l") else c("g", "h")
    
    if (!is.na(correct) && correct == 1L && response %in% keys) {
      data_long_tbl$solution[i] <- response
    } else if (!is.na(correct) && correct == 0L && response %in% keys) {
      data_long_tbl$solution[i] <- setdiff(keys, response)[1]
    }
  }
}

# Number of movements: the first audio specifies the starting position.
data_long_tbl$n_movements <- data_long_tbl$n_audios - 1L

# Place n_movements directly after n_audios.
wanted <- c("subject_nr", "n_trial", "item", "n_audios", "n_movements",
            "fpjt_correct", "fpjt_rt", "solution", "trial_response",
            "n_audio_false", "a2", "a3", "a4", "a5", "a6", "a7",
            "bodypart_false")

data_long_tbl <- data_long_tbl[, wanted, drop = FALSE]

# -------- Type adjustments -------------------------------------------------

data_long_tbl$subject_nr <- as.factor(data_long_tbl$subject_nr)

for (col in c("n_trial", "n_audios", "n_movements",
              "fpjt_correct", "n_audio_false")) {
  data_long_tbl[[col]] <- as_int(data_long_tbl[[col]])
}

data_long_tbl$fpjt_rt <- as_num(data_long_tbl$fpjt_rt)

for (col in c("item", "solution", "trial_response", "a2", "a3", "a4",
              "a5", "a6", "a7", "bodypart_false")) {
  data_long_tbl[[col]] <- as.factor(as.character(data_long_tbl[[col]]))
}

# Sort rows by subject and trial number.
data_long_tbl <- data_long_tbl[order(data_long_tbl$subject_nr,
                                     data_long_tbl$n_trial), , drop = FALSE]
row.names(data_long_tbl) <- NULL

message("Created long table with ", nrow(data_long_tbl), " FPJT test trial row(s).")

# -------- Variable documentation ------------------------------------------
# data_long_tbl (one row per FPJT test trial) - columns:
#  - subject_nr             : participant ID : factor
#  - n_trial                : test trial index, 1-based : integer
#  - item                   : FPJT item identifier : factor
#  - n_audios               : number of auditory instructions : integer
#  - n_movements            : number of movements (n_audios - 1) : integer
#  - fpjt_correct           : correctness flag (1 = correct, 0 = incorrect) : integer
#  - fpjt_rt                : response time in seconds : numeric
#  - solution               : correct response key for selected response mode : factor
#  - trial_response         : key pressed by participant : factor
#  - n_audio_false          : mismatch position; 0 = no mismatch : integer
#  - a2-a7                  : body-part categories for instructions 2-7 : factor
#  - bodypart_false         : body part containing the mismatch; none = no mismatch : factor
#
# data_wide (one row per subject) - columns:
#  - subject_nr             : participant ID : character
#  - language               : selected language : character
#  - selected_response_mode : response-mode setting : character
#  - selected_feedback      : feedback setting : character
#  - age                    : participant age in years : integer
#  - gender                 : participant gender code (f, m, d) : character
#  - handedness             : handedness code (l, r, b) : character
#  - n_CC                   : number of comprehension-check attempts : integer
#  - fam_accuracy           : familiarization accuracy : numeric

# -------- Save results -----------------------------------------------------
rm(list = c("df", "json", "test_df")) # clean environment

output_file <- "data/data.rdata"
save(data_long_tbl, data_wide, file = output_file)

message("Saved data_long_tbl and data_wide to: ", file.path(getwd(), output_file))
