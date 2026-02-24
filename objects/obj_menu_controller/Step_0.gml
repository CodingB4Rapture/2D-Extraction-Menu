
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
	    else if (action == MenuAction.CLASS_INFO)	menu_screen = MenuScreen.CLASS_INFO;
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
	// ===========================================
	// MASTER VOLUME SLIDER INPUT (click + drag)
	// ===========================================

	// 1) Read mouse position in GUI space (because menus are GUI)
	var mouse_x_gui = device_mouse_x_to_gui(0);
	var mouse_y_gui = device_mouse_y_to_gui(0);

	// 2) Slider bar position (must match your Draw positions)
	var bar_x = 198;
	var bar_y = 208;

	// 3) Get sprite sizes (so we can calculate track + hitboxes)
	var bar_width  = sprite_get_width(menu_setting_slider);
	var bar_height  = sprite_get_height(menu_setting_slider);

	var knob_width = sprite_get_width(menu_settings_knob);
	var knob_height = sprite_get_height(menu_settings_knob);

	// 4) Convert the stored value (0..1.20) into a travel percent (0..1)
	var travel_percent = (master_value - master_min) / (master_max - master_min);
	travel_percent = clamp(travel_percent, 0, 1);
	// Step event (right after you update master_value while dragging)
	var gain = clamp(master_value, 0, 1);
	audio_master_gain(gain);
	// 5) Define the slider TRACK where the knob center is allowed to move
	//    (This prevents the knob from hanging off the bar edges)
	var track_left_center  = bar_x + knob_width * 0.5;
	var track_right_center = bar_x + bar_width - knob_width * 0.5;

	// 6) Find the knob CENTER position based on the travel percent
	var knob_center_x = lerp(track_left_center, track_right_center, travel_percent);
	var knob_center_y = bar_y + bar_height * 0.5;

	// 7) Convert knob center -> knob draw position (top-left-ish),
	//    then apply your custom offsets so it visually lines up with your art
	var knob_draw_x = knob_center_x - knob_width * 0.5 + sprite_get_xoffset(menu_settings_knob) + master_knob_x_offset;
	var knob_draw_y = knob_center_y - knob_height * 0.5 + sprite_get_yoffset(menu_settings_knob) + master_knob_y_offset;

	// 8) Check if the mouse is currently over the knob (clickable area)


	// knob_draw_x / knob_draw_y are the coordinates you pass to draw_sprite()
	// For hit detection, we need the top-left corner of the sprite on screen:
	var knob_left   = knob_draw_x - sprite_get_xoffset(menu_settings_knob);
	var knob_top    = knob_draw_y - sprite_get_yoffset(menu_settings_knob);
	var knob_right  = knob_left + knob_width;
	var knob_bottom = knob_top + knob_height;

	var mouse_over_knob =
    (mouse_x_gui >= knob_left) && (mouse_x_gui < knob_right) &&
    (mouse_y_gui >= knob_top)  && (mouse_y_gui < knob_bottom);

	// 9) Start dragging only if the user clicks ON the knob
	if (mouse_over_knob && mouse_check_button_pressed(mb_left))
	{
	    master_dragging = true;
	}

	// 10) Stop dragging when the mouse button is released
	if (!mouse_check_button(mb_left))
	{
	    master_dragging = false;
	}

	// 11) While dragging, map mouse X position back into a new slider value
	if (master_dragging)
	{
	var visual_left  = track_left_center  + master_knob_x_offset;
	var visual_right = track_right_center + master_knob_x_offset;

	var new_percent = (mouse_x_gui - visual_left) / (visual_right - visual_left);
	new_percent = clamp(new_percent, 0, 1);

	master_value = lerp(master_min, master_max, new_percent);
	}
}
else if (menu_screen == MenuScreen.CLASS_INFO) {
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
}
