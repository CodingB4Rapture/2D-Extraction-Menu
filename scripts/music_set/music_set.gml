function music_set(_snd, _gain, _restart_if_same)
{
    // Safety: if someone passes an invalid sound index, do nothing.
    if (_snd == noone) return;

    // If the requested track is already the current one and still playing, keep it (unless restart requested).
    if (global.music_sound == _snd && audio_is_playing(global.music_handle))
    {
        if (!_restart_if_same) return;
    }

    // Stop previous music if any.
    if (audio_is_playing(global.music_handle))
    {
        audio_stop_sound(global.music_handle);
    }

    // Start new music looped.
    global.music_sound  = _snd;
    global.music_handle = audio_play_sound(_snd, 0, true);
    audio_sound_gain(global.music_handle, _gain, 0);
}

