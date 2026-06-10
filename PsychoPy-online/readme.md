# FINAL POSITION JUDGEMENT TASK (FPJT)

**Author:** Carla Czilczer, 08/06/2026  
**Software used:** PsychoPy 2025.1.1  
**Experiment Type:** Online  
**Languages supported:** English (EN) = default, German (DE), Spanish (ES), French (FR). Further languages can be added, which requires simple changes in the code, updating the `.xlsx` files, and adding the respective `.wav` audio files (see [Language localization](#language-localization)).

---------------------------------------

## GENERAL INSTRUCTIONS

This experiment is built using [PsychoPy](https://www.psychopy.org/) (Builder) 2025.1.1. To run this experiment online, it utilizes PsychoPy’s **PsychoJS** export and is typically hosted via [Pavlovia](https://pavlovia.org/). Please check the version you are using, as older PsychoPy / PsychoJS versions might crash or behave unexpectedly.  
If you are unfamiliar with PsychoPy, please refer to the [documentation](https://www.psychopy.org/documentation.html) on their website. This README specifically details the structure and customization of this [FPJT](https://osf.io/4sw6h) implementation.

---------------------------------------

## SETUP INSTRUCTIONS

To edit or run this task, you need to have **PsychoPy** installed.  
To run the task online, you will need a hosting solution for PsychoJS (most commonly **Pavlovia**).  
PsychoPy exports results directly as `.csv` plus `.log` / `.psydat` (depending on run mode).
A script for data preparation in [R](https://www.r-project.org/) (4.5.2) is provided.

**Step-by-step instructions:**
1. **Download** and unzip the repository to a dedicated folder.
2. **Open PsychoPy**, then open the experiment file `FPJT_online.psyexp` in Builder.
3. To run online, use PsychoPy’s **Pavlovia** workflow (e.g., “Pavlovia → Sync” / “Export HTML”), and follow the standard PsychoPy/Pavlovia procedure to create/sync a Pavlovia project.
4. Click the **Run** button to test in browser (debugging only; not recommended for online data collection).
5. **Distribute** the generated study link to your participants. They run the task directly in their web browser.
6. **Download the data** from the Pavlovia project dashboard (Results/Data export).
7. **Place all downloaded `.csv` files** in the `data` folder located inside the unzipped repository. The `data-prep.R` script reads all `.csv` files in this folder automatically.
8. **Process the data** using the provided `data-prep.R` script.

---------------------------------------

## LANGUAGE LOCALIZATION

This experiment uses external spreadsheet files to manage text and translations. This makes adding new languages relatively easy, but strict formatting rules apply.

Participants select their preferred language via the PsychoPy startup dialog (Experiment Info; see [Letting participants select settings](#experiment-settings-parameters-to-choose)). The experiment then uses the corresponding _ISO_code_ (e.g., `EN`, `DE`) to retrieve the corresponding text from columns in the external message sheet.

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

1. Open `FPJT_online.psyexp`
2. Go to **Experiment Settings** (cogwheel icon) → Basic → Experiment info
3. Update the `language` entry by adding your new language name (e.g., `Italian`). It must exactly match the entry in `Language_localiser.xlsx`.
4. Save the experiment.

#### 6. Sync the updated experiment to Pavlovia

Use **Pavlovia → Sync** to rebuild and upload the updated files to the online project. If changes don’t appear, clear your browser cache or open the task in an incognito window to force a fresh download.

---

> ⚠️ **Important:** Do **not** change folder or file names. Do not rename variables. Do not move files after decompressing the repository. The online version relies on exact paths and identifiers; any deviation can cause crashes.

---------------------------------------

## TECHNICAL DETAILS

The decompressed repository includes:

- `FPJT_online.psyexp` — main PsychoPy experiment file
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

In the default configuration, participants can select their `language` upon starting the experiment. This is configured via **Experiment Settings → Experiment info → `language`** (see below for more information).  
`response_mode` and `feedback` are experimenter-defined defaults set in code.

### Available parameters

| Variable | Options | Description |
| :--- | :--- | :--- |
| `language` |• **English** (default)<br>• German<br>• Spanish<br>• French | Participant-selectable language |
| `response_mode` |• **Both hands** (default)<br>• Left hand<br>• Right hand | Input method (experimenter-defined) |
| `feedback` |• Yes<br>• **No feedback in testblock** (default) | Feedback behavior in test block (experimenter-defined) |

### Changing defaults

#### 1. Default `response_mode`

1. Click `experiment_settings` routine
2. Open code component `response_mode`
3. Edit in **Begin experiment**

#### 2. Default `feedback`

1. Click `experiment_settings` routine
2. Open code component `feedback`
3. Edit in **Begin experiment**

#### 3. Disable language selection

To hard-code a default language:

1. Experiment Settings → Basic → remove `language` entry
2. Open `load_language` routine
3. Code component `update_language_code`
4. Set default in **Begin experiment**
5. Comment out lines 2–3 in **Begin routine**

### Disable demographic questions

The experiment includes Age, Gender, and Handedness questions by default. These support normative data collection.

If you do not want to collect demographics:

1. Click `demographics` routine
2. Open **Routine settings**
3. In **Testing** tab → click **Disable Routine**

#### Saving and exporting

1. Save experiment
2. Sync via Pavlovia
3. Test via **Run on Pavlovia**
4. Distribute link

---------------------------------------

## PARTICIPANT WORKFLOW

1. **Settings selection:** Participants select language
2. **Welcome screen**
3. **Demographics**
4. **Audio calibration**
5. **Familiarization**
6. **Instructions + comprehension check**
7. **Practice block**
8. **Test block**
9. **Completion screen**

### FPJT trial procedure

1. Instruction audio sequence
2. Transition screen (“open eyes”)
3. Fixation cross
4. Stimulus + response collection
5. Feedback (optional in testblock)
6. Advance via spacebar press

---------------------------------------

## OUTPUT
For online runs, data is stored on the selected server/host and can be downloaded from the project’s interface. The output is typically downloaded as one `.csv` file per participant/run.

Store these `.csv` files in the dedicated `data` folder located inside the unzipped repository. The provided `data-prep.R` script is designed to read all `.csv` files in this folder, extract relevant observations from the FPJT test block, and save the processed data as `data.rdata` in the `data` folder.

**To run the data preparation**, open `data-prep.R` and **source** the script.

The script will generate `data.rdata`, which contains two dataframes: `data_long_tbl` (trial-level FPJT test data) and `data_wide` (demographics and summary data).

> **Note:** This script relies on the standard PsychoPy/Pavlovia output structure. It expects a participant ID column (`participant` or `subject_nr`) and standard FPJT response columns such as `response.keys`, `response.corr`, and `response.rt`. If modifications were made beyond the configurable experiment settings, the code may need adaptation. Raw data should always be inspected and cleaned of outliers or errors prior to statistical analysis.

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

PsychoPy / PsychoJS version updates may require adjustments.  Developers are not responsible for adapting the task to every use case.  
Before collecting data, always test the experiment and check the data output.
Contributions are welcome.

---------------------------------------

## REFERENCE

Please cite [Czilczer et al. (2025)](https://osf.io/9xjfb) when using this resource.

