// ------------------------------------------------------------
// Temporary Fire Watchers top-down renderer
// First draws a Fort Valley-style ground pass, then draws the
// Gideon-style walking character over it.
// ------------------------------------------------------------

var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);
var view_w = camera_get_view_width(view_camera[0]);
var view_h = camera_get_view_height(view_camera[0]);

// ------------------------------------------------------------
// Fort Valley ground pass. This is here, not Draw Begin, because
// Draw Begin did not visibly fire in the current project setup.
// ------------------------------------------------------------
var tile = 32;
var start_x = floor(view_x / tile) * tile - tile;
var start_y = floor(view_y / tile) * tile - tile;
var end_x = view_x + view_w + tile;
var end_y = view_y + view_h + tile;

// deep cold base
draw_set_color(make_color_rgb(47, 50, 53));
draw_rectangle(view_x, view_y, view_x + view_w, view_y + view_h, false);

for (var yy = start_y; yy <= end_y; yy += tile)
{
    for (var xx = start_x; xx <= end_x; xx += tile)
    {
        var checker = ((xx div tile) + (yy div tile)) mod 2;
        var stone_col = checker == 0 ? make_color_rgb(88, 91, 92) : make_color_rgb(78, 82, 84);
        var snow_col  = checker == 0 ? make_color_rgb(174, 184, 187) : make_color_rgb(154, 164, 168);

        draw_set_color(stone_col);
        draw_rectangle(xx, yy, xx + tile, yy + tile, false);

        draw_set_color(make_color_rgb(38, 40, 42));
        draw_rectangle(xx, yy, xx + tile, yy + 1, false);
        draw_rectangle(xx, yy, xx + 1, yy + tile, false);

        draw_set_color(make_color_rgb(111, 115, 116));
        draw_line(xx + 4, yy + 18, xx + 26, yy + 12);

        draw_set_color(snow_col);
        draw_rectangle(xx + 1, yy + 1, xx + 10, yy + 5, false);
        draw_rectangle(xx + 22, yy + 25, xx + 31, yy + 31, false);
    }
}

// subtle long path lines so Fort Valley feels like an established supply yard
var old_alpha = draw_get_alpha();
draw_set_alpha(0.22);
draw_set_color(make_color_rgb(215, 210, 184));
for (var path_y = start_y; path_y <= end_y; path_y += 128)
{
    draw_line(start_x, path_y, end_x, path_y - 28);
}
draw_set_alpha(old_alpha);

// ------------------------------------------------------------
// Character draw
// ------------------------------------------------------------
var s = player_pixel_scale;
var ox = x - 16 * s;
var oy = y - 28 * s;
var step_offset = 0;

if (player_is_moving)
{
    step_offset = (walk_anim_frame == 0) ? -1 : 1;
}

// soft ground shadow
old_alpha = draw_get_alpha();
draw_set_alpha(0.35);
draw_set_color(col_shadow);
draw_ellipse(x - 9 * s, y - 3 * s, x + 9 * s, y + 4 * s, false);
draw_set_alpha(old_alpha);

// boots / legs
if (facing == moveDir.DOWN || facing == moveDir.UP)
{
    draw_set_color(col_pants);
    draw_rectangle(ox + 11*s, oy + (20 - step_offset)*s, ox + 14*s, oy + (25 - step_offset)*s, false);
    draw_rectangle(ox + 17*s, oy + (20 + step_offset)*s, ox + 20*s, oy + (25 + step_offset)*s, false);

    draw_set_color(col_boots);
    draw_rectangle(ox + 11*s, oy + (26 - step_offset)*s, ox + 15*s, oy + (28 - step_offset)*s, false);
    draw_rectangle(ox + 16*s, oy + (26 + step_offset)*s, ox + 20*s, oy + (28 + step_offset)*s, false);
}
else
{
    draw_set_color(col_pants);
    draw_rectangle(ox + 12*s, oy + (20 + step_offset)*s, ox + 15*s, oy + (25 + step_offset)*s, false);
    draw_rectangle(ox + 17*s, oy + (20 - step_offset)*s, ox + 20*s, oy + (25 - step_offset)*s, false);

    draw_set_color(col_boots);
    draw_rectangle(ox + 12*s, oy + (26 + step_offset)*s, ox + 16*s, oy + (28 + step_offset)*s, false);
    draw_rectangle(ox + 16*s, oy + (26 - step_offset)*s, ox + 20*s, oy + (28 - step_offset)*s, false);
}

