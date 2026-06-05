// ------------------------------------------------------------
// Fort Valley tutorial scene controller
// Canonical role: established mountain recruitment/supply yard
// before the Avalanche breaks the world open.
// ------------------------------------------------------------

scene_name = "Fort Valley";
scene_objective = "Report to the Order Designation Board.";

// Resolution target from the menu/front-end setup.
scene_gui_w = 1280;
scene_gui_h = 720;

// Asset registry: each entry represents a future real object/sprite asset.
// For now each one is drawn by the controller so placement/composition can
// be tested before committing to sprite strips and collision rules.
assets = [];

function fv_add_asset(_kind, _x, _y)
{
    array_push(assets, { kind: _kind, x: _x, y: _y });
}

// Starting area around Gideon in rm_valley.
fv_add_asset("lantern_post", 704, 2944);
fv_add_asset("lantern_post", 832, 3032);
fv_add_asset("order_board", 720, 2876);
fv_add_asset("cookhouse_marker", 598, 2932);
fv_add_asset("supply_crate", 640, 2992);
fv_add_asset("supply_crate", 672, 2992);
fv_add_asset("supply_crate", 704, 3024);
fv_add_asset("supply_crate", 896, 2960);
fv_add_asset("snow_pile", 560, 3038);
fv_add_asset("snow_pile", 944, 3038);
fv_add_asset("snow_pile", 800, 2898);
fv_add_asset("fence", 608, 2896);
fv_add_asset("footprints", 650, 3070);

// Future tutorial beats. These become interaction triggers later.
tutorial_steps = [
    "Move through Fort Valley.",
    "Find the Order Designation Board.",
    "Talk to the supply clerk.",
    "Carry a crate to the cookhouse.",
    "Return before the storm bell."
];

tutorial_step = 0;

// Palette for the current in-code visual target.
col_cold_base   = make_color_rgb(35, 39, 43);
col_stone_a     = make_color_rgb(78, 82, 84);
col_stone_b     = make_color_rgb(68, 73, 76);
col_stone_edge  = make_color_rgb(35, 38, 41);
col_snow_a      = make_color_rgb(176, 187, 190);
col_snow_b      = make_color_rgb(151, 163, 167);
col_lantern     = make_color_rgb(251, 217, 108);
col_lantern_hot = make_color_rgb(224, 122, 47);
col_wood_dark   = make_color_rgb(52, 34, 22);
col_wood_mid    = make_color_rgb(94, 64, 39);
col_wood_light  = make_color_rgb(112, 76, 43);
col_ui_dark     = make_color_rgb(18, 18, 17);
col_ui_line     = make_color_rgb(88, 76, 58);
col_ui_text     = make_color_rgb(218, 210, 188);