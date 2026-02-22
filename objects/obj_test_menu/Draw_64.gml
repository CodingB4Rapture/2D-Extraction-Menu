//Draw game title
draw_set_font(Header_font); 
draw_set_halign(fa_center);
draw_set_valign(fa_top);

//Shadow
draw_set_color(c_silver);
draw_text(title_x + 2, title_y + 2, title_text); 

//main
draw_set_color(c_dkgray);
draw_text(title_x, title_y, title_text); 


var draw_x = button_x;
var draw_y = button_y;



var frame = 0; //normal without hover 

if (button_hover)
{
	frame = 1; // equal to 1 when hovered
	draw_y += 2; //lift button up 2 pixels
}

//draw the button sprite
draw_sprite(button_spr, frame, draw_x, draw_y); 

//draw text label cented on bottom 
draw_set_font(UI_font); 
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//shadow (optional but helps to read)
draw_set_color(c_silver);
draw_text(draw_x + button_width * 0.5  + 2, draw_y + button_height * 0.5 + 2, button_text); 

//main text
draw_set_color(c_olive);
draw_text(draw_x + button_width * 0.5, draw_y + button_height * 0.5, button_text);

//reset for optional cleanliness
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_olive);


