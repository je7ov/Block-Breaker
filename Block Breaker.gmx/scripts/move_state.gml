///move_state()
if(!place_meeting(x + hspd, y, Solid)) {
    x += hspd;
} else {
    while(!place_meeting(x + sign(hspd), y, Solid)) {
        x += sign(hspd);
    }
    col_object = instance_place(x + sign(hspd), y, Solid);
    if(object_get_parent(col_object.object_index) == Block) {
        audio_play_sound(snd_block_break, 5, false);
        with(col_object) {
            instance_destroy();
        }
    } else if(object_get_parent(col_object.object_index) == TopBlock) {
        if(col_object.y > y) {
            audio_play_sound(snd_block_break, 5, false);
            with(col_object) {
                instance_destroy();
            }
        } else {
            audio_play_sound(snd_bounce, 5, false);
        }
    } else if(col_object.object_index == Paddle) {
        if(col_object.y < y) y *= -1;
    } else {
        audio_play_sound(snd_bounce, 5, false);
    }
    hspd *= -1;
}

if(!place_meeting(x, y + vspd, Solid)) {
    y += vspd;
} else {
    while(!place_meeting(x, y + sign(vspd), Solid)) {
        y += sign(vspd);
    }
    col_object = instance_place(x, y + sign(vspd), Solid)
    if(object_get_parent(col_object.object_index) == Block) {
        audio_play_sound(snd_block_break, 5, false);
        with(col_object) {
            instance_destroy();
        }
    } else if(object_get_parent(col_object.object_index) == TopBlock) {
        if(col_object.y > y) {
            audio_play_sound(snd_block_break, 5, false);
            with(col_object) {
                instance_destroy();
            }
        } else {
            audio_play_sound(snd_bounce, 5, false);
        }
    } else if(col_object.object_index == Paddle) {
        hspd = (x - col_object.x) / 32 * hmax;
    } else {
        audio_play_sound(snd_bounce, 5, false);
    }
    vspd *= -1;
    vspd += sign(vspd) * 0.02 * global.difficulty;
}

if(x < -16 || x > room_width + 16 || y < -16 || y > room_height + 16) {
    instance_create(0, Paddle.y - 24, Ball);
    global.life -= 1;
    instance_destroy();
}
