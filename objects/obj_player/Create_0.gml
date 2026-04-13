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
