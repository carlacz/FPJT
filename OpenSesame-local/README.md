# FINAL POSITION JUDGEMENT TASK (FPJT)

**Author:** Carla Czilczer, 29/08/2026  
**Software used:** OpenSesame 4.1.6  
**Experiment Type:** Local (offline)  
**Languages supported:** English (EN) = default, German (DE), Spanish (ES), and French (FR). Further languages can be added by updating the `.xlsx` files and adding the corresponding `.wav` audio files (see [Language localization](#language-localization)).

---

## GENERAL INSTRUCTIONS

This experiment was built using [OpenSesame](https://osdoc.cogsci.nl/) 4.1.6 and uses the [xpyriment backend](https://osdoc.cogsci.nl/4.1/manual/backends/) for local execution. Participants run the experiment directly on the experiment computer. No internet connection is required.

Please check the OpenSesame version you are using, as older versions may crash or behave unexpectedly.

If you are unfamiliar with OpenSesame, please refer to the [OpenSesame documentation](https://osdoc.cogsci.nl/). This README specifically describes the structure and customization of this [FPJT](https://osf.io/4sw6h) implementation.

---

## SETUP INSTRUCTIONS

To edit or run this task locally, **OpenSesame 4.1.6 or later** must be installed on the data-collection computer.

A script for data preparation in [R](https://www.r-project.org/) 4.5.2 is provided.

> ⚠️ **Important audio setting:** Before starting the experiment, set the system volume of the local device to **90%**. The participant can then adjust the task-specific audio volume during the built-in volume-calibration procedure. Do not change the system volume after the experiment has started.

### Step-by-step instructions

1. **Download** and unzip the complete repository into a dedicated folder. Do not place unrelated experiment files in this folder.
2. Set the system volume of the local device to **90%**.
3. **Open OpenSesame**, then open the experiment file `FPJT_local.osexp`.
4. If required, **adapt the experiment settings** and save the experiment.
5. Use the standard **Run full-screen** option to start the experiment.
6. Enter a unique subject number when prompted.
7. Save the output file in the `data/` folder using the standard filename `subject-<subject_nr>.csv`,.
8. **Do not rename the output files.** The provided `data-prep.R` script reads files whose names begin with `subject-`.
9. **Process the data** using the provided `data-prep.R` script.

The OpenSesame Quick Run option may be used for debugging, but it should not be used for actual data collection.

---

## LANGUAGE LOCALIZATION

This experiment uses external spreadsheet files and language-specific audio files to manage text, translations, and audio instructions.

At the beginning of each run, the experimenter selects the participant's preferred language. The experiment reads the available language names dynamically from `Language_localiser.xlsx`. It then uses the corresponding `ISO_code` to retrieve the appropriate texts from `Messages.xlsx` and the corresponding audio files from the OpenSesame File Pool.

- `Language_localiser.xlsx` maps each language name to an `ISO_code`.
- `Messages.xlsx` contains the texts displayed during the experiment.
- Language-specific audio filenames contain the corresponding ISO code, for example `_EN`, `_DE`, `_ES`, or `_FR`.

### Adding a new language 

#### 1. Open the relevant files
- `Language_localiser.xlsx`
- `Messages.xlsx`
#### 2. Extend `Language_localiser.xlsx` by adding a new row
| language | ISO_code |
| :--- | :--- | 
| English | EN | 
| German | DE | 

Add your new language (e.g., Italian) by inserting the _language_ and _ISO_code_ in a **new row**:
| language | ISO_code |
| :--- | :--- | 
| English | EN | 
| German | DE | 
| Italian | IT |
#### 3. Extend `Messages.xlsx`

`Messages.xlsx` must contain:
- a `message` column containing the variable names used by OpenSesame;
- one column for each language, identified by its `ISO_code`.
Example:

| message | EN | DE |
| :--- | :--- | :--- |
| welcome_msg | Welcome to the task! | Willkommen zur Aufgabe! |
| adv_msg | Press SPACE to continue | Drücken Sie die LEERTASTE, um fortzufahren |

Add a new column using the new ISO code and enter the translations:

| message | EN | DE | IT |
| :--- | :--- | :--- | :--- |
| welcome_msg | Welcome to the task! | Willkommen zur Aufgabe! | Benvenuti al compito! |
| adv_msg | Press SPACE to continue | Drücken Sie die LEERTASTE, um fortzufahren | Premere SPAZIO per continuare |

Translations must be added consistently for **all message keys** used by the experiment.

Existing HTML formatting should be retained. Commonly used HTML tags include:

- `<b>Text</b>` for **bold text**
- `<i>Text</i>` for *italic text*
- `<br>` for a line break
- `<span style='color:red'>Text</span>` for colored text

If you do not use HTML tags, the formatting will not appear correctly in the experiment.  
When adding a new language, you must manually insert line breaks using `<br>` within the cell. Otherwise, longer instructions will be truncated.

#### 4. Generate and add the audio files

The corresponding audio files must be generated for every additional language.

Save the files as **mono `.wav` files** and append the exact ISO code using an underscore, for example:

- `solution_IT.wav`
- `straight_IT.wav`
- `right_arm_side_IT.wav`
- `left_leg_front_IT.wav`

Required language-specific audio base names include:
- `solution`
- `straight`
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

The filenames must use the exact ISO code entered in `Language_localiser.xlsx`. Otherwise, OpenSesame will not find the corresponding audio resources.

The text corresponding to these audio files is also included in `Messages.xlsx`.

#### 5. Reload the updated files into the OpenSesame File Pool

1. Open `FPJT_local.osexp`.
2. Open the **File Pool**.
3. Replace the existing versions of:
   - `Language_localiser.xlsx`
   - `Messages.xlsx`
4. Add all new language-specific `.wav` files.
5. Save the experiment.

> ⚠️ **Important:** Do not rename folders, files, variables, spreadsheet columns, or message keys. The experiment depends on exact paths and identifiers. Renaming or moving resources may cause the experiment to crash.

For additional information, see the [OpenSesame Language Localisation Demo](https://github.com/carlacz/OpenSesame_Language-Localisation-Demo/tree/main/Language_localiser_local).

---

## TECHNICAL DETAILS

The decompressed repository includes:

- `FPJT_local.osexp` — main OpenSesame experiment file
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

The `.osexp` file contains these resources in its File Pool. If a resource is edited outside OpenSesame, the updated file must be reloaded into the File Pool.

---

## EXPERIMENT SETTINGS

The experimenter selects the experiment settings at the beginning of each run.

The corresponding items are located in the `experiment_settings` sequence in the OpenSesame Overview.

### Available parameters

| Variable | Options | Description |
| :--- | :--- | :--- |
| `language` | • **English** (default)<br>• German<br>• Spanish<br>• French | Language used for instructions and audio. The available options are read dynamically from `Language_localiser.xlsx`. |
| `response_mode` | • **Both hands** (default)<br>• Left hand<br>• Right hand | Determines the response keys and input method. Both-hands responses use `S` and `L`; one-hand responses use `G` and `H`. |
| `feedback` | • Yes<br>• **No feedback in testblock** (default) | Determines whether trial-by-trial feedback is presented during the test block. Practice feedback is always presented. |

### Disable parameter selection

Instead of selecting the settings at the beginning of every run, defaults can be fixed in the experiment.

1. Open the `experiment_settings` sequence.
2. Locate the relevant selection item:
   - `language_localiser`
   - `response_mode`
   - `feedback_setting`
3. Change its **Run if** expression from `True` to `False`.
4. Change the defaults

Defaults are defined in lines 7 to 9 of the `preparations` inline script:
For example: 
```python
selected_language = "English"
selected_response_mode = "Both hands"
selected_feedback = "No feedback in testblock"
```

The selected language name must exactly match an entry in `Language_localiser.xlsx`. The corresponding ISO code is determined automatically by the experiment.

Do not modify other parts of the `preparations` script unless you also adapt the corresponding experiment logic.

### Disable demographic questions

The experiment includes questions about age, gender, and handedness. These questions support the collection of normative data.

To disable them:

1. Open the `experiment` sequence.
2. Locate `demographics_sequence`.
3. Change its **Run if** expression from `True` to `False`.

### Saving and testing

After changing settings or adding a language:

1. Save `FPJT_local.osexp`.
2. Use Quick Run to check the basic experiment flow.
3. Perform at least one complete full-screen test.
4. Inspect the generated `.csv` file before collecting data.

---

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

---

## OUTPUT

For each run, OpenSesame creates one `.csv` file containing the automatically logged experiment variables.

Save every data-collection file in the `data/` folder using the following naming format:

```text
subject-<subject_nr>.csv
```

Examples:

```text
subject-1.csv
subject-2.csv
subject-003.csv
```

Do not rename these files. The provided `data-prep.R` script reads all `.csv` files in the `data/` folder whose filenames begin with `subject-`.

### Data preparation
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
| `n_audios` | integer | Number of auditory instructions in the trial. (4-7; includes starting position audio) |
| `n_movements` | integer | Number of movements in the trial. (3-6) |
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

OpenSesame version updates may require adjustments in the experiment file. 
As developers, we are not responsible to implementing the task in every use case.  
Before collecting data, always test the display geometry, stylus responses, timing, localized instructions, audio, and data output.  
Feel free to contribute!

---

## REFERENCE

Please cite [Czilczer, MorenoVerdú, et al. (2026)](https://osf.io/9xjfb) when using this resource.

