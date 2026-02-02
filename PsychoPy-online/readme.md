# FINAL POSITION JUDGEMENT TASK (FPJT)

**Author:** Carla Czilczer, 16/01/2026  
**Software used:** PsychoPy 2025.1.1  
**Experiment Type:** Online  
**Languages supported:** English (EN) = default, German (DE) (Spanish (ES), French (FR) coming soon!). Further languages can be added, which requires simple changes in the code, updating the `.xlsx` files, and adding the respective `.wav` audio files (see [Language localization](#language-localization)).

---------------------------------------

## GENERAL INSTRUCTIONS

This experiment is built using [PsychoPy](https://www.psychopy.org/) (Builder) 2025.1.1. To run this experiment online, it utilizes PsychoPy’s **PsychoJS** export and is typically hosted via [Pavlovia](https://pavlovia.org/). Please check the version you are using, as older PsychoPy / PsychoJS versions might crash or behave unexpectedly.  
If you are unfamiliar with PsychoPy, please refer to the [documentation](https://www.psychopy.org/documentation.html) on their website. This README specifically details the structure and customization of this [FPJT](https://osf.io/4sw6h) implementation.

---------------------------------------

## SETUP INSTRUCTIONS

To edit or run this task, you need to have **PsychoPy** installed.  
To run the task online, you will need a hosting solution for PsychoJS (most commonly **Pavlovia**).  
PsychoPy exports results directly as `.csv` (wide format) plus `.log` / `.psydat` (depending on run mode).

**Step-by-step instructions:**
1. **Download** and unzip the repository to a dedicated folder.
2. **Open PsychoPy**, then open the experiment file `FPJT_online.psyexp` in Builder.
3. To run online, use PsychoPy’s **Pavlovia** workflow (e.g., “Pavlovia → Sync” / “Export HTML”), and follow the standard PsychoPy/Pavlovia procedure to create/sync a Pavlovia project.
4. Click the green **Run** button to test in browser (debugging only; not recommended for online data collection).
5. **Distribute** the generated study link to your participants. They run the task directly in their web browser.
6. **Download the data** from the Pavlovia project dashboard (Results/Data export).

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

| Language | ISO_code |
| :--- | :--- |
| English | EN |
| German | DE |

Add your new language (e.g., Italian) in a **new row**:

| Language | ISO_code |
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

In **Experiment Settings → Experiment info**, participants can optionally select a `language` variable.  
`response_mode` and `feedback` are experimenter-defined defaults set in code.

### Available parameters

| Variable | Options | Description |
| :--- | :--- | :--- |
| `language` | English (default), German | Participant-selectable language |
| `response_mode` | Both hands (default), Left hand, Right hand | Input method (experimenter-defined) |
| `feedback` | Yes (default), No feedback in testblock | Feedback behavior in test block (experimenter-defined) |

### Changing defaults

#### 1. Default `response_mode`

1. Click `experiment_settings` routine
2. Open code component `response_mode`
3. Edit in **Before experiment**

#### 2. Default `feedback`

1. Click `experiment_settings` routine
2. Open code component `feedback`
3. Edit in **Before experiment**

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

For online runs, data is stored on the selected server/host and can be downloaded from the project’s interface.

---------------------------------------

PsychoPy / PsychoJS version updates may require adjustments.  
Developers are not responsible for adapting the task to every use case.  
Contributions are welcome.

---------------------------------------

## REFERENCE

Please cite [Czilczer et al. (2025)](https://osf.io/9xjfb) when using this resource.
