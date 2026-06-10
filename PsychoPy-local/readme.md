# FINAL POSITION JUDGEMENT TASK (FPJT)

**Author:** Carla Czilczer, 08/06/2026  
**Software used:** PsychoPy 2025.1.1  
**Experiment Type:** Local (offline)  
**Languages supported:** English (EN) = default, German (DE), Spanish (ES), French (FR). Further languages can be added, which requires simple changes in the code, updating the `.xlsx` files, and adding the respective `.wav` audio files (see [Language localization](#language-localization)).

---------------------------------------

## GENERAL INSTRUCTIONS

This experiment is built using [PsychoPy](https://www.psychopy.org/) (Builder) 2025.1.1 and is intended for **local execution**. Participants run the experiment directly on the experiment computer. No internet connection is required. Please check the version you are using, as older PsychoPy versions might crash or behave unexpectedly.  

If you are unfamiliar with PsychoPy, please refer to the [documentation](https://www.psychopy.org/documentation.html) on their website. This README specifically details the structure and customization of this [FPJT](https://osf.io/4sw6h) implementation.

---------------------------------------

## SETUP INSTRUCTIONS

To edit or run this task, you need to have **PsychoPy** installed.  

PsychoPy exports results directly as `.csv` plus `.log` / `.psydat` (depending on run mode).
A script for data preparation in [R](https://www.r-project.org/) (4.5.2) is provided.

**Step-by-step instructions:**
1. **Download** and unzip the repository to a dedicated folder.
2. **Open PsychoPy**, then open the experiment file `FPJT_local.psyexp` in Builder.
3. Click the green **Run** button to start the experiment.
4. Participants **complete** the experiment locally.
5. Data is automatically **saved** into the `data/` folder.
6. **Process the data** using the provided `data-prep.R` script.

---------------------------------------

## LANGUAGE LOCALIZATION

This experiment uses external spreadsheet files to manage text and translations. This makes adding new languages relatively easy, but strict formatting rules apply.

The language can be selected via the PsychoPy startup dialog (Experiment Info; see [Experiment settings](#experiment-settings-parameters-to-choose)). The experiment then uses the corresponding _ISO_code_ (e.g., `EN`, `DE`) to retrieve the corresponding text from columns in the external message sheet.

- `Language_localiser.xlsx` maps a **language** to an **ISO_code**.
- The message sheet (e.g., `fpjt_files/Messages.xlsx`) contains one column per ISO_code (e.g., `EN`, `DE`) and is iterated to populate the global text variables used across routines.

### Adding a new language

#### 1. Open the relevant files
- `Language_localiser.xlsx`
- `fpjt_files/Messages.xlsx`

#### 2. Extend `Language_localiser.xlsx` by adding a new row

The file must contain the columns:
- `language`
- `ISO_code`

Example:

| language | ISO_code |
| :--- | :--- |
| English | EN |
| German | DE |

Add your new language (e.g., Italian) in a **new row**:

| language | ISO_code |
| :--- | :--- |
| English | EN |
| German | DE |
| Italian | IT |

#### 3. Extend `fpjt_files/Messages.xlsx` by adding a new column

The file must contain:
- a `message` column (variable names used inside PsychoPy), and
- one column per language (named by _ISO_code_)

Example:

| message | EN | DE |
| :--- | :--- | :--- |
| welcome_msg | Welcome to the task! | Willkommen zur Aufgabe! |
| adv_msg | Press SPACE to continue | Drücken Sie SPACE zum Fortfahren |

Add a **new column** using the ISO code (`IT`) and enter translations:

| message | EN | DE | IT |
| :--- | :--- | :--- | :--- |
| welcome_msg | Welcome to the task! | Willkommen zur Aufgabe! | Benvenuti al compito! |
| adv_msg | Press SPACE to continue | Drücken Sie die LEERTASTE | Premi SPAZIO per continuare |

⚠️ Do this consistently for **all** message keys used by the experiment.

#### 4. Generate audio and add to `fpjt_audios/` folder

For each additional language, the corresponding **audio instructions** must be generated and added. These audio files correspond to the auditory movement instructions. One audio is used to calibrate volume, and one is used in the familiarization.

Save the files in the `fpjt_audios/` folder as **mono `.wav` files** and append the ISO code using an underscore, e.g.,  
`testsound_IT.wav`, `right_arm_side_IT.wav`, `left_arm_side_IT.wav`, …

It is important that these are **`.wav`** files and that the **exact ISO_code** is used in the filenames — otherwise the experiment will not find the audio resources.

Required audio message keys / filenames (base name without ISO suffix):

- `testsound`
- `right_arm_side`
- `left_arm_side`
- `right_arm_front`
- `left_arm_front`
- `right_arm_up`
- `left_arm_up`
- `right_leg_side`
- `left_leg_side`
- `right_leg_front`
- `left_leg_front`
- `right_leg_back`
- `left_leg_back`
- `torso_right`
- `torso_left`
- `head_up`
- `head_down`
- `fam_solution_msg`

The text corresponding to these audio files is also included in `Messages.xlsx`.

#### 5. Update the experiment

1. Open `FPJT_local.psyexp`
2. Go to **Experiment Settings** (cogwheel icon) → Basic → Experiment info
3. Update the `language` entry by adding your new language name (e.g., `Italian`). It must exactly match the entry in `Language_localiser.xlsx`.
4. Save the experiment.

---

> ⚠️ **Important:** Do **not** change folder or file names. Do not rename variables. Do not move files after decompressing the repository. The experiment depends on exact paths and identifiers. Moving or renaming files may cause crashes.

---------------------------------------

## TECHNICAL DETAILS

The decompressed repository includes:

- `FPJT_local.psyexp` — main PsychoPy experiment file
- `Language_localiser.xlsx` — language configuration file
- `data-prep.R` — R script that reads all downloaded `.csv` files automatically, generates a `data.rdata` file, and stores it in the `data` folder. `data.rdata` contains FPJT testblock data in long format and demographic / summary data in wide format.

**Folder `fpjt_files`:**
- `Messages.xlsx`
- `Famil_trials.xlsx`
- `Practice_trials.xlsx`
- `Testblock_trials.xlsx`
- `Practice_audios.xlsx`
- `Testblock_audios.xlsx`

**Folder `fpjt_images`:**
- stimulus and instruction images

**Folder `fpjt_audios`:**
- calibration, instruction, and feedback audio

**Folder `data`:**
- storage location for downloaded data

---------------------------------------

## EXPERIMENT SETTINGS (parameters to choose)

The experimenter selects settings in the PsychoPy startup dialog.

### Available parameters

| Variable | Options | Description |
| :--- | :--- | :--- |
| `language` |• **English** (default)<br>• German<br>• Spanish<br>• French | Participant-selectable language |
| `response_mode` |• **Both hands** (default)<br>• Left hand<br>• Right hand | Input method (experimenter-defined) |
| `feedback` |• Yes<br>• **No feedback in testblock** (default) | Feedback behavior in test block (experimenter-defined) |

### Setting default values (code-based)

Defaults are controlled in the experiment code.

For **language**, **response_mode**, and **feedback**:

1. Open the corresponding code component in the settings routine
2. Set your default value
3. Comment out the lines that overwrite the default with dialog input

This forces the experiment to use your hard-coded defaults.

### Disable demographic questions

The experiment includes Age, Gender, and Handedness questions by default. These support normative data collection.

If you do not want to collect demographics:

1. Click `demographics` routine
2. Open **Routine settings**
3. In **Testing** tab → click **Disable Routine**

#### Saving

1. Save the experiment
2. Run locally via PsychoPy

---------------------------------------

## PARTICIPANT WORKFLOW

Starts after the experimenter selected the **experiment settings:** language, response_mode, feedback
1. **Welcome screen**
2. **Demographics**
3. **Audio calibration**
4. **Familiarization**
5. **Instructions + comprehension check**
6. **Practice block**
7. **Test block**
8. **Completion screen**

### FPJT trial procedure

1. Instruction audio sequence
2. Transition screen (“open eyes”)
3. Fixation cross
4. Stimulus + response collection
5. Feedback (optional in testblock)
6. Advance via spacebar press

---------------------------------------

## OUTPUT
All data is saved locally inside the `data/` folder.

Each run generates:

- `.csv` data file
- `.log`
- `.psydat`

---------------------------------------

The provided `data-prep.R` script is designed to read all `.csv` files in the the `data/` folder, extract relevant observations from the FPJT test block, and save the processed data as `data.rdata` in the `data` folder.

**To run the data preparation**, open `data-prep.R` and **source** the script.

The script will generate `data.rdata`, which contains two dataframes: `data_long_tbl` (trial-level FPJT test data) and `data_wide` (demographics and summary data).

> **Note:** This script relies on the standard PsychoPy output structure. It expects a participant ID column (`participant` or `subject_nr`) and standard FPJT response columns such as `response.keys`, `response.corr`, and `response.rt`. If modifications were made beyond the configurable experiment settings, the code may need adaptation. Raw data should always be inspected and cleaned of outliers or errors prior to statistical analysis.

### Variable Documentation

#### 1. Testblock Trials Data (`data_long_tbl`)
*Contains one row per FPJT test trial. Practice trials are not included.*

| Variable Name | Type | Description |
| :--- | :--- | :--- |
| `subject_nr` | factor | Participant ID. |
| `n_trial` | integer | Test trial index, 1-based. |
| `item` | factor | FPJT item identifier. |
| `n_audios` | integer | Number of auditory instructions in the trial. |
| `fpjt_correct` | integer | Correctness flag (1 = correct, 0 = incorrect). |
| `fpjt_rt` | numeric | Response time in seconds. |
| `solution` | factor | Correct response key for the selected response mode. |
| `trial_response` | factor | Key pressed / response code (participant response). |
| `n_audio_false` | integer | Instruction position containing the mismatch; 0 = no mismatch. |
| `a2`–`a7` | factor | Body-part categories for auditory instructions 2–7. |
| `bodypart_false` | factor | Body part containing the mismatch; `none` = no mismatch. |

#### 2. Demographic and Summary Data (`data_wide`)
*Contains one row per subject.*

| Variable Name | Type | Description |
| :--- | :--- | :--- |
| `subject_nr` | character | Participant ID. |
| `language` | character | Selected language. |
| `selected_response_mode` | character | Response-mode setting. |
| `selected_feedback` | character | Feedback setting. |
| `age` | integer | Participant age in years. |
| `gender` | integer | Participant gender coded as integer (female = 1, male = 2, transgender = 3, nonbinary = 4, other = 5, none = 6). |
| `handedness` | integer | Participant handedness/laterality coded as integer (left = 1, ambidextrous = 2, right = 3). |
| `n_CC` | integer | Number of comprehension-check attempts. |
| `fam_accuracy` | numeric | Familiarization accuracy, computed as the mean of `famil_answer` across familiarization trials. |

---------------------------------------

PsychoPy version updates may require adjustments.  Developers are not responsible for adapting the task to every use case.  
Before collecting data, always test the experiment and check the data output.
Contributions are welcome.

---------------------------------------

## REFERENCE

Please cite [Czilczer et al. (2025)](https://osf.io/9xjfb) when using this resource.


