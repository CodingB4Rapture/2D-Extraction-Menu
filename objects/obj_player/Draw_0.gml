// ------------------------------------------------------------
// Temporary Fire Watchers top-down renderer
// Richer Fort Valley mockup pass + Gideon-style walking player.
// This is still scaffolding, but closer to the target: readable
// top-down survival RPG with cold stone, snow, supply-yard props,
// and warm lantern accents.
// ------------------------------------------------------------

var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);
var view_w = camera_get_view_width(view_camera[0]);
var view_h = camera_get_view_height(view_camera[0]);

// ------------------------------------------------------------
// Fort Valley ground pass
// ------------------------------------------------------------
var tile = 32;
var start_x = floor(view_x / tile) * tile - tile;
var start_y = floor(view_y / tile) * tile - tile;
var end_x = view_x + view_w + tile;
var end_y = view_y + view_h + tile;

// cold underpaint
draw_set_color(make_color_rgb(35, 39, 43));
draw_rectangle(view_x, view_y, view_x + view_w, view_y + view_h, false);

// worn stone and packed snow tiles
for (var yy = start_y; yy <= end_y; yy += tile)
{
    for (var xx = start_x; xx <= end_x; xx += tile)
    {
        var checker = ((xx div tile) + (yy div tile)) mod 2;
        var stone_col = checker == 0 ? make_color_rgb(78, 82, 84) : make_color_rgb(68, 73, 76);
        var edge_col  = make_color_rgb(35, 38, 41);
        var snow_col  = checker == 0 ? make_color_rgb(176, 187, 190) : make_color_rgb(151, 163, 167);

        draw_set_color(stone_col);
        draw_rectangle(xx, yy, xx + tile, yy + tile, false);

        // stone seams
        draw_set_color(edge_col);
        draw_rectangle(xx, yy, xx + tile, yy + 1, false);
        draw_rectangle(xx, yy, xx + 1, yy + tile, false);

        // chisel scratch / visual texture
        draw_set_color(make_color_rgb(99, 104, 105));
        draw_line(xx + 5, yy + 21, xx + 25, yy + 14);
        draw_set_color(make_color_rgb(50, 54, 56));
        draw_point(xx + 10, yy + 8);
        draw_point(xx + 24, yy + 23);

        // snow corners
        draw_set_color(snow_col);
        draw_rectangle(xx + 1, yy + 1, xx + 11, yy + 5, false);
        draw_rectangle(xx + 21, yy + 25, xx + 31, yy + 31, false);

        draw_set_color(make_color_rgb(205, 213, 214));
        draw_point(xx + 4, yy + 3);
        draw_point(xx + 27, yy + 29);
    }
}

// diagonal supply-yard path lines
var old_alpha = draw_get_alpha();
draw_set_alpha(0.18);
draw_set_color(make_color_rgb(224, 213, 170));
for (var path_y = start_y; path_y <= end_y; path_y += 128)
{
    draw_line(start_x, path_y, end_x, path_y - 28);
}
draw_set_alpha(1);

// ------------------------------------------------------------
// Static mockup props for Fort Valley feel
// ------------------------------------------------------------
function draw_crate(_x, _y)
{
    draw_set_color(make_color_rgb(75, 49, 29));
    draw_rectangle(_x, _y, _x + 31, _y + 31, false);
    draw_set_color(make_color_rgb(112, 76, 43));
    draw_rectangle(_x + 3, _y + 3, _x + 28, _y + 28, false);
    draw_set_color(make_color_rgb(52, 34, 22));
    draw_line(_x + 4, _y + 4, _x + 27, _y + 27);
    draw_line(_x + 27, _y + 4, _x + 4, _y + 27);
    draw_rectangle(_x + 13, _y + 2, _x + 17, _y + 29, false);
    draw_rectangle(_x + 2, _y + 13, _x + 29, _y + 17, false);
}

function draw_snow_pile(_x, _y)
{
    draw_set_color(make_color_rgb(130, 145, 150));
    draw_ellipse(_x, _y + 6, _x + 48, _y + 28, false);
    draw_set_color(make_color_rgb(190, 201, 203));
    draw_ellipse(_x + 4, _y, _x + 44, _y + 23, false);
    draw_set_color(make_color_rgb(224, 229, 229));
    draw_rectangle(_x + 12, _y + 7, _x + 32, _y + 9, false);
}

function draw_lantern_post(_x, _y)
{
    // warm glow first
    old_alpha = draw_get_alpha();
    draw_set_alpha(0.16);
    draw_set_color(make_color_rgb(251, 217, 108));
    draw_ellipse(_x - 34, _y - 30, _x + 34, _y + 38, false);
    draw_set_alpha(1);

    draw_set_color(make_color_rgb(42, 28, 17));
    draw_rectangle(_x - 2, _y - 28, _x + 2, _y + 18, false);
    draw_rectangle(_x - 10, _y - 29, _x + 10, _y - 25, false);

    draw_set_color(make_color_rgb(251, 217, 108));
    draw_rectangle(_x - 5, _y - 25, _x + 5, _y - 13, false);
    draw_set_color(make_color_rgb(224, 122, 47));
    draw_rectangle(_x - 3, _y - 22, _x + 3, _y - 15, false);

    draw_set_color(make_color_rgb(30, 22, 16));
    draw_rectangle(_x - 7, _y - 27, _x + 7, _y - 25, false);
    draw_rectangle(_x - 7, _y - 13, _x + 7, _y - 11, false);
    draw_set_alpha(old_alpha);
}

function draw_wood_fence(_x, _y)
{
    draw_set_color(make_color_rgb(63, 43, 27));
    for (var i = 0; i < 6; i++)
    {
        var px = _x + i * 32;
        draw_rectangle(px, _y, px + 6, _y + 38, false);
    }
    draw_set_color(make_color_rgb(94, 64, 39));
    draw_rectangle(_x - 2, _y + 9, _x + 170, _y + 15, false);
    draw_rectangle(_x - 2, _y + 25, _x + 170, _y + 31, false);
}

function draw_footprints(_x, _y)
{
    draw_set_alpha(0.28);
    draw_set_color(make_color_rgb(48, 54, 58));
    for (var i = 0; i < 8; i++)
    {
        var px = _x + i * 18;
        var py = _y - i * 5;
        draw_rectangle(px, py, px + 5, py + 2, false);
        draw_rectangle(px + 7, py + 8, px + 12, py + 10, false);
    }
    draw_set_alpha(1);
}

// Prop coordinates chosen around current rm_valley player start area.
draw_lantern_post(704, 2944);
draw_lantern_post(832, 3032);
draw_wood_fence(608, 2896);
draw_crate(640, 2992);
draw_crate(672, 2992);
draw_crate(704, 3024);
draw_crate(896, 2960);
draw_snow_pile(560, 3038);
draw_snow_pile(944, 3038);
draw_snow_pile(800, 2898);
draw_footprints(650, 3070);

// ------------------------------------------------------------
// Character draw
// ------------------------------------------------------------
var s = 2; // bigger, clearer top-down RPG silhouette
var ox = x - 16 * s;
var oy = y - 28 * s;
var step_offset = 0;

if (player_is_moving)
{
    step_offset = (walk_anim_frame == 0) ? -1 : 1;
}

// soft ground shadow
old_alpha = draw_get_alpha();
draw_set_alpha(0.42);
draw_set_color(col_shadow);
draw_ellipse(x - 12 * s, y - 4 * s, x + 12 * s, y + 5 * s, false);
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