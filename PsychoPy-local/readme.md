# FINAL POSITION JUDGEMENT TASK (FPJT)

**Author:** Carla Czilczer, 16/01/2026  
**Software used:** PsychoPy 2025.1.1  
**Experiment Type:** Local (offline)  
**Languages supported:** English (EN) = default, German (DE) (Spanish (ES), French (FR) coming soon!). Further languages can be added, which requires simple changes in the code, updating the `.xlsx` files, and adding the respective `.wav` audio files (see [Language localization](#language-localization)).

---------------------------------------

## GENERAL INSTRUCTIONS

This experiment is built using [PsychoPy](https://www.psychopy.org/) (Builder) 2025.1.1 and is intended for **local execution**. Participants run the experiment directly on the experiment computer. No internet connection is required.

Please check the PsychoPy version you are using, as older versions might crash or behave unexpectedly.  
If you are unfamiliar with PsychoPy, please refer to the [documentation](https://www.psychopy.org/documentation.html). This README specifically details the structure and customization of this [FPJT](https://osf.io/4sw6h) implementation.

---------------------------------------

## SETUP INSTRUCTIONS

To edit or run this task, you need to have **PsychoPy** installed.

PsychoPy saves results locally as `.csv` (wide format) plus `.log` / `.psydat`.

**Step-by-step instructions:**

1. **Download** and unzip the repository to a dedicated folder.
2. **Open PsychoPy**, then open the experiment file `FPJT_local.psyexp` in Builder.
3. Click the green **Run** button to start the experiment.
4. Participants complete the experiment locally.
5. Data is automatically saved into the `data/` folder.

---------------------------------------

## LANGUAGE LOCALIZATION

This experiment uses external spreadsheet files to manage text and translations. This makes adding new languages relatively easy, but strict formatting rules apply.

Participants select their preferred language via the PsychoPy startup dialog (Experiment Info; see [Experiment settings](#experiment-settings-parameters-to-choose)). The experiment then uses the corresponding _ISO_code_ (e.g., `EN`, `DE`) to retrieve the corresponding text from columns in the external message sheet.

- `Language_localiser.xlsx` maps a **language** to an **ISO_code**.
- The message sheet (e.g., `fpjt_files/Messages.xlsx`) contains one column per ISO_code and is iterated to populate global text variables used across routines.

### Adding a new language

#### 1. Open the relevant files
- `Language_localiser.xlsx`
- `fpjt_files/Messages.xlsx`

#### 2. Extend `Language_localiser.xlsx`

The file must contain:

- `language`
- `ISO_code`

Example:

| language | ISO_code |
| :--- | :--- |
| English | EN |
| German | DE |

Add your new language:

| language | ISO_code |
| :--- | :--- |
| English | EN |
| German | DE |
| Italian | IT |

#### 3. Extend `Messages.xlsx`

The file must contain:

- a `message` column
- one column per ISO_code

Add a new ISO column and translations for **all** message keys.

⚠️ Every message must exist in every language column.

#### 4. Generate audio and add to `fpjt_audios/` folder

For each additional language, generate the corresponding audio instructions.

These include:
- auditory movement instructions
- one volume calibration sound
- one familiarization sound

Save as **mono `.wav`** files and append ISO code:

`testsound_IT.wav`, `right_arm_side_IT.wav`, …

Exact filenames are required.

Required audio base names:

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

The corresponding text is included in `Messages.xlsx`.

#### 5. Update the experiment

1. Open `FPJT_local.psyexp`
2. Go to **Experiment Settings → Basic → Experiment info**
3. Add the new language to the `language` list
4. Save the experiment

---

> ⚠️ **Important:** Do not change folder names, file names, or variable names. The experiment depends on exact paths and identifiers. Moving or renaming files may cause crashes.

---------------------------------------

## TECHNICAL DETAILS

The repository includes:

- `FPJT_local.psyexp` — main experiment file
- `Language_localiser.xlsx`

**Folder `fpjt_files`:**
- `Messages.xlsx`
- `Famil_trials.xlsx`
- `Practice_trials.xlsx`
- `Testblock_trials.xlsx`
- `Practice_audios.xlsx`
- `Testblock_audios.xlsx`

**Folder `fpjt_images`:** instruction and stimulus images

**Folder `fpjt_audios`:** instruction and calibration audio

**Folder `data`:** automatically saved data

---------------------------------------

## EXPERIMENT SETTINGS (parameters to choose)

Participants select settings in the PsychoPy startup dialog.

### Available parameters

| Variable | Options | Description |
| :--- | :--- | :--- |
| `language` | English (default), German | Interface language |
| `response_mode` | Both hands (default), Left hand, Right hand | Input method |
| `feedback` | Yes (default), No feedback in testblock | Feedback behavior |

### Setting default values (code-based)

Defaults are controlled in the experiment code.

For **language**, **response_mode**, and **feedback**:

1. Open the corresponding code component in the settings routine
2. Set your default value
3. Comment out the lines that overwrite the default with dialog input

This forces the experiment to use your hard-coded defaults.

### Disable demographic questions

The experiment includes Age, Gender, and Handedness by default.

To disable:

1. Click `demographics` routine
2. Open **Routine settings**
3. In **Testing** tab → click **Disable Routine**

#### Saving

1. Save the experiment
2. Run locally via PsychoPy

---------------------------------------

## PARTICIPANT WORKFLOW

1. **Settings selection:** language, response_mode, feedback
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
2. Transition screen
3. Fixation cross
4. Stimulus + response
5. Optional feedback
6. Advance via spacebar

---------------------------------------

## OUTPUT

All data is saved locally inside the `data/` folder.

Each run generates:

- `.csv` data file
- `.log`
- `.psydat`

---------------------------------------

PsychoPy version updates may require adjustments.  
Developers are not responsible for adapting the task to every use case.  
Contributions are welcome.

---------------------------------------

## REFERENCE

Please cite [Czilczer et al. (2025)](https://osf.io/9xjfb) when using this resource.
