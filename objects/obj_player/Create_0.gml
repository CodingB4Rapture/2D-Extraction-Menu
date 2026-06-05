hsp = 0;
vsp = 0;

move_speed = 2;
diag_speed = move_speed / sqrt(2);

// direction tracking
enum moveDir {
    UP,
    DOWN,
    LEFT,
    RIGHT
}

facing = moveDir.DOWN;

// ------------------------------------------------------------
// Fire Watchers temporary hero animation state
// This keeps the first vertical slice moving without needing
// imported sprite sheets yet. Later this can be swapped for
// hand-painted sprite frames while keeping the same variables.
// ------------------------------------------------------------
player_is_moving = false;
walk_anim_timer = 0;
walk_anim_frame = 0;
walk_anim_speed = 8;

// draw scale for a 32x32 top-down RPG character
player_pixel_scale = 1;

// Gideon-inspired Fort Valley palette
col_boots     = make_color_rgb(42, 30, 22);
col_pants     = make_color_rgb(54, 73, 92);
col_coat_dark = make_color_rgb(74, 48, 31);
col_coat_mid  = make_color_rgb(94, 61, 38);
col_collar    = make_color_rgb(184, 169, 143);
col_skin      = make_color_rgb(214, 176, 139);
col_hair      = make_color_rgb(45, 32, 27);
col_hat       = make_color_rgb(54, 41, 34);
col_belt      = make_color_rgb(65, 42, 24);
col_buckle    = make_color_rgb(194, 138, 52);
col_shadow    = make_color_rgb(22, 18, 15);