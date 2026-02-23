display_set_gui_size(1280, 720);

//store the offsets i found so my step + draw use the same values
master_knob_x_offset = -100; 
master_knob_y_offset = -8;
//Sound Settings
master_min = 0.0; 
master_max = 1.00; 
master_dragging = false; 
master_value = clamp(audio_get_master_gain(0), master_min, master_max);


title_text = "2D EXTRACTION TO EIRENE"; //change to final name later
title_x = 1280 * 0.5; //this will center my X axis 
title_y = 12; //top padding 
title_scale = 2;
//For the footer of main menu/other screens if I want it there
footer_text = "Remember the Mission.";
footer_x = 1280 * 0.5; //center on x axis yet again for footer
footer_y = 672;


//enumerator for menu screen and WHERE I'm at
enum MenuScreen { MAIN, SETTINGS }
menu_screen = MenuScreen.MAIN;
set_fullscreen = window_get_fullscreen();
set_master = 0.80; //0..1 for now

//back button (top left)
back_button_hover = false;
back_button_x = 48;
back_button_y = 32;
back_button_width = sprite_get_width(menu_back_arrow);
back_button_height = sprite_get_height(menu_back_arrow); 
back_button_label = "BACK"; //didnt end up using label.. arrow is kind of self-explanitory

enum MenuAction {PLAY_GAME, LOADOUT, SETTINGS, ABOUT_OUR_TEAM, QUIT}

//which button is being hovered or selec. This will matter on how things look
hovered_button_index = -1; 
selected_button_index = -1; 

//button list for main menu screen for first initial screen
buttons = [
	{ //Deploy button
		spr: menu_UI_Button,
		x: 80, y: 160,
		width: sprite_get_width(menu_UI_Button),
		height: sprite_get_height(menu_UI_Button),
		label: "PLAY GAME",
		description: "Go on a Deployment.",
		action: MenuAction.PLAY_GAME
	},
	{ // Loudout button
		spr: menu_UI_Button,
		x: 80, y: 240,
		width: sprite_get_width(menu_UI_Button),
		height: sprite_get_height(menu_UI_Button),
		label: "LOADOUT",
		description: "Go your loadout, see what you want to bring with you.",
		action: MenuAction.LOADOUT
	},
	{ // Settings Button
		spr: menu_UI_Button,
		x: 80, y: 320,
		width: sprite_get_width(menu_UI_Button),
		height: sprite_get_height(menu_UI_Button),
		label: "SETTINGS",
		description: "Adjust your game and sound settings.",
		action: MenuAction.SETTINGS
	},
	{ //About Our Team button
		spr: menu_UI_Button,
		x: 80, y: 400,
		width: sprite_get_width(menu_UI_Button),
		height: sprite_get_height(menu_UI_Button),
		label: "CLASS INFO",
		description: " \tBushcrafter:\n \n Resourceful Hunter \n\n \tMechanic:\n\n Clunky Scrapper and fixerupper \n\n \tMedic: \n\n Hopefully they'll heal you.",
		action: MenuAction.ABOUT_OUR_TEAM
	},
	{ //Quit Button
		spr: menu_UI_Button,
		x: 80, y: 480,
		width: sprite_get_width(menu_UI_Button),
		height: sprite_get_height(menu_UI_Button),
		label: "QUIT",
		description: "Quit the Game. Thanks for playing.",
		action: MenuAction.QUIT
	},
];

//right panel text box area (this is where I'll edit my text for descriptions)
description_x = 720;
description_y = 170; 
description_width = 480; //wrap width

