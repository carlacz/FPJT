# FINAL POSITION JUDGEMENT TASK (FPJT)

**Author:** Carla Czilczer, 16/01/2026  
**Software used:** PsychoPy 2025.1.1  
**Experiment Type:** Local  
**Languages supported:** English (EN) = default, German (DE) (Spanish (ES), French (FR) coming soon!). Further languages can be added, which requires simple changes in the code and updating the `.xlsx` / `.csv` files (see [language localization](#LANGUAGE-LOCALIZATION)). 

---------------------------------------
## GENERAL INSTRUCTIONS

This experiment is built using [PsychoPy](https://www.psychopy.org/) (Builder) 2025.1.1 and is intended to be run **locally** (lab / offline) via PsychoPy. Please check the version you are using, as older PsychoPy versions might crash or behave unexpectedly.  
If you are unfamiliar with PsychoPy, please refer to the [documentation](https://www.psychopy.org/documentation.html) on their website. This README specifically details the structure and customization of this **FPJT** implementation.  

---------------------------------------
## SETUP INSTRUCTIONS

To edit or run this task, you need to have **PsychoPy** installed.  
PsychoPy exports results directly as `.csv` (wide format) plus `.log` / `.psydat` (depending on run mode).

**Step-by-step instructions:**  
1.  **Download** and unzip the repository to a dedicated folder.
2.  **Open PsychoPy**, then open the experiment file `FPJT_local.psyexp` in Builder.
3.  (Optional) Adjust experiment settings (see [EXPERIMENT SETTINGS](#EXPERIMENT-SETTINGS-parameters-to-choose)).
4.  Click the green **Run** button to test locally (debugging only; not recommended for data collection).
5.  For data collection, run the task locally and ensure participants enter a unique `participant` (and, if used, `session`) in the PsychoPy startup dialog.
6.  To **export data**, collect the output files saved into the `data` folder (see [OUTPUT](#OUTPUT)).

---------------------------------------
## LANGUAGE LOCALIZATION

This experiment uses external spreadsheet files to manage text and translations. This makes adding new languages relatively easy, but strict formatting rules apply.

**How it works:** Participants select their preferred language via the PsychoPy startup dialog (Experiment Info; see [letting participants select settings](#Letting-Participants-Select-Settings)). The experiment then uses the corresponding _ISO_code_ (e.g., "EN", "DE") to retrieve the corresponding text from columns in the external message sheet. Concretely:
- `Language_localiser.xlsx` maps a **language** to an **ISO_code**.
- The message sheet (e.g., `fpjt_files/Messages.xlsx`) contains one column per ISO_code (e.g., `EN`, `DE`) and is iterated to populate the global text variables used across routines.

## **Adding a new language:**
### 1. Open the relevant files
- `Language_localiser.xlsx`
-`Demographics.xlsx`
- `fpjt_files/Messages.xlsx`  

### 2. Extend `Language_localiser.xlsx` by adding a new row  
The file must contain (at minimum) the columns:
- `language`
- `ISO_code`

Example content:
language ISO_code
English EN
German DE
Spanish ES
French FR

Add your new language (e.g., Italian) by inserting the _language_ and _ISO_code_ in a **new row**:
language ISO_code
English EN
German DE
Spanish ES
French FR
Italian IT

### 3. Extend `fpjt_files/Messages.xlsx` by adding a new column
The file must contain:
- a `message` column (variable names used inside PsychoPy), and
- one column per language (named by _ISO_code_).

Example (conceptual):
message EN DE
welcome_msg Welcome to the task! Willkommen zur Aufgabe!
adv_msg Press SPACE to continue Drücken Sie SPACE zum Fortfahren
...

Add a **new column** using the _ISO_code_ (`IT`), and enter translations:
message EN DE IT
welcome_msg Welcome to the task! Willkommen zur Aufgabe! Benvenuti al compito!
adv_msg Press SPACE to continue Drücken Sie SPACE ... Premi SPAZIO per continuare
...

⚠️Do this consistently for all message keys used by the experiment!

### 4. Update the experiment
1. Open the experiment file `FPJT_local.psyexp`
2. Go to **Experiment Settings** (cogwheel icon) → tab **Basic** → field **Experiment info**
3. Update the `language` entry (the list shown in the startup dialog) by adding your new language name (e.g., `Italian`) — it must exactly match the entry in `Language_localiser.xlsx`.

---
> **⚠️ Important:** You **MUST NOT** change the names of the folders or files, as this will cause the experiment to crash. Additionally, do not change any variable names; the experiment logic depends on these specific identifiers, and renaming them requires updating the underlying code. Do not move files after decompressing the repository. Any deviation from the original file structure or naming can lead to a crash.

---------------------------------------
## TECHNICAL DETAILS
The decompressed repository includes the following files and subfolders:
* `FPJT_local.psyexp`: The main PsychoPy experiment file; needed to change the experiment settings.
* `Language_localiser.xlsx`: Configuration file for language selection (language + ISO code).
* `Demographics.xlsx`: Questions and translations for the demographics form.
* **Folder** `fpjt_files`:
    * `Messages.xlsx`: All translatable text strings (mapped by message key and ISO code).
    * `Famil_trials.xlsx`: Conditions file controlling the familiarization trials.
    * `Practice_trials.xlsx`: Conditions file controlling the practice trials.
    * `Testblock_trials.xlsx`: Conditions file controlling the test block trials.
    * `Practice_audios.xlsx`: Conditions file controlling practice instruction audio sequences.
    * `Testblock_audios.xlsx`: Conditions file controlling test block instruction audio sequences.
* **Folder** `fpjt_images`: image files for stimuli and instruction screens (e.g., key icons, instructional images, task stimuli).
* **Folder** `fpjt_audios`: audio files used in calibration, instructions, and/or feedback.
* **Folder** `data`: output folder for local runs (PsychoPy saves data using the filename pattern configured in Experiment Settings).

---------------------------------------
## EXPERIMENT SETTINGS (parameters to choose)
The experiment file allows you to customize various settings. In **Experiment Settings** → **Experiment info**, you will find the following variables that can be modified:

### Available Parameters

| Variable | Options | Description |
| :--- | :--- | :--- |
| `language` | • **English** (Default)<br>• German | Sets the language shown in the experiment (used via `Language_localiser.xlsx`). |
| `response_mode` | • **Both hands** (Default)<br>• Right hand<br>• Left hand | Determines the required input method and allowed response keys. |
| `feedback` | • **Yes** (Default)<br>• No | Controls whether feedback is shown in the test block. |

### Changing the Defaults
You can hard-code new default settings by adjusting the defaults in **Experiment Settings → Experiment info** (e.g., order of list entries, or replacing a list with a single fixed value).  

If you need to override selections programmatically, edit the Code Components in the `experiment_settings` routine (e.g., components named `response_mode` and `feedback`). You **MUST NOT** modify unrelated code sections unless you also update the underlying logic consistently.

### Letting Participants Select Settings
Participants select settings via the PsychoPy startup dialog as long as the corresponding entries exist in **Experiment Settings → Experiment info** (e.g., `language`, `response_mode`, `feedback`).  
To disable selection for a setting, replace the list with a single fixed value (or remove the field entirely and set it via code).

### Saving and Exporting
To try out the experiment after changing settings or adding a new language, click the green **Run** button in PsychoPy.  

Once you have finished your configuration, you can run the experiment locally for data collection:
1.  **Save** the experiment in PsychoPy.
2.  **Run** locally (full-screen recommended for standardized timing/visual presentation).
3.  **Collect** the output files written to the `data` folder.

---------------------------------------
## PARTICIPANT WORKFLOW:

1.  **Settings Selection:** Participants select (or confirm) `language`, `response_mode`, and `feedback` in the PsychoPy startup dialog.
2.  **Welcome:** Intro screen(s).
3.  **Audio / Volume calibration:** Participants play a test sound and adjust volume as instructed.
4.  **Familiarization:** Short guided block with example trials and feedback (mouse-based selection).
5.  **Instructions + Comprehension Check:** Task instructions followed by a comprehension check that repeats until answered correctly.
6.  **Practice Block:** Practice trials with feedback to familiarize participants with the key mapping.
7.  **Test Block:** Main experimental trials; feedback is conditional on the selected `feedback` setting.
8.  **Completion:** Final "Goodbye" screen.

#### FPJT trial procedure
The sequence of a single trial is as follows (conceptually):
1.  **Instruction phase:** multiple instruction audio segments (controlled by the audio loop files).
2.  **“Open eyes” / transition screen**
3.  **Fixation cross**
4.  **Stimulus + response collection:** Keypress is recorded (allowed keys depend on `response_mode`).
5.  **Feedback:** (Conditional) If enabled, feedback is shown after the response.  
    *→ Automatic advance to the next trial.*

---------------------------------------
## OUTPUT

For local runs, PsychoPy saves output files into the `data` folder using the configured filename pattern (default: `data/<participant>_<expName>_<date>.*`). The experiment is configured to save a **wide-format `.csv`** plus a `.log` and `.psydat` (depending on run mode).

> **Note:** PsychoPy output includes (a) component-based columns (e.g., response keys/RT/correctness) and (b) all columns from the relevant conditions files (e.g., `Practice_trials.xlsx`, `Testblock_trials.xlsx`) appended per row. If modifications were made beyond the configurable settings, the output structure may change accordingly.

-----

PsychoPy version updates might require adjustments in the experiment file.  
As developers, we are not responsible to implementing the task in every use case.  
Feel free to contribute!

-------
## REFERENCE
Please cite [Czilczer et al. (2025)](https://osf.io/9xjfb) when using this resource.
