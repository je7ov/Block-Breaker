///start_state()

if(!place_meeting(mouse_x + 21, y, Wall) && !place_meeting(mouse_x - 21, y, Wall)) {
    x = mouse_x;
}

if(global.key_fire) {
    vspd = vspd * -0.8;
    hspd = hspd * random_range(-.6, .6);
    state = move_state;
}

