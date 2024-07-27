/// @description Insert description here
// You can write your code in this editor

//----checando contato como chao

var temp = place_meeting(x, y + 1, obj_plat);

if(temp && !chao){
	xscale = 1.6;
	yscale = 0.5;
}



//-----restart game 
if(keyboard_check_pressed(vk_enter)) room_restart();