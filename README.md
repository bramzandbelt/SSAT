# Stop-Signal Anticipation Task (SSAT)

## Overview

This repository contains stimulus presentation code (Presentation, [Neurobehavioral Systems, Inc](http://www.neurobs.com/)) for the stop-signal anticipation task (SSAT), a stop-signal paradigm designed to measure proactive and reactive inhibition. This task was used in the following experiments, among others:

- Zandbelt, B. B., & Vink, M. (2010). On the Role of the Striatum in Response Inhibition. PLoS ONE, 5(11), e13848.
https://doi.org/10.1371/journal.pone.0013848
- Zandbelt, B. B., van Buuren, M., Kahn, R. S., & Vink, M. (2011). Reduced Proactive Inhibition in Schizophrenia Is Related to Corticostriatal Dysfunction and Poor Working Memory. Biological Psychiatry, 70(12), 1151–1158. https://doi.org/10.1016/j.biopsych.2011.07.028
- Zandbelt, B. B., Bloemendaal, M., Hoogendam, J. M., Kahn, R. S., & Vink, M. (2013). Transcranial magnetic stimulation and functional MRI reveal cortical and subcortical interactions during stop-signal response inhibition. Journal of Cognitive Neuroscience, 25(2), 157–174.
https://doi.org/https://dx.doi.org/10.1162/jocn_a_00309

## Getting started

### Requirements
- [Presentation](http://www.neurobs.com/)

### Installation

You can either download the code as a ZIP file or you can clone the code:

To download the code:
1. Go to the [SSAT repository on GitHub](https://github.com/bramzandbelt/SSAT).
2. Select 'Download ZIP' from the green 'Clone or download' button.

To clone the code, run the following command on the command line (requires Git to be installed):

```
git clone https://github.com/bramzandbelt/SSAT.git
```

### Usage

1. Launch the SSAT [Presentation](http://www.neurobs.com/) experiment, by double-clicking the `SSAT.exp` file. This file is in the main directo ry containing the SSAT code.

2. Configure the Logfile Directory (under Scenarios tab), the Active Buttons (under Settings tab > Response), and the MRI trigger (if you run the task in the scanner environment).

3. Run the task (under Main tab > Run > Run Scenario).

4. Select the task environment by typing the corresponding number, then press Enter to confirm.

5. Enter the participant's pseudonym, then press Enter to confirm.

5. From the main menu, select the experiment stage by typing the corresponding number, then press Enter to confirm:
  - `1. Practice 1: Response timing`
    The goal of this practice stage is to familiarize the particpant with the main response task: halting the bar at the target response line.

    50 trials: 1m40s
  - `2. Practice 2: Reactive control`
      At this stage, stop-signals are introduced.
      The goal of this practice stage is to familiarize the particpant with reactive stopping: when the bar stops moving automatically before reaching the target response line, the participant should stop her/his response.

      50 trialsL 1m40s
  - `3. Practice 3: Proactive and reactive control`
      At this stage, cues signaling stop-signal probability are introduced.
      The goal of this practice stage is to familiarize the particpant with reactive stopping:


      498 trials includes 2 rest blocks of 24 s
  - `4. Experiment`
  - `5. Quit`

6. The chosen stage will be run

7. After having completed the stage, the program returns to the main menu.

8. Log files are stored separately for each stage of the task in the Logfile Directory, defined under Scenarios tab.

### Instructions

Participants completed all practice stages before participating in the experiment. Practice stages were repeated in case the participant misunderstood the instructions or did not comply with task instructions.

#### Practice 1: Response timing

#### Practice 2: Reactive control

#### Practice 3: Proactive and reactive control

#### Experiment

The first training
Aim: practice response timing
It consists of 50 go (no-signal) trials presented in a 0% stop-signal probability context (green cue). The total duration of this stage is 1 minute and 40 seconds.
> Instruction:
"On each trial you will see three horizontal lines. The lower and upper lines are white, the middle line has usually a different color. On each trial, a bar appears, rising from the lower line to the upper line in one second. Your task is to halt the bar as close to the middle line as possible by pressing the response button."


You will see a bar moving from the bottom up

#### Code book of log files

The log files created by the SSAT code contain of 7 columns:

|column name |description|
|------------|-----------|
|trial_number|trial index|
|trial_time  |trial onset time (in ms from moment when "Run Scenario" button is pressed)|
|cue_type    |cue type: <br> 0 = green, <br> 1 = yellow, <br> 2 = amber, <br> 3 = orange, <br> 4 = red|
|stim_type   |stimulus type presented (signal_type would have been a better label): <br> 0 = no-signal (i.e. no-signal/go trial), <br> 1 =  stop-signal (i.e. stop trial) |
|acc         |accuracy: <br> 0 = correct, <br> 1 = incorrect|
|respOnset   |response onset (in ms from trial onset, i.e. when bar starts rising)|
|SSD         |stop-signal delay (in ms from the target response time of 800 ms; e.g. 300 means that the stop-signal occurs at 800 - 300 = 500 ms from trial onset)|

### Adjusting the sequence files

### Citation
If you use the SSAT, you must cite the software and the original publication describing the task:
- Zandbelt, Bram (2017): Slice Display. figshare. 10.6084/m9.figshare.4742866.
- Zandbelt, B. B., & Vink, M. (2010). On the Role of the Striatum in Response Inhibition. PLoS ONE, 5(11), e13848.
https://doi.org/10.1371/journal.pone.0013848

## Colophon

### Version
Version 0.1 - March 2017

### Contact
E-mail: bramzandbelt@gmail.com

### Acknowledgment
Thanks to Thomas Gladwin for assistance with coding the animation of the moving stimulus.
