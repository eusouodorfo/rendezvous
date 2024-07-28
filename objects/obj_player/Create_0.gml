/// @description Insert description here
// You can write your code in this editor

grav = 0.3;
acel = 0.1;
acel_chao = 0.1;
acel_ar = 0.07;
acel = acel_chao;

//---- velocidades

velh = 0;
velv = 0;

//---- limite das velocidades

max_velh = 6;
max_velv = 8;
len = 10;

//-----coyote time
limite_pulo = 6;
timer_pulo = limite_pulo;

limite_buffer = 6;
timer_queda = 0;
buffer_pulo = false; 


//----- variaveis de controle

chao = false;
yscale = 1;
xscale = 1;
dura = room_speed/4;
dir = 0;
carga = 1;

//--------controlando cor
sat = 255;

//-------state machine
enum state 
{
	parado, movendo, dash	
}

estado = state.parado; 
//----- 
