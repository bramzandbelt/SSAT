# HEADER
scenario = "Stop-signal anticipation task";
response_matching = simple_matching;
active_buttons = 2;
button_codes = 1, 2;
default_background_color = 100, 100, 100;
default_font = "Arial";
default_font_size = 40;

# SDL
begin;

picture{
text{caption = "Stop-Signal Anticipation Task (SSAT) \nCopyright (c) 2017 Bram Zandbelt \n \n 1.  Outside scanner (participant triggers task) \n 2.  Inside MRI scanner (scanner triggers task)"; font_size = 24; text_align = align_left;}envselect_text;	x = 0; y = 0;
	text{caption = " "; font_size = 24; }envinput_text;x = 0; y = -200;
}pic_input_env;

picture{
	text{caption = "Enter subject pseudonym (e.g. sub-01)"; font_size = 24;}subjcode_instr; x = 0; y = 0;
	text{caption = " "; font_size = 24;} subjcode; x = 0; y = -200;
}pic_input_subjcode;

picture{
	text{caption = "Stop-signal anticipation task \n 1.  Practice stage 1:       Response timing \n 2.  Practice stage 2:       Reactive control \n 3.  Practice stage 3:       Proactive and reactive control \n 4.  Experiment:  Proactive and reactive control \n 5.  Quit"; font_size = 24; text_align = align_left;}taskselect_text;	x = 0; y = 0;
	text{caption = " "; font_size = 24; }taskinput_text;x = 0; y = -200;
}taskselect_picture;

picture{
}subjcode_picture;

picture{
	text {caption = "Waiting for the scanner";} wait_text;
	x = 0; y = 0;
} waiting_picture;

picture{
	text {caption = "Are you ready? Press the response button to start";} wait_text_subject;
	x = 0; y = 0;
} waiting_picture_subject;

trial {
	trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 2;
	stimulus_event
	{
		picture waiting_picture;
		time = 0;
		code = "wait_to_begin";
	} wait_event;
} wait_for_trigger;

trial {
	trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 2;
	picture waiting_picture_subject;
	time = 0;
	code = "wait_to_begin_subject";
} wait_for_subject;

picture{
	text {caption = "X"; font_color = 100,100,100;} feedback_text; x = 0; y = 250;
	line_graphic {
		coordinates = -40, 200, 40, 200;
		line_width = 4;
	} Upper_line1;
	x = 0; y = 0;
	line_graphic {
		coordinates = -40, 140, 40, 140;
		line_width = 4;
	} Middle_line1;
	x = 0; y = 0;
	line_graphic {
		coordinates = -40, -100, 40, -100;
		line_width = 4;
	} Lower_line1;
	x = 0; y = 0;
	box { height = 10; width = 20; color = 225, 225, 225; } the_box;
	x = 0; y = 0;
} boxes_picture;

trial {
	trial_duration = 50;
	trial_type = fixed;
	stimulus_event
	{
		picture boxes_picture;
		time = 0;
	} event0;
} trial_sample;

trial {
	trial_duration = 216;
	trial_type = fixed;
	stimulus_event
	{
		picture boxes_picture;
		time = 0;
		code = "feedback";
	} feedback_event;
} feedback_trial;

picture{
	line_graphic {
		coordinates = -40, 200, 40, 200;
		line_width = 4;
	} Upper_line2;
	x = 0; y = 0;
	line_graphic {
		line_color = 255,255,255,255;
		coordinates = -40, 140, 40, 140;
		line_width = 4;
	} Middle_line2;
	x = 0; y = 0;
	line_graphic {
		coordinates = -40, -100, 40, -100;
		line_width = 4;
	} Lower_line2;
	x = 0; y = 0;
} ITI_picture;

picture{
	line_graphic {
		coordinates = -40, 200, 40, 200;
		line_width = 4;
	} Upper_line3;
	x = 0; y = 0;
	line_graphic {
		line_color = 255,255,255,255;
		coordinates = -40, 140, 40, 140;
		line_width = 4;
	} Middle_line3;
	x = 0; y = 0;
	line_graphic {
		coordinates = -40, -100, 40, -100;
		line_width = 4;
	} Lower_line3;
	x = 0; y = 0;
} cue_picture;

