// ------------------------------------------------------------
// Fort Valley tutorial scene renderer
// Purpose: establish the "song" of the starting area before
// turning each asset into a dedicated sprite/object strip.
// ------------------------------------------------------------

var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);
var view_w = camera_get_view_width(view_camera[0]);
var view_h = camera_get_view_height(view_camera[0]);

// ---------- helper draw functions ----------
function fv_draw_crate(_x, _y)
{
    draw_set_color(col_wood_dark);
    draw_rectangle(_x, _y, _x + 31, _y + 31, false);
    draw_set_color(col_wood_light);
    draw_rectangle(_x + 3, _y + 3, _x + 28, _y + 28, false);
    draw_set_color(col_wood_dark);
    draw_line(_x + 4, _y + 4, _x + 27, _y + 27);
    draw_line(_x + 27, _y + 4, _x + 4, _y + 27);
    draw_rectangle(_x + 13, _y + 2, _x + 17, _y + 29, false);
    draw_rectangle(_x + 2, _y + 13, _x + 29, _y + 17, false);
}

function fv_draw_snow_pile(_x, _y)
{
    draw_set_color(make_color_rgb(130, 145, 150));
    draw_ellipse(_x, _y + 6, _x + 48, _y + 28, false);
    draw_set_color(make_color_rgb(190, 201, 203));
    draw_ellipse(_x + 4, _y, _x + 44, _y + 23, false);
    draw_set_color(make_color_rgb(224, 229, 229));
    draw_rectangle(_x + 12, _y + 7, _x + 32, _y + 9, false);
}

function fv_draw_lantern_post(_x, _y)
{
    var old_alpha = draw_get_alpha();
    draw_set_alpha(0.16);
    draw_set_color(col_lantern);
    draw_ellipse(_x - 34, _y - 30, _x + 34, _y + 38, false);
    draw_set_alpha(1);

    draw_set_color(make_color_rgb(42, 28, 17));
    draw_rectangle(_x - 2, _y - 28, _x + 2, _y + 18, false);
    draw_rectangle(_x - 10, _y - 29, _x + 10, _y - 25, false);

    draw_set_color(col_lantern);
    draw_rectangle(_x - 5, _y - 25, _x + 5, _y - 13, false);
    draw_set_color(col_lantern_hot);
    draw_rectangle(_x - 3, _y - 22, _x + 3, _y - 15, false);

    draw_set_color(make_color_rgb(30, 22, 16));
    draw_rectangle(_x - 7, _y - 27, _x + 7, _y - 25, false);
    draw_rectangle(_x - 7, _y - 13, _x + 7, _y - 11, false);
    draw_set_alpha(old_alpha);
}

function fv_draw_fence(_x, _y)
{
    draw_set_color(make_color_rgb(63, 43, 27));
    for (var i = 0; i < 6; i++)
    {
        var px = _x + i * 32;
        draw_rectangle(px, _y, px + 6, _y + 38, false);
    }
    draw_set_color(col_wood_mid);
    draw_rectangle(_x - 2, _y + 9, _x + 170, _y + 15, false);
    draw_rectangle(_x - 2, _y + 25, _x + 170, _y + 31, false);
}

function fv_draw_footprints(_x, _y)
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

function fv_draw_order_board(_x, _y)
{
    draw_set_color(col_wood_dark);
    draw_rectangle(_x - 48, _y - 22, _x + 48, _y + 26, false);
    draw_set_color(col_wood_mid);
    draw_rectangle(_x - 44, _y - 18, _x + 44, _y + 22, false);
    draw_set_color(make_color_rgb(22, 17, 13));
    draw_rectangle(_x - 34, _y - 10, _x + 34, _y + 12, false);
    draw_set_color(col_lantern);
    draw_text(_x - 28, _y - 7, "ORDERS");
    draw_set_color(col_wood_dark);
    draw_rectangle(_x - 42, _y + 26, _x - 36, _y + 62, false);
    draw_rectangle(_x + 36, _y + 26, _x + 42, _y + 62, false);
}

