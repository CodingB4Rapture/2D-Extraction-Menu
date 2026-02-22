//Lock GUI coordinates to menu design sizes
display_set_gui_size(1280, 720); 

title_text = "2D EXTRACTION TO EIRENE"; //change to final name later
title_x = 1280 * 0.5; //this will center my X axis 
title_y = 48; //top padding 
title_scale = 2;
//menu "screen" state 
enum MenuState { MAIN, DEPLOY, SETTINGS }
menu_state = MenuState.MAIN;

button_spr = menu_UI_Button; //2 frame button sprite
button_x = 80; 
button_y = 160; 
button_width = sprite_get_width(button_spr); 
button_height = sprite_get_height(button_spr); 
button_text = "DEPLOY";

//runtime button state
button_hover = false; 

