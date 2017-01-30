# Scenario for playing .wav files and sending markers defined in a text file using PCL
# 2005 Petra van Alphen (p.m.vanalphen@uva.nl).
# 2012 Anne van Leeuwen (a.r.vanleeuwen1@uu.nl), created in Presentation version 14.9

scenario = "SF_A1.sce";
pcl_file = "SF_A1.pcl";
no_logfile = false ;

write_codes = true;               
pulse_width= 10;
  
active_buttons = 2;    
button_codes = 1,2;
response_port_output = false;

default_font_size=30;
default_font = "Arial";
default_text_color = 255,255,255;

begin;

# First we define several displays
picture {} default;
picture { text {caption = "+"; font_size = 60;};   x=0; y=0;} fix1;
picture { text {caption = "- - -"; font_size = 60;};   x=0; y=0;} knipper;
picture { text {caption = "Druk op Enter om met de oefensessie te beginnen. \n
Druk op Enter nadat het kruisje van het scherm is verdwenen, \n je gaat dan naar de volgende zin."; font_size = 22;}; x=0; y=0;} beginexp;   
picture { text {caption = "Einde Oefensessie \n Druk op Enter om verder te gaan";}; x=0; y=0;} eindoefen;
picture { text {caption = "BEGIN EXPERIMENT \n \n Druk op Enter om met het experiment te beginnen"; font_size = 22;}; x=0; y=0;} begintest; 
picture { text {caption = "LUISTER AANDACHTIG \n Probeer je bij iedere zin de situatie voor te stellen"; font_size = 22;}; x=0; y=0;} aandacht; 
picture { text {caption = "EINDE EXPERIMENT \n Dank je wel voor het meedoen";}; x=0; y=0;} eindexp;    

#pictures for the breaks
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze1a;
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze1b;
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze2a;
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze2b;
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze3a;
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze3b;
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze4a;
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze4b;
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze5a;
picture { bitmap {filename = "M:\\jvbproject\\presentation database\\anne\\stimuli\\pauze1.jpg";};x=0; y=0;}pauze5b;

# We define a sound and name it
sound { wavefile { filename = ""; preload = false;} s; } snd;

# Warning before the start
trial {
   trial_type = first_response;
	trial_duration = forever; 
   picture beginexp;
   target_button = 1;
   response_active = true;
}startexp;

# End of Practice
trial {
   start_delay = 1000;
	trial_type = first_response;
	trial_duration = forever; 
   picture eindoefen;
   target_button = 1;
   response_active = true;
}endpractice;

# Begin of Testitems
trial {
   trial_type = first_response;
	trial_duration = forever; 
   picture begintest;
   target_button = 1;
   response_active = true;
}starttest;

# End of Testitems
trial {
   start_delay = 1000;
	trial_type = first_response;
	trial_duration = forever; 
   picture eindexp;
   target_button = 1;
   response_active = true;
}endexp;


# End of Testitems
trial {
   start_delay = 500;
	trial_duration = 1500; 
   picture aandacht;
}payattention;


# Main trial definition. Play wav sound and send marker at the beginning of each sentence plus
# three crtitical markers during the sentence.

# Main trial definition. Play wav sound and send marker at the beginning of each sentence plus one critical marker,
# namely the onset of the CW = critical marker1 (portcode 200). No critical marker 2 and 3 anymore. 
trial { 
   trial_duration = stimuli_length; 
	monitor_sounds = true;

	#show fixation cross, direct when trail starts time=0#
	stimulus_event {
	picture fix1;
	time = 0;
	} event0;
	    #play sound 1000ms after start picture, sends out code 100=onset sound code
	stimulus_event {
	sound snd; 
   time = 1000;
   code = "onset";
	port_code = 100;
	} wavevent;
	
	#critical marker1
	stimulus_event {
	nothing {};
	deltat = 0; 
   code = "onsetcw";
   port_code = 200;
   } eventlab1;

   #critical marker2		in or out?
   stimulus_event {
	nothing {};
   deltat = 0;
   code = "offsetcw";
   port_code = 210;
	} eventlab2;
	
   #critical marker3 = offsetsentence
   #stimulus_event {
	#nothing {};
   #deltat = 0;
   #code = "offsetsent";
   #port_code = 220;
   #} eventlab3;
   
} playsent;

# Time to press for the next item after fixation cross disappears. Send block nummer as marker at the beginning.
trial {
	#start_delay = 0;
	trial_type = first_response;
	trial_duration = forever; 
   picture default;
   target_button = 1;
   response_active = true;
	stimulus_event { 
   picture default;
	code = "bloknummer";
	port_code = 9;
	} eventblok;
}blink;

# Small breaks, show picture of monsters
trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze1a;
   target_button = 2;
   response_active = true;
} break1a;

trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze1b;
   target_button = 2;
   response_active = true;
} break1b;

trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze2a;
   target_button = 2;
   response_active = true;
} break2a;

trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze2b;
   target_button = 2;
   response_active = true;
} break2b;

trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze3a;
   target_button = 2;
   response_active = true;
} break3a;

trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze3b;
   target_button = 2;
   response_active = true;
} break3b;

trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze4a;
   target_button = 2;
   response_active = true;
} break4a;

trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze4b;
   target_button = 2;
   response_active = true;
} break4b;

trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze5a;
   target_button = 2;
   response_active = true;
} break5a;

trial {
   trial_duration = forever;
	trial_type = first_response;
   picture pauze5b;
   target_button = 2;
   response_active = true;
} break5b;


