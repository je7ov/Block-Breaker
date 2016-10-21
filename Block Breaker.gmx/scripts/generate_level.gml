///generate_level()
num_blocks = 0;
blocks_max = global.chunk_fill * (global.chunk_width * global.chunk_height);

// Generate center
if(global.chunk_width % 2) {
    center = ceil(global.chunk_width / 2) - 1;
    for(j = 0; j < global.chunk_height; j++) {
        // Randomize block placement
        if(num_blocks < blocks_max) {
            rand = random(1);
        } else {
            rand = 1;
        }
        if(rand < global.chunk_fill_chance){
            chunk[center, j] = 1;
            num_blocks++;
        } else {
            chunk[center, j] = 0;
        }
    }
}

// Generate left
for(i = 0; i < floor(global.chunk_width / 2); i++) {
    for(j = 0; j < global.chunk_height; j++) {
        if(num_blocks < blocks_max) {
            rand = random(1);
        } else {
            rand = 1;
        }
        if(rand < global.chunk_fill_chance){
            chunk[i, j] = 1;
            num_blocks += 2;
        } else {
            chunk[i, j] = 0;
        }
    }
}

// Continue filling left and center of chunk if not up to fill percentage
while(num_blocks < blocks_max) {
    // Go through center again
    if(global.chunk_width % 2) {
        for(j = 0; j < global.chunk_height; j++) {
            if(chunk[center, j] == 0){
                if(num_blocks < blocks_max) {
                    rand = random(1);
                } else {
                    rand = 1;
                }
                if(rand < global.chunk_fill_chance){
                    chunk[center, j] = 1;
                    num_blocks++;
                } else {
                    chunk[center, j] = 0;
                }
            }
        }
    }
    // Check if done before going through left
    if(num_blocks >= blocks_max) break;
    // Go through left again
    for(i = 0; i < floor(global.chunk_width / 2); i++) {
        for(j = 0; j < global.chunk_height; j++) {
            if(chunk[i, j] == 0){
                if(num_blocks < blocks_max) {
                    rand = random(1);
                } else {
                    rand = 1;
                }
                if(rand < global.chunk_fill_chance){
                    chunk[i, j] = 1;
                    num_blocks += 2;
                } else {
                    chunk[i, j] = 0;
                }
            }
        }
    }    
}

// Fill in yellows
num_yellows = 0
yellow_max = num_blocks * global.level[YELLOW_PERCENT, global.level_num];
while(num_yellows < yellow_max) {
    for(i = 0; i < ceil(global.chunk_width / 2); i++) {
        for(j = 0; j < global.chunk_height; j++) {
            if(chunk[i, j] == 1 && random(1) < 0.05) {
                chunk[i, j] = 2;
                if(global.chunk_width % 2 && i == (ceil(global.chunk_width / 2) - 1)) {
                    num_yellows++;
                } else {
                    num_yellows += 2;
                }
            }
            if(num_yellows >= yellow_max) break;
        }
        if(num_yellows >= yellow_max) break;
    }
}

// Fill in greens
num_greens = 0
green_max = num_blocks * global.level[GREEN_PERCENT, global.level_num];
while(num_greens < green_max) {
    for(i = 0; i < ceil(global.chunk_width / 2); i++) {
        for(j = 0; j < global.chunk_height; j++) {
            if(chunk[i, j] == 1 && random(1) < 0.05) {
                chunk[i, j] = 3;
                if(global.chunk_width % 2 && i == (ceil(global.chunk_width / 2) - 1)) {
                    num_greens++;
                } else {
                    num_greens += 2;
                }
            }
            if(num_greens >= green_max) break;
        }
        if(num_greens >= green_max) break;
    }
}

// Fill in blacks
num_blacks = 0
black_max = num_blocks * global.level[BLACK_PERCENT, global.level_num];
while(num_blacks < black_max) {
    for(i = 0; i < ceil(global.chunk_width / 2); i++) {
        for(j = 0; j < global.chunk_height; j++) {
            if(chunk[i, j] == 1 && random(1) < 0.05) {
                chunk[i, j] = 4;
                if(global.chunk_width % 2 && i == (ceil(global.chunk_width / 2) - 1)) {
                    num_blacks++;
                } else {
                    num_blacks += 2;
                }
            }
            if(num_blacks >= black_max) break;
        }
        if(num_blacks >= black_max) break;
    }
}

// Mirror to right
for(i = global.chunk_width-1; i > ceil(global.chunk_width / 2) - 1; i--) {
    for(j = 0; j < global.chunk_height; j++) {
        chunk[i, j] = chunk[global.chunk_width -1 - i, j];
    }
}

// Draw sprites
start_x = global.center_x - (global.chunk_width / 2 * BRICK_X);
start_y = global.center_y;
for(i = 0; i < global.chunk_width; i++) {
    for(j = 0; j < global.chunk_height; j++) {
        if(chunk[i, j] == 1){
            instance_create(start_x + (i * BRICK_X), start_y + (j * BRICK_Y), RedBlock);
        } else if(chunk[i, j] == 2) {
            instance_create(start_x + (i * BRICK_X), start_y + (j * BRICK_Y), YellowBlock);
        } else if(chunk[i, j] == 3) {
            instance_create(start_x + (i * BRICK_X), start_y + (j * BRICK_Y), GreenBlock);
        } else if(chunk[i, j] == 4) {
            instance_create(start_x + (i * BRICK_X), start_y + (j * BRICK_Y), BlackBlock);
        }
    }
}
