///get_input()
global.key_fire = mouse_check_button_pressed(mb_left);
global.key_fire_released = mouse_check_button_released(mb_left);
global.key_pause = keyboard_check_pressed(vk_escape);
global.key_enter = keyboard_check_pressed(vk_enter);
global.key_up = keyboard_check_pressed(vk_up);
global.key_right = keyboard_check_pressed(vk_right);
global.key_down = keyboard_check_pressed(vk_down);
global.key_left = keyboard_check_pressed(vk_left);

// DEBUG KEYS
global.key_reset = keyboard_check_pressed(ord('R'));
global.key_clear = keyboard_check_pressed(ord('C'));
