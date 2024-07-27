/// @description Insert description here
// You can write your code in this editor



//------------chao check

chao = place_meeting(x, y + 1, obj_plat);

//-------controles

var left, right, jump, avanco_h;

left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
jump = keyboard_check(ord("K"));

//---config info de movimentacao

avanco_h = (right - left) * max_velh;
if(chao) acel = acel_chao;
else acel = acel_ar;

//------------State Machine 

switch(estado){
	
	case state.parado:
	
		velh = 0;
		velv = 0;
		
		//pular
		if(jump && chao){
			velv = -max_velv;
		}
		
		//apply gravity 
		if(!chao) velv += grav;
		
		//saindo do estado
		if(abs(velh) > 0 || abs(velv) > 0 || left || right || jump){
			estado = state.movendo;
		}
		
		break;
		
	case state.movendo:
		
		//aplicando mov.
		velh = lerp(velh, avanco_h, acel);
		
		
		//gravidade
		if(!chao) velv += grav;
		
		//pulando
		if(chao && jump) velv = -max_velv;
		
		break;
		
	case state.dash:
	
		break;
}

//------debug estado

show_debug_message(estado);

//---- limitando as velocidades

velv = clamp(velv, -max_velv, max_velv);