function fv_draw_cookhouse_marker(_x, _y)
{
    draw_set_color(col_wood_dark);
    draw_rectangle(_x - 46, _y - 18, _x + 46, _y + 14, false);
    draw_set_color(col_wood_mid);
    draw_rectangle(_x - 42, _y - 14, _x + 42, _y + 10, false);
    draw_set_color(col_lantern);
    draw_text(_x - 36, _y - 10, "COOKHOUSE");
}

function fv_draw_asset(_asset)
{
    if (_asset.kind == "lantern_post") fv_draw_lantern_post(_asset.x, _asset.y);
    else if (_asset.kind == "supply_crate") fv_draw_crate(_asset.x, _asset.y);
    else if (_asset.kind == "snow_pile") fv_draw_snow_pile(_asset.x, _asset.y);
    else if (_asset.kind == "fence") fv_draw_fence(_asset.x, _asset.y);
    else if (_asset.kind == "footprints") fv_draw_footprints(_asset.x, _asset.y);
    else if (_asset.kind == "order_board") fv_draw_order_board(_asset.x, _asset.y);
    else if (_asset.kind == "cookhouse_marker") fv_draw_cookhouse_marker(_asset.x, _asset.y);
}

// ---------- ground ----------
var tile = 32;
var start_x = floor(view_x / tile) * tile - tile;
var start_y = floor(view_y / tile) * tile - tile;
var end_x = view_x + view_w + tile;
var end_y = view_y + view_h + tile;

draw_set_color(col_cold_base);
draw_rectangle(view_x, view_y, view_x + view_w, view_y + view_h, false);

for (var yy = start_y; yy <= end_y; yy += tile)
{
    for (var xx = start_x; xx <= end_x; xx += tile)
    {
        var checker = ((xx div tile) + (yy div tile)) mod 2;
        var stone_col = checker == 0 ? col_stone_a : col_stone_b;
        var snow_col  = checker == 0 ? col_snow_a : col_snow_b;

        draw_set_color(stone_col);
        draw_rectangle(xx, yy, xx + tile, yy + tile, false);

        draw_set_color(col_stone_edge);
        draw_rectangle(xx, yy, xx + tile, yy + 1, false);
        draw_rectangle(xx, yy, xx + 1, yy + tile, false);

        draw_set_color(make_color_rgb(99, 104, 105));
        draw_line(xx + 5, yy + 21, xx + 25, yy + 14);
        draw_set_color(make_color_rgb(50, 54, 56));
        draw_point(xx + 10, yy + 8);
        draw_point(xx + 24, yy + 23);

        draw_set_color(snow_col);
        draw_rectangle(xx + 1, yy + 1, xx + 11, yy + 5, false);
        draw_rectangle(xx + 21, yy + 25, xx + 31, yy + 31, false);
    }
}

// soft road/path rhythm
var old_alpha = draw_get_alpha();
draw_set_alpha(0.18);
draw_set_color(make_color_rgb(224, 213, 170));
for (var path_y = start_y; path_y <= end_y; path_y += 128)
{
    draw_line(start_x, path_y, end_x, path_y - 28);
}
draw_set_alpha(1);

// ---------- props ----------
for (var a = 0; a < array_length(assets); a++)
{
    fv_draw_asset(assets[a]);
}

// ---------- HUD note ----------
// Kept light. This is not the final UI, just orientation for the tutorial room.
draw_set_color(col_ui_dark);
draw_rectangle(view_x + 24, view_y + 24, view_x + 360, view_y + 114, false);
draw_set_color(col_ui_line);
draw_rectangle(view_x + 24, view_y + 24, view_x + 360, view_y + 114, true);
draw_set_color(col_ui_text);
draw_text(view_x + 42, view_y + 40, "FORT VALLEY");
draw_set_color(col_lantern);
draw_text(view_x + 42, view_y + 72, scene_objective);