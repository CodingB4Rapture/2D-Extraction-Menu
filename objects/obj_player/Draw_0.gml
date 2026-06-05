// ------------------------------------------------------------
// Temporary Fire Watchers top-down character renderer
// Drawn in code so the game can immediately have a walking
// Gideon-style placeholder without importing sprite sheets yet.
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
var old_alpha = draw_get_alpha();
draw_set_alpha(0.35);
draw_set_color(col_shadow);
draw_ellipse(x - 9 * s, y - 3 * s, x + 9 * s, y + 4 * s, false);
draw_set_alpha(old_alpha);

// helpers are intentionally simple rectangles for crisp pixel readability
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