trial {
	trial_duration = 764;
	trial_type = fixed;
	stimulus_event
	{
	picture ITI_picture;
	time = 0;
	}ITI_event1;

	stimulus_event
	{
	picture cue_picture;
	deltat = 300;
	}ITI_event2;

} trial_ITI;

trial {
trial_duration = 1964;
	trial_type = fixed;
	stimulus_event
	{
	picture ITI_picture;
	time = 0;
	}null_event;
}trial_null;

trial {
	trial_duration = 6000;
	trial_type = first_response;
	picture {text {caption = "Thanks for participating!";} goodbye_text; x = 0; y = 0;
	};
} goodbye_trial;

# PCL
begin_pcl;

# DEFAULT SETTINGS
int rep = 0;
int Fs = 1;
int boxRiseTime = 1000;
int overshoot = 150;
int maxLength = 300;
int acc;
int resp;
int respOnset;
int stop_time;
int stop;
int SSD1 = 300;
int SSD2 = 300;
int SSD3 = 300;
int SSD4 = 300;
int SSDstep = 25;
int SSD;
int SSDMax = 600;
int SSDMin = 100;
int nextcue;
int animStartTime;
int trialEndTime;
int nRun;
string logFileName;

int corr_tr = 0;

trial_sample.set_duration(Fs);

# FILE MANAGEMENT
system_keyboard.set_delimiter('\n');

string environment = system_keyboard.get_input(pic_input_env,envinput_text);	# Inside scanner / Outside scanner
string subjectcode = system_keyboard.get_input(pic_input_subjcode,subjcode);	# Get subject code for file naming

