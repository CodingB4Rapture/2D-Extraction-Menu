/// obj_audio_manager : Create
// Prevent duplicates (in case you accidentally place it in more than one room).
if (instance_number(object_index) > 1) { instance_destroy(); exit; }

global.music_handle = -1;
global.music_sound  = noone;