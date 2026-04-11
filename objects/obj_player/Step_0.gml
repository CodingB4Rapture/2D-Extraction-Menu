var left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

// calculate movement
hsp = (right - left) * move_speed;
vsp = (down - up) * move_speed;

// fix diagonal speed
if (hsp != 0 && vsp != 0)
{
    hsp = diag_speed * sign(hsp);
    vsp = diag_speed * sign(vsp);
}

// apply movement
x += hsp;
y += vsp;

// update facing direction
if (hsp != 0 || vsp != 0)
{
    if (abs(hsp) > abs(vsp))
    {
        facing = (hsp > 0) ? moveDir.RIGHT : moveDir.LEFT;
    }
    else
    {
        facing = (vsp > 0) ? moveDir.DOWN : moveDir.UP;
    }
}