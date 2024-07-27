/// @description Insert description here
// You can write your code in this editor



//------------chao check

chao = place_meeting(x, y + 1, obj_plat);

//-------controles

var _left, _right, _jump;

_left = keyboard_check(ord("A"));
_right = keyboard_check(ord("D"));
_jump = keyboard_check(ord("K"));


//------- velocidade horizontal
velh = (_right - _left) * max_velh;


//------- aplic velocidade vertical/gravidade

if (!chao){
	velv += grav;
}

//---- limitando as velocidades

velv = clamp(velv, -max_velv, max_velv);