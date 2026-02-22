if (menu_screen == MenuScreen.MAIN)
{
	
	//Draw game title
	draw_set_font(Header_font); 
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	//Shadow
	draw_set_color(c_dkgray);
	draw_text(title_x + 2, title_y + 2, title_text); 

	//main
	draw_set_color(c_silver);
	draw_text(title_x, title_y, title_text); 

	// Main menu background panels (used to be on room asset layer)
	draw_sprite(menu_UI_Left_Panel,  0,  60, 136);
	draw_sprite(menu_UI_Right_Panel, 0, 624, 136);
	// Draw all buttons
	for (var button_index = 0; button_index < array_length(buttons); button_index++)
	{
	    var button = buttons[button_index];

	    var is_hovered = (button_index == hovered_button_index);

	    var frame = 0;
	    if (is_hovered) frame = 1;

	    var draw_x = button.x;
	    var draw_y = button.y;

	    if (is_hovered) draw_y += -4;

	    draw_sprite(button.spr, frame, draw_x, draw_y);

	    draw_set_font(UI_font);
	    draw_set_halign(fa_center);
	    draw_set_valign(fa_middle);

	    var center_x = draw_x + button.width * 0.5;
	    var center_y = draw_y + button.height * 0.5;

	    draw_set_color(c_black);
	    draw_text(center_x + 2, center_y + 2, button.label);

	    draw_set_color(c_silver);
	    draw_text(center_x, center_y, button.label);
	}

	// Right panel description (hover wins, else selected)
	var desc_text = "Hover a button to see details.";

	if (hovered_button_index != -1)
	{
	    desc_text = buttons[hovered_button_index].description;
	}
	else if (selected_button_index != -1)
	{
	    desc_text = buttons[selected_button_index].description;
	}

	draw_set_font(UI_font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_silver); //UI text


	draw_set_font(UI_font);
	draw_set_font(description_font);
	// auto line spacing: font size + a little breathing room
	var line_spacing = font_get_size(description_font) + 2;

	draw_text_ext(description_x, description_y, desc_text, line_spacing, description_width);



	//Draw game title
	draw_set_font(Header_font); 
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);

	//Shadow
	draw_set_color(c_dkgray);
	draw_text(footer_x + 2, footer_y + 2, footer_text); 

	//main
	draw_set_color(c_silver);
	draw_text(footer_x, footer_y, footer_text); 
}
else if (menu_screen == MenuScreen.SETTINGS)
{
    // --- Background ---
    // If your room already draws the same background, you can skip this.
    // Otherwise draw it here if obj_menu_controller has a background sprite.
	//Draw game title
	draw_set_font(Header_font); 
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	//Shadow
	draw_set_color(c_dkgrey);
	draw_text(title_x + 2, title_y + 2, title_text); 

	//main
	draw_set_color(c_silver);
	draw_text(title_x, title_y, title_text); 
    // --- Panels (your "columns") ---
// --- SETTINGS COLUMN PLACEMENT (visual scaffolding only) ---
	// SETTINGS text defaults (everything in this screen starts from here)
	draw_set_font(UI_font);
	draw_set_color(c_ltgray);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var panel_y = 356;
	var panel_x_start = 198;
	var panel_padding = 296;
	
	var first_panel_x  = panel_x_start;
	var second_panel_x = panel_x_start + panel_padding;
	var third_panel_x = panel_x_start + panel_padding * 2;
	var fourth_panel_x = panel_x_start + panel_padding * 3;

	// Panels (your "columns")
	draw_sprite(menu_column_panel, 0, first_panel_x, panel_y);
	draw_sprite(menu_column_panel, 0, second_panel_x, panel_y);
	draw_sprite(menu_column_panel, 0, third_panel_x, panel_y);
	draw_sprite(menu_column_panel, 0, fourth_panel_x, panel_y);
	
	var column_header_y = 152; 
	var column_header_x_start = 198; 
	
	var first_header_x = column_header_x_start;
	var second_header_x = column_header_x_start + panel_padding;
	var third_header_x = column_header_x_start + panel_padding * 2;
	var fourth_header_x = column_header_x_start + panel_padding * 3;
	
	draw_sprite(menu_column_header, 0, first_header_x, column_header_y);
	draw_sprite(menu_column_header, 0, second_header_x, column_header_y); 
	draw_sprite(menu_column_header, 0, third_header_x, column_header_y); 
	draw_sprite(menu_column_header, 0, fourth_header_x, column_header_y); 
	
	//Shadow
	draw_set_color(c_dkgrey);
	draw_text(first_header_x - 70, column_header_y - 28, "AUDIO"); 
	draw_text(second_header_x - 102, column_header_y - 28, "GRAPHICS"); 
	
	draw_text(third_header_x - 110, column_header_y - 28, "CONTROLS"); 
	draw_text(fourth_header_x - 42, column_header_y - 28, "ETC."); 
	
    
	draw_set_font(UI_font);
	draw_set_color(c_silver);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var header_text_padding_x = 20;
	var header_text_padding_y = 14; 
	draw_text(first_header_x - 72, column_header_y - 28, "AUDIO"); 
	draw_text(second_header_x - 104, column_header_y - 28, "GRAPHICS"); 
	
	draw_text(third_header_x - 112, column_header_y - 28, "CONTROLS"); 
	draw_text(fourth_header_x - 44, column_header_y - 28, "ETC."); 
	
	//Draw game title
	draw_set_font(Header_font); 
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);

	//Shadow
	draw_set_color(c_dkgrey);
	draw_text(footer_x + 2, footer_y + 2, footer_text); 

	//main
	draw_set_color(c_silver);
	draw_text(footer_x, footer_y, footer_text); 
	
	// --- BACK button ---
	var back_frame = back_button_hover ? 1 : 0;
	draw_sprite(menu_back_arrow, back_frame, back_button_x + 8, back_button_y + 8);
		// Header text uses the stencil font
	
    

    // --- We'll draw checkbox + slider next ---
    
    exit; // IMPORTANT: prevents your MAIN draw code from running underneath
}