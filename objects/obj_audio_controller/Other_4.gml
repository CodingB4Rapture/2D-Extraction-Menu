/// obj_audio_manager : Room Start
// Switch music only when entering a room.

switch (room)
{
    case rm_start_menu:
        music_set(loop_track, 0.85, false);
        break;

    case rm_eirene:
        music_set(loop_track, 0.80, false);
        break;

    case rm_world:
        music_set(loop_track, 0.75, false);
        break;
}