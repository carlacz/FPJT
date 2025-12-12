# Final Position Judgement Task (FPJT)

Available in **English**, **German**, **Spanish**, **French** (see below to implement the task in other languages).

The FPJT is a behavioural paradigm aiming to assess the ability to imagine performing a series of auditorily instructed movements. While focusing on imagery manipulation and maintenance, it also requires generating an imagery "from scratch" and inspecting one's imagery to judge whether it matches a visual stimulus. 
If you are interested in assessing Movement Imagery ability, visit the [Movement Imagery Ability Platform](movementimageryability.github.io) for an overview of open-source behavioural tasks.

The task was adapted from earlier imagery-stimulus compairosn tasks (e.g., [Madan & Singhal, 2013](DOI); [Nishida et al., 1986](DOI); [Schott, 2013](DOI)). 
This repository contains the materials for the open-source (and user-friendly) FPJT, based on [Czilczer et al. (2025)](DOI).
The most updated versions can be found in this repository.

Subsequent updates in native software ([PsychoPy](https://www.psychopy.org/index.html) and [OpenSesame](https://osdoc.cogsci.nl/)) may need adjustments. As developers, we are not responsible for implementing these in every use case.

An example of the setup is shown below.
![FPJT-demo](FPJT-demo.mp4)

## Repository information
The repository has four main folders, which contain PsychoPy experiments (.psyexp) OpenSesame (`.osexp`), together with associated files to be able to run them locally or online. Please consult the `README` files for each version before using them (these four versions are **not** equivalent in terms of configuration). The `README` files contain extensive documentation on the most relevant task settings and detailed information to allow the user further customization.

The versions provided in this repository allow flexibility in terms of key experiment parameters of the FPJT:
- number of sequential movements
- types of response
- trial-to-trial feedback

The optimal protocol is at the user's discretion, but sensible defaults have been implemented.

## Language expansion
If you want to contribute to this repository by providing a language translation, or want to run the task in your own language, expansions can be done relatively easily thanks to the implementation of language localisations (please read each README to understand how to implement these). You can also see this demo showing how to implement a language localisation in [PsychoPy](https://github.com/mmorenoverdu/language_localisation_demo) and [OpenSesame](https://github.com/carlacz/OpenSesame_Language-Localisation-Demo) with virtually no code.
