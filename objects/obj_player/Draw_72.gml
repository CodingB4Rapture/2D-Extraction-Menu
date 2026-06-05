// ------------------------------------------------------------
// Temporary Fort Valley ground renderer
// Draw Begin event: runs before the normal player draw.
// This upgrades the plain tiled background without touching
// portal or sacred sign sprites.
// ------------------------------------------------------------

var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);
var view_w = camera_get_view_width(view_camera[0]);
var view_h = camera_get_view_height(view_camera[0]);

var tile = 32;
var start_x = floor(view_x / tile) * tile - tile;
var start_y = floor(view_y / tile) * tile - tile;
var end_x = view_x + view_w + tile;
var end_y = view_y + view_h + tile;

// deep cold base
draw_set_color(make_color_rgb(47, 50, 53));
draw_rectangle(view_x, view_y, view_x + view_w, view_y + view_h, false);

// Fort Valley worn stone / packed snow grid
for (var yy = start_y; yy <= end_y; yy += tile)
{
    for (var xx = start_x; xx <= end_x; xx += tile)
    {
        var checker = ((xx div tile) + (yy div tile)) mod 2;
        var stone_col = checker == 0 ? make_color_rgb(88, 91, 92) : make_color_rgb(78, 82, 84);
        var snow_col  = checker == 0 ? make_color_rgb(174, 184, 187) : make_color_rgb(154, 164, 168);

        // most of the ground is cold stone, with snow packed into the upper edge
        draw_set_color(stone_col);
        draw_rectangle(xx, yy, xx + tile, yy + tile, false);

        draw_set_color(make_color_rgb(38, 40, 42));
        draw_rectangle(xx, yy, xx + tile, yy + 1, false);
        draw_rectangle(xx, yy, xx + 1, yy + tile, false);

        draw_set_color(make_color_rgb(111, 115, 116));
        draw_line(xx + 4, yy + 18, xx + 26, yy + 12);

        // snow drift corners to keep the Fort Valley cold visible
        draw_set_color(snow_col);
        draw_rectangle(xx + 1, yy + 1, xx + 10, yy + 5, false);
        draw_rectangle(xx + 22, yy + 25, xx + 31, yy + 31, false);
    }
}

// subtle long path lines so the room feels like an established supply yard
draw_set_alpha(0.22);
draw_set_color(make_color_rgb(215, 210, 184));
for (var path_y = start_y; path_y <= end_y; path_y += 128)
{
    draw_line(start_x, path_y, end_x, path_y - 28);
}
draw_set_alpha(1);