// coat body
draw_set_color(col_coat_dark);
draw_rectangle(ox + 9*s, oy + 12*s, ox + 22*s, oy + 20*s, false);
draw_set_color(col_coat_mid);
draw_rectangle(ox + 11*s, oy + 13*s, ox + 20*s, oy + 18*s, false);

// arms with tiny walking swing
var arm_swing = player_is_moving ? step_offset : 0;
draw_set_color(col_coat_dark);
draw_rectangle(ox + 6*s, oy + (13 + arm_swing)*s, ox + 9*s, oy + (20 + arm_swing)*s, false);
draw_rectangle(ox + 22*s, oy + (13 - arm_swing)*s, ox + 25*s, oy + (20 - arm_swing)*s, false);

// belt
draw_set_color(col_belt);
draw_rectangle(ox + 9*s, oy + 18*s, ox + 22*s, oy + 19*s, false);
draw_set_color(col_buckle);
draw_rectangle(ox + 15*s, oy + 18*s, ox + 16*s, oy + 19*s, false);

// collar
draw_set_color(col_collar);
draw_rectangle(ox + 10*s, oy + 11*s, ox + 21*s, oy + 13*s, false);

// head / hair / hat by facing direction
if (facing == moveDir.UP)
{
    draw_set_color(col_hair);
    draw_rectangle(ox + 11*s, oy + 5*s, ox + 21*s, oy + 10*s, false);

    draw_set_color(col_hat);
    draw_rectangle(ox + 10*s, oy + 4*s, ox + 22*s, oy + 5*s, false);
    draw_rectangle(ox + 12*s, oy + 2*s, ox + 20*s, oy + 4*s, false);
}
else if (facing == moveDir.LEFT)
{
    draw_set_color(col_skin);
    draw_rectangle(ox + 12*s, oy + 7*s, ox + 19*s, oy + 12*s, false);
    draw_set_color(col_hair);
    draw_rectangle(ox + 15*s, oy + 5*s, ox + 21*s, oy + 9*s, false);
    draw_set_color(col_hat);
    draw_rectangle(ox + 11*s, oy + 4*s, ox + 21*s, oy + 5*s, false);
    draw_rectangle(ox + 13*s, oy + 2*s, ox + 20*s, oy + 4*s, false);
    draw_set_color(col_shadow);
    draw_point(ox + 14*s, oy + 9*s);
}
else if (facing == moveDir.RIGHT)
{
    draw_set_color(col_skin);
    draw_rectangle(ox + 13*s, oy + 7*s, ox + 20*s, oy + 12*s, false);
    draw_set_color(col_hair);
    draw_rectangle(ox + 10*s, oy + 5*s, ox + 16*s, oy + 9*s, false);
    draw_set_color(col_hat);
    draw_rectangle(ox + 10*s, oy + 4*s, ox + 21*s, oy + 5*s, false);
    draw_rectangle(ox + 11*s, oy + 2*s, ox + 18*s, oy + 4*s, false);
    draw_set_color(col_shadow);
    draw_point(ox + 18*s, oy + 9*s);
}
else
{
    draw_set_color(col_skin);
    draw_rectangle(ox + 12*s, oy + 7*s, ox + 20*s, oy + 12*s, false);

    draw_set_color(col_hair);
    draw_rectangle(ox + 11*s, oy + 5*s, ox + 21*s, oy + 8*s, false);

    draw_set_color(col_hat);
    draw_rectangle(ox + 10*s, oy + 4*s, ox + 22*s, oy + 5*s, false);
    draw_rectangle(ox + 12*s, oy + 2*s, ox + 20*s, oy + 4*s, false);

    draw_set_color(col_shadow);
    draw_point(ox + 14*s, oy + 9*s);
    draw_point(ox + 18*s, oy + 9*s);
}

draw_set_alpha(1);