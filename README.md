# Final Position Judgement Task (FPJT)

Available in **English**, **German**, **Spanish**, **French** (see below to implement the task in other languages).

The FPJT is a behavioural paradigm aiming to assess the ability to imagine performing a series of auditorily instructed movements. While focusing on imagery manipulation and maintenance, it also requires generating an imagery "from scratch" and inspecting one's imagery to judge whether it matches a visual stimulus. 
If you are interested in assessing Movement Imagery ability, visit the [Movement Imagery Ability Platform](movementimageryability.github.io) for an overview of open-source behavioural tasks.

The task was adapted from earlier imagery-stimulus compairosn tasks (e.g., [Madan & Singhal, 2013](https://doi.org/10.1080/00222895.2013.763764); [Nishida et al., 1986](https://doi.org/10.1123/jsep.10.4.418); [Schott, 2013](https://doi.org/10.1007/s00391-013-0520-x)). 
This repository contains the materials for the open-source (and user-friendly) FPJT, based on [Czilczer et al. (2025)](DOI), provided in open-source experiment presentation software.
The most updated versions can be found in this repository.

Subsequent updates in native software ([PsychoPy](https://www.psychopy.org/index.html) and [OpenSesame](https://osdoc.cogsci.nl/)) may need adjustments. As developers, we are not responsible for implementing these in every use case.

An example of a trial is shown below. Participants imagine performing 4-7 movements (subsequently instructed via standardized audios) and judge whether their final position in their imagery matches with a visual stimulus, which is presented after the last auditory instruction.
![FPJT-demo](files-READMEs/FPJT-demo.png)

## Repository information
This repository has four main folders, which contain **PsychoPy** (`.psyexp`) and **OpenSesame** (`.osexp`) experiments, together with associated files to run them **locally** (lab/desktop experiments) or **online** (in a browser).  
Please consult the accompanying manuscript ([Czilczer et al., 2026](DOI)) on the [Movement Imagery Ability Platform](movementimageryability.github.io) for a guide on necessary steps to run a task in each of the four deployment modes, which can help with the decision.
- [FPJT PsychoPy local](/PsychoPy-local)
- [FPJT PsychoPy online](/PsychoPy-online)
- [FPJT OpenSesame local](/OpenSesame-local)
- [FPJT OpenSesame online](/OpenSesame-online)

The versions provided in this repository allow flexibility in terms of key experiment parameters of the FPJT:
- number of sequential movements
- types of response
- trial-to-trial feedback

The optimal protocol is at the user's discretion, but sensible defaults have been implemented.

## Language expansion
If you want to contribute to this repository by providing a language translation, or want to run the task in your own language, expansions can be done relatively easily thanks to the implementation of language localisations (please read each README to understand how to implement these). You can also see these demos showing how to implement a language localisation in [PsychoPy](https://github.com/mmorenoverdu/language_localisation_demo) and [OpenSesame](https://github.com/carlacz/OpenSesame_Language-Localisation-Demo) with virtually no code.
