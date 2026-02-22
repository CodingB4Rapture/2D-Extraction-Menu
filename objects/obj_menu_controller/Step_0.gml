
// mouse in GUI space
var mymouse_x = device_mouse_x_to_gui(0);
var mymouse_y = device_mouse_y_to_gui(0);
if (menu_screen == MenuScreen.MAIN)
{
	// assume no hover
	hovered_button_index = -1;

	// find hovered button (first match wins)
	for (var button_index = 0; button_index < array_length(buttons); button_index++)
	{
	    var button = buttons[button_index];

	    var inside_left   = (mymouse_x >= button.x);
	    var inside_right  = (mymouse_x <  button.x + button.width);
	    var inside_top    = (mymouse_y >= button.y);
	    var inside_bottom = (mymouse_y <  button.y + button.height);

	    if (inside_left && inside_right && inside_top && inside_bottom)
	    {
	        hovered_button_index = button_index;
	        break;
	    }
	}

	// click activates
	if (hovered_button_index != -1 && mouse_check_button_pressed(mb_left))
	{
	    selected_button_index = hovered_button_index;

	    var action = buttons[selected_button_index].action;

	    if (action == MenuAction.PLAY_GAME)            show_debug_message("PLAY GAME clicked");
	    else if (action == MenuAction.LOADOUT)      show_debug_message("LOADOUT clicked");
	    else if (action == MenuAction.SETTINGS)     menu_screen = MenuScreen.SETTINGS;//should I go to SETTINGS room here?
	    else if (action == MenuAction.ABOUT_OUR_TEAM) show_debug_message("ABOUT clicked");
	    else if (action == MenuAction.QUIT)         game_end();
	}
}
else if (menu_screen == MenuScreen.SETTINGS) {
	// --------------------------------------------
	// BACK BUTTON HOVER (human readable version)
	// --------------------------------------------

	// We'll calculate a hover rectangle that matches the visible arrow,
	// not the full sprite size (which may include transparent padding).

	var spr = menu_back_arrow;

	// 1) Get the visible bounding box of the sprite (in sprite coordinates)
	var arrow_left   = sprite_get_bbox_left(spr);
	var arrow_top    = sprite_get_bbox_top(spr);
	var arrow_right  = sprite_get_bbox_right(spr);
	var arrow_bottom = sprite_get_bbox_bottom(spr);

	// 2) Get the sprite's origin offset (also in sprite coordinates)
	var origin_x = sprite_get_xoffset(spr);
	var origin_y = sprite_get_yoffset(spr);

	// 3) Convert that bounding box into GUI-space coordinates
	//    back_button_x/back_button_y is where you DRAW the sprite.
	//    The origin matters, so we subtract origin to align correctly.
	var hover_left   = back_button_x + (arrow_left   - origin_x);
	var hover_top    = back_button_y + (arrow_top    - origin_y);
	var hover_right  = back_button_x + (arrow_right  - origin_x);
	var hover_bottom = back_button_y + (arrow_bottom - origin_y);

	// 4) Check if the mouse is inside that hover rectangle
	var mouse_over_back =
	    (mymouse_x >= hover_left) && (mymouse_x < hover_right) &&
	    (mymouse_y >= hover_top)  && (mymouse_y < hover_bottom);

	// 5) Store hover state for drawing (frame 0 vs 1)
	back_button_hover = mouse_over_back;

	// 6) If clicked while hovering, go back to MAIN
	if (mouse_over_back && mouse_check_button_pressed(mb_left))
	{
	    menu_screen = MenuScreen.MAIN;
	    exit;
	}
		//Settings INPUT will go here (Checkboxes and sliders)
}
