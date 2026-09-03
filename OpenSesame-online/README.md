# FINAL POSITION JUDGEMENT TASK (FPJT)

**Author:** Carla Czilczer, 03/09/2026  
**Software used:** OpenSesame 4.1.6  
**Experiment Type:** Online  
**Languages supported:** English (EN), German (DE), Spanish (ES), and French (FR). Further languages can be added, which requires simple changes in the code, updating the `.csv` files, and adding the respective `.wav` audio files (see [Language localization](#language-localization)).

---------------------------------------

## GENERAL INSTRUCTIONS

This experiment is built using [OpenSesame](https://osdoc.cogsci.nl/) 4.1.6. To run this experiment online, it utilizes the [OSWeb](https://osdoc.cogsci.nl/4.1/manual/osweb/osweb/) backend. Please check the version you are using, as older OpenSesame versions might crash.

If you are unfamiliar with OpenSesame, please refer to the [documentation](https://osdoc.cogsci.nl/) on their website. This README specifically details the structure and customization of this [FPJT](https://osf.io/4sw6h) implementation.

---------------------------------------

## SETUP INSTRUCTIONS

To edit this task, you need to have **OpenSesame** installed.

To run the task online, you will likely need a [JATOS server](https://www.jatos.org/). At the time of writing, [MindProbe](https://mindprobe.eu/) serves as a JATOS server free of charge.

A script for data preparation in [R](https://www.r-project.org/) (4.5.2) is provided.

**Step-by-step instructions:**

1. **Download** and unzip the repository to a dedicated folder.
2. **Choose** the `.jzip` file corresponding to the language in which you want to run the experiment.
3. Log in to your JATOS server (e.g., [JATOS sign-in in MindProbe](https://jatos.mindprobe.eu/jatos/signin)), click “**Import Study**”, and select the `.jzip` file (this is the experiment file).
4. Name and click on the study to **open the dashboard**.
5. Click on “Study Links”, **choose** your preferred study link type (e.g., Personal Single Link, General Multiple Link, MTurk), click on the “Study Link” button next to it, and **copy the URL**.
6. **Distribute** the generated link(s) to your participants. They run the task directly in their web browser.
7. To **export data**, navigate in JATOS to “Results” ➝ select the data you want to keep (e.g., “All”) in the top bar, select “Export Results” ➝ “Data only” ➝ “Plain Text”, save the `.txt` file into the `data` folder located inside the unzipped repository, and **rename** it to `data.txt`. This **single** `data.txt` file contains the data of **all selected** participants in JSON format.
8. **Process the data** using the provided `data-prep.R` script.

### Browser Requirements

Participants should use **Google Chrome**, run the experiment in **full-screen mode**, and close other browser tabs and programs before starting. A stable internet connection is required. The experiment was developed for a display resolution of **1366 × 768 pixels**. Firefox has shown stability problems with the online experiment and is therefore not recommended.

### Experiment File Size

OpenSesame recommends keeping online experiments below **10 MB**. Therefore, a separate `.osexp` experiment file and corresponding `.jzip` archive are provided for each supported language.

The `.csv` files and images are identical in all language versions. The only language-specific resources are the audio files: each experiment file contains only the `.wav` files for its respective language.

---------------------------------------

## LANGUAGE LOCALIZATION

This experiment uses external `.csv` files to manage text and translations. This makes adding new languages relatively easy, but strict formatting rules apply.

**How it works:** Each language is provided as a separate experiment file. The language used by the respective experiment file is fixed in the `preparations` inline script. The experiment uses the corresponding _ISO_code_ (e.g., `EN`, `DE`, `ES`, `FR`) to retrieve the corresponding text from columns in the external `.csv` files and to identify the corresponding `.wav` audio files.

## Adding a new language

### 1. Open the relevant `.csv` files

- `Language_localiser.csv`
- `Demographics.csv`
- `Messages.csv`

The remaining `.csv` files contain the familiarization, practice, and test trials and are identical for all languages.

### 2. Extend `Language_localiser.csv` by adding a new row

```text
language;ISO_code
English;EN
German;DE
Spanish;ES
French;FR
```

Add your new language (e.g., Italian) by inserting the _language_ and _ISO_code_ in a **new row**:

```text
language;ISO_code
English;EN
German;DE
Spanish;ES
French;FR
Italian;IT
```

### 3. Extend `Demographics.csv` and `Messages.csv` by adding a new column

Add a **new column** using the _ISO_code_ (`IT`) and enter the translations at the end of each row.

⚠️ Do this for both of the listed `.csv` files!

### 4. Create the language-specific experiment file

1. Create a copy of an existing `FPJT_online_[ISO].osexp` file.
2. Open the copied experiment file in OpenSesame.
3. Go to the **Overview** tab.
4. Click on the `preparations` inline script.
5. In **line 8**, change the value of `selected_language` to the full language name (e.g., `Italian`). The language name must exactly match the corresponding entry in the `language` column of `Language_localiser.csv`.

Example:

```javascript
var selected_language = "Italian"; // change here
```

### 5. Generate and replace the audio files

For each additional language, the corresponding **audio instructions** must be generated and added. These audio files include the auditory movement instructions, the audio used to calibrate the volume, and the audio used during familiarization.

Save the files as **`.wav` files** and append the uppercase ISO code using an underscore, e.g., `testsound_IT.wav`, `solution_IT.wav`, `right_arm_side_IT.wav`, `left_arm_side_IT.wav`, etc.

It is important that these are **`.wav` files** and that the **exact uppercase ISO_code** is used in the filenames. Otherwise, the experiment will not find the audio resources.

In the OpenSesame file pool, replace the existing language-specific audio files with the new audio files. The language-independent file `signal_tone.wav` remains unchanged. The experiment file must contain only the audio files required for the respective language.

### 6. Reload the updated `.csv` files into the file pool

1. Open the file pool (folder icon with image).
2. Click the **green plus** button.
3. Select the updated `.csv` files and upload them — they will replace the old ones.
4. Save the experiment.

### 7. Export the experiment as `.jzip`

In OpenSesame, open the OSWeb extension (“Tools” in the top bar → “OSWeb and JATOS control panel”), and click on “Export to JATOS archive”. This saves a new `.jzip` file that you can upload to your JATOS server.

---

> **⚠️ Important:** When editing the `.csv` files to add translations or change text, you **MUST use HTML tags** to format text directly. **DO NOT** use “Enter” for a line break.

Common HTML tags used for this experiment:

- `<b>Text</b>`: Makes text **bold**.
- `<br>`: Inserts a line break (new line).
- `<i>Text</i>`: Makes text *italic*.
- `<span style='color:red'>Text</span>`: Changes text color.

If you do not use HTML tags, the formatting will not appear in the online experiment.

When adding a new language, you must manually insert line breaks using `<br>` within the cell. Otherwise, longer instructions will be truncated. **Do not use the “Enter” key**, as this causes rendering errors and text misalignment during the experiment.

> **⚠️ Important:** You **MUST NOT** change the names of the folders or files, as this will cause the experiment to crash. Additionally, do not change any variable names; the experiment logic depends on these specific identifiers, and renaming them requires updating the underlying code. Do not move files after decompressing the repository. Any deviation from the original file structure or naming will lead to a crash.

For more information on how to implement a language localizer in OpenSesame, see this [Language Localisation Demo](https://github.com/carlacz/OpenSesame_Language-Localisation-Demo/tree/main/Language_localiser_online).

---------------------------------------

## TECHNICAL DETAILS

The decompressed repository includes the following files and subfolders:

- `FPJT_online_[ISO].osexp`: The language-specific experiment files; needed to change the experiment settings or add a new language.
- `FPJT_online_[ISO].jzip`: The language-specific experiment files as JATOS archives; ready to be uploaded to the JATOS server.
- `Language_localiser.csv`: Configuration file for languages and ISO codes.
- `Demographics.csv`: Questions and translations for the demographics form.
- `Messages.csv`: General messages, task instructions, and translations.
- `Famil_trials.csv`: Loop file controlling the familiarization trials.
- `Practice_trials.csv`: Loop file controlling the practice trials.
- `Testblock_trials.csv`: Loop file controlling the test trials.
- `Practice_audios.csv`: Audio sequence definitions for the practice trials.
- `Testblock_audios.csv`: Audio sequence definitions for the test trials.
- **Images:** Stimulus and instruction images. These are identical in all language versions.
- **Audio files:** Language-specific `.wav` files. Each experiment file contains only the audio files for its respective language.
- **Folder** `data`: Empty folder designated for storing the single `data.txt` file exported from JATOS.
- `data-prep.R`: R script that reads a single `data.txt` file containing data from all selected participants and generates `data.rdata`. `data.rdata` contains the testblock data in long format and demographic and summary data in wide format.

---------------------------------------

## EXPERIMENT SETTINGS (parameters to choose)

The experiment file allows you to customize two settings. Both settings are experimenter-defined defaults in the `preparations` inline script.

### Available Parameters

| Variable | Options | Description |
| :--- | :--- | :--- |
| `response_mode` | • **Both hands** (Default)<br>• Left hand<br>• Right hand | Determines the required input method. |
| `feedback` | • Yes<br>• **No feedback in testblock** (Default) | Determines whether feedback is provided during the test block. Feedback is always provided during the practice block. |

### Changing the Defaults

You can hard-code new default settings within the script. To do this:

1. Go to the **Overview** tab.
2. Click on the `preparations` inline script.
3. Modify `selected_response_mode` in **line 9** and/or `selected_feedback` in **line 10** to your desired values.

You **MUST NOT** modify any other lines in the script, except `selected_language` in **line 8** when creating a new language version as described under [Language localization](#language-localization).

Example configuration:

```javascript
var selected_language = "English"; // change here
var selected_response_mode = "Both hands"; // change here
var selected_feedback = "No feedback in testblock"; // change here
```

### Disable Demographic Questions

The experiment includes three demographic questions (Age, Gender, Handedness) by default. We incorporate these questions to facilitate the **creation of norms** that will facilitate the interpretation of individual scores.

**We welcome contributions to this initiative!** If you wish to submit your data, please follow the steps outlined on the [platform website](https://movementimageryability.github.io/#contribute). When uploading data from specific populations (e.g., stroke patients), please ensure you provide the necessary context.

If you do not wish to contribute, you can disable the demographic questions.

1. Click on the `experiment` item in the Overview tab.
2. Locate the `demographics_sequence` in the tab to the right.
3. Change the corresponding “Run if” from “True” to “False”.

### Saving and Exporting

To try out the experiment after changing settings or adding a new language, click on the blue play button. This mode is **not** suitable for data collection, only for debugging. When updating the experiment multiple times, it is recommended to clear the browser’s cache to ensure the updates are displayed correctly.

Once you have finished your configuration, you must export the experiment for online use:

1. **Save** the experiment in OpenSesame.
2. **Export** as `.jzip`: In OpenSesame, open the OSWeb extension (“Tools” in the top bar → “OSWeb and JATOS control panel”), and click on “Export to JATOS archive”.
3. This creates a new `.jzip` file. You can now **upload** this file to your JATOS server.

---------------------------------------

## PARTICIPANT WORKFLOW

1. **Welcome screen**
2. **Demographics:** Participants complete a basic form (Age, Gender, Handedness).
3. **Audio calibration:** Participants play a test sound and adjust the volume on their device.
4. **Familiarization:** Participants become familiar with the possible body positions and corresponding audio instructions.
5. **Instructions and comprehension check:** Detailed explanation of the task and assignment of response keys, followed by a comprehension check.
6. **Practice block:** Four trials with feedback.
7. **Test block:** Thirty-two trials with or without feedback, depending on the selected setting.
8. **Completion:** Final “Goodbye” screen.

### FPJT Trial Procedure

The sequence of a single practice or test trial is as follows:

1. **Trial start:** Participants close their eyes and press the space bar when ready.
2. **Audio instructions:** A starting-position instruction is followed by three to six movement instructions.
3. **Signal tone and fixation:** A signal tone indicates that participants should open their eyes.
4. **Stimulus presentation:** The final-position image stays on screen until a valid keypress is recorded.
5. **Feedback:** Feedback is always shown during practice. During the test block, feedback is shown only if enabled.
6. **Automatic advance** to the next trial.

---------------------------------------

## OUTPUT

Following step 7 in the [step-by-step instructions](#setup-instructions), the data is exported from JATOS as a single `.txt` file containing all selected participant responses in **JSON format**. The JATOS export contains one separate JSON object per line and may contain data from multiple participants.

Save this file as `data/data.txt`. The provided `data-prep.R` script expects exactly this file and is designed to extract relevant observations from the test block and save the processed data as `data.rdata` in the current working directory.

**To run the data preparation**, open `data-prep.R` and **source** the script.

The script will generate `data.rdata`, which contains two dataframes: `data_long_tbl` (trial-level FPJT test data) and `data_wide` (demographic and summary data).

> **Note:** This script relies on the standard experiment structure. If modifications were made beyond the configurable [Experiment Settings](#available-parameters), the code may need adaptation. Additionally, raw data should always be inspected and cleaned of outliers or errors prior to statistical analysis.

### Variable Documentation

#### 1. Testblock Trials Data (`data_long_tbl`)

*Contains one row per FPJT test trial. Practice trials are not included.*

| Variable Name | Type | Description |
| :--- | :--- | :--- |
| `subject_nr` | factor | Participant ID. |
| `n_trial` | integer | Test trial index, 1-based. |
| `item` | factor | FPJT item identifier. |
| `n_audios` | integer | Number of auditory instructions in the trial. |
| `n_movements` | integer | Number of movements in the trial (`n_audios - 1`). |
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
| `gender` | character | Participant gender code (`f`, `m`, `d`). |
| `handedness` | character | Participant handedness code (`l`, `r`, `b`). |
| `n_CC` | integer | Number of comprehension-check attempts. |
| `fam_accuracy` | numeric | Familiarization accuracy, computed as the mean of `famil_answer` across familiarization trials. |

---------------------------------------

OpenSesame and OSWeb version updates may require adjustments in the experiment file.

As developers, we are not responsible for implementing the task in every use case.

Before collecting data, always test the experiment in the intended browser and check the data output.

Feel free to contribute!

---------------------------------------

## REFERENCE

Please cite [Czilczer, Moreno-Verdú, et al. (2026)](https://doi.org/10.31234/osf.io/9xjfb_v1) when using this resource.