# Loop over tasks
loop int iTask = 1 until iTask > 1 begin

	string task = system_keyboard.get_input(taskselect_picture,taskinput_text); # Selection menu

	# Quit experiment if user asks for
	if task == "5" then
		break;
	end;

	# Logfile naming
	if task == "1" then
		logFileName = subjectcode + "_SSAT_Practice01_Response-Timing_" + date_time("ddmmyyhhnnss")+".txt";
		nRun = 1;
	elseif task == "2" then
		logFileName = subjectcode + "_SSAT_Practice02_Reactive-Control_" + date_time("ddmmyyhhnnss")+".txt";
		nRun = 1;
	elseif task == "3" then
		logFileName = subjectcode + "_SSAT_Practice03_Proactive-Reactive-Control_" + date_time("ddmmyyhhnnss")+".txt";
		nRun = 1;
	elseif task == "4" then
		logFileName = subjectcode + "_SSAT_Experiment_Proactive-Reactive-Control_" + date_time("ddmmyyhhnnss")+".txt";
		nRun = 1;
	end;

	if task == "1" || task == "2" || task == "3" || task == "4" then

		# Loop over runs (N.B. some tasks have only one run)
		loop int iRun = 1 until iRun > nRun begin

			# Input file handling
			input_file seq_file = new input_file;
			if task == "1" then
				seq_file.open( "seq_file_SSAT_Practice01_Response-Timing.txt" );
				seq_file.set_delimiter( '\t' );
			elseif task == "2" then
				seq_file.open( "seq_file_SSAT_Practice02_Reactive-Control.txt" );
				seq_file.set_delimiter( '\t' );
			elseif task == "3" then
				seq_file.open( "seq_file_SSAT_Practice03_Proactive-Reactive-Control-Run" + string(iRun) + ".txt" );
				seq_file.set_delimiter( '\t' );
			elseif task == "4" then
				seq_file.open( "seq_file_SSAT_Experiment_Proactive-Reactive-Control-Run" + string(iRun) + ".txt" );
				seq_file.set_delimiter( '\t' );
			end;

			output_file outputfile = new output_file;

			rep = 0;
			array<int> cue_type[1000];
			array<int> tr_type[1000];
			array<int> ITI[1000];

			loop until seq_file.end_of_file()
			begin
					rep = rep + 1;
					cue_type[rep] = seq_file.get_int();
					tr_type[rep] = seq_file.get_int();
			end;

			array<int> trialRT[1000];

			# Open output file
			outputfile.open_append( logFileName );

			# Only write header for the first run
			if iRun == 1 then
				outputfile.print("trial_number\ttrial_time\tcue_type\tstim_type\tacc\trespOnset\tSSD\n");
			end;

			# Wait for trigger pulse in fMRI experiment
			if environment == "1" then
				wait_for_subject.present();
			elseif environment == "2" then
				wait_for_trigger.present();
			end;

			int expStartTime = clock.time();

			loop int n = 1 until n > rep
			begin

				int cue = cue_type[n];
				int stim = tr_type[n];

				# Change color of side boxes

				if cue == -1 then # White target response line, for reactive inhibition only
					Middle_line1.set_line_color(255,255,255,255);
					Middle_line2.set_line_color(255,255,255,255);
					Middle_line3.set_line_color(255,255,255,255);
				elseif cue == 0 then # Green target response line, for proactive & reactive inhibition
					Middle_line1.set_line_color(0,255,0,255);
					Middle_line2.set_line_color(0,255,0,255);
					Middle_line3.set_line_color(0,255,0,255);
				elseif cue == 1 then # Yellow target response line, for proactive & reactive inhibition
					Middle_line1.set_line_color(255,255,0,255);
					Middle_line2.set_line_color(255,255,0,255);
					Middle_line3.set_line_color(255,255,0,255);
				elseif cue == 2 then # Amber target response line, for proactive & reactive inhibition
					Middle_line1.set_line_color(255,170,0,255);
					Middle_line2.set_line_color(255,170,0,255);
					Middle_line3.set_line_color(255,170,0,255);
				elseif cue == 3 then # Orange target response line, for proactive & reactive inhibition
					Middle_line1.set_line_color(255,85,0,255);
					Middle_line2.set_line_color(255,85,0,255);
					Middle_line3.set_line_color(255,85,0,255);
				elseif cue == 4 then # Red target response line, for proactive & reactive inhibition
					Middle_line1.set_line_color(255,0,0,255);
					Middle_line2.set_line_color(255,0,0,255);
					Middle_line3.set_line_color(255,0,0,255);
				elseif cue == 5 then # White target response line, for rest trials
					Middle_line1.set_line_color(255,255,255,255);
					Middle_line2.set_line_color(255,255,255,255);
					Middle_line3.set_line_color(255,255,255,255);
				end;

				Middle_line1.redraw();
				Middle_line2.redraw();
				Middle_line3.redraw();

				feedback_text.set_font_color(100,100,100); # Make feedback text invisible at the beginning of each trial
				feedback_text.redraw();

				if cue <= 4 then

					# Set up the stop times
					if stim == 0 then
						stop_time = boxRiseTime + overshoot;
					elseif stim == 1 && cue == -1 then # This is for the reactive inhibition training/experiment
						stop_time = 800 - SSD1;
						SSD = SSD1;
					elseif stim == 1 && cue == 1 then # This is for the proactive & reactive inhibition training/experiment
						stop_time = 800 - SSD1;
						SSD = SSD1;
					elseif stim == 1 && cue == 2 then # This is for the proactive & reactive inhibition training/experiment
						stop_time = 800 - SSD2;
						SSD = SSD2;
					elseif stim == 1 && cue == 3 then # This is for the proactive & reactive inhibition training/experiment
						stop_time = 800 - SSD3;
						SSD = SSD3;
					elseif stim == 1 && cue == 4 then # This is for the proactive & reactive inhibition training/experiment
						stop_time = 800 - SSD4;
						SSD = SSD4;
					end;

					# Variables to remember responses & onsets
					respOnset = 0;
					resp = 0;
					# Animate boxes

					animStartTime = clock.time();
					trialEndTime = animStartTime + boxRiseTime;

					loop int iSample = 1 until 0 > 1 begin

						int t = clock.time() - animStartTime;

						# Report trial information at first sample.
						if (iSample == 1) then
							event0.set_event_code("first_sample");
						else
							event0.set_event_code("");
						end;

						# Increase box lengths while needed on this trial.
						if (t <= stop_time && respOnset == 0) then
							int h = 1 + int(double(maxLength) * double(t) / double(boxRiseTime));
							the_box.set_height(h);
							boxes_picture.set_part_y(5, -100 + h / 2);
						end;

						# Response management
						if (response_manager.response_count(1) == 1) then
							resp = 1;
							respOnset = clock.time() - animStartTime;
						end;

						# Time management
						if (clock.time() >= trialEndTime) then
							break;
						end;

						# Updates
						trial_sample.present();
						iSample = iSample + 1;

						corr_tr = corr_tr + 1;
						trialRT[n] = respOnset - 800;

					end;

					# Feedback
					int timing_error;

					if stim == 0 && resp == 0 then
						timing_error = 1000;
						acc = 0;
						feedback_text.set_font_color(255,0,0);
						feedback_text.set_caption("X");
					elseif stim == 0 && resp == 1 then
						timing_error = respOnset - 800;
						acc = 1;
						feedback_text.set_font_color(100,100,100);			# Don't show response latencies
						#feedback_text.set_font_color(255,255,255);
						#feedback_text.set_font_size(24);
						#feedback_text.set_caption(string(timing_error));
					elseif stim == 1 && resp == 0 then
						acc = 1;
						feedback_text.set_font_color(100,100,100);

						if cue == -1 then
							if SSD1 > SSDMin then
								SSD1 = SSD1 - SSDstep;
							else
								SSD1 = SSD1;
							end;
						elseif cue == 1 then
							if SSD1 > SSDMin then
								SSD1 = SSD1 - SSDstep;
							else
								SSD1 = SSD1;
							end;
						elseif cue == 2 then
							if SSD2 > SSDMin then
								SSD2 = SSD2 - SSDstep;
							else
								SSD2 = SSD2;
							end;
						elseif cue == 3 then
							if SSD3 > SSDMin then
								SSD3 = SSD3 - SSDstep;
							else
								SSD3 = SSD3;
							end;
						elseif cue == 4 then
							if SSD4 > SSDMin then
								SSD4 = SSD4 - SSDstep;
							else
								SSD4 = SSD4;
							end;
						end;

					elseif stim == 1 && resp == 1 then
						timing_error = respOnset - 800;
						acc = 0;
						feedback_text.set_caption("X");
						feedback_text.set_font_color(255,0,0);

						if cue == -1 then
							if SSD1 < SSDMax then
								SSD1 = SSD1 + SSDstep;
							else
								SSD1 = SSD1;
							end;
						elseif cue == 1 then
							if SSD1 < SSDMax then
								SSD1 = SSD1 + SSDstep;
							else
								SSD1 = SSD1;
							end;
						elseif cue == 2 then
							if SSD2< SSDMax then
								SSD2 = SSD2 + SSDstep;
							else
								SSD2 = SSD2;
							end;
						elseif cue == 3 then
							if SSD3 < SSDMax then
								SSD3 = SSD3 + SSDstep;
							else
								SSD3 = SSD3;
							end;
						elseif cue == 4 then
							if SSD4 < SSDMax then
								SSD4 = SSD4 + SSDstep;
							else
								SSD4 = SSD4;
							end;
						end;
					end;

					feedback_text.redraw();
					feedback_trial.present();

					outputfile.print(n); outputfile.print("\t");
					outputfile.print(animStartTime); outputfile.print("\t");
					outputfile.print(cue); outputfile.print("\t");
					outputfile.print(stim); outputfile.print("\t");
					outputfile.print(acc); outputfile.print("\t");
					if stim == 0 && resp == 0 then
					outputfile.print("\t");
					outputfile.print("\t");
					elseif stim == 0 && resp == 1 then
					outputfile.print(respOnset); outputfile.print("\t");
					outputfile.print("\t");
					elseif stim == 1 && resp == 0 then
					outputfile.print("\t");
					outputfile.print(SSD); outputfile.print("\t");
					elseif stim == 1 && resp == 1 then
					outputfile.print(respOnset); outputfile.print("\t");
					outputfile.print(SSD); outputfile.print("\t");
					end;
					outputfile.print("\n");

					trial_ITI.present();

				elseif cue == 5 then

					trial_null.present();
					animStartTime = clock.time();
					outputfile.print(n); outputfile.print("\t");
					outputfile.print(animStartTime); outputfile.print("\t");
					outputfile.print(cue); outputfile.print("\t");
					outputfile.print("\t");
					outputfile.print("\t");
					outputfile.print("\t");
					outputfile.print("\t");
					outputfile.print("\n");

				end;
				n = n + 1;
			end;
			iRun = iRun + 1;
		end;
	end;
end;
goodbye_trial.present();
