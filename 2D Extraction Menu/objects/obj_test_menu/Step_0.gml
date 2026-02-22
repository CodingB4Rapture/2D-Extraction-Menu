
//mouse position converted to GUI coordinates
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

//hover test = 
button_hover = false; 

if (mx >= button_x && mx < button_x + button_width)
{
	if (my >= button_y && my < button_y + button_height)
	{
		button_hover = true;
	}
}

//lets get the click behavior in

if (button_hover) {
	if (mouse_check_button_pressed(mb_left))
	{
		show_debug_message("DEPLOY clicked");
		menu_state = MenuState.DEPLOY; //proof screen toggle will work
	}
}

