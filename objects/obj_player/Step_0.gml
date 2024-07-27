/// @description Insert description here
// You can write your code in this editor



//------------chao check

chao = place_meeting(x, y + 1, obj_plat);

//----------timer pulo
if(chao){
	timer_pulo = limite_pulo;
}
else {
	if(timer_pulo > 0) timer_pulo--;
}

//-------controles

var left, right, jump, avanco_h;

left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
jump = keyboard_check_pressed(ord("K"));

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
		if(jump && (chao || timer_pulo)){
			velv = -max_velv;
			
			//scale
			xscale = 0.5;
			yscale = 1.5;
		}
		
		break;
		
	case state.dash:
	
		break;
}

//------debug estado

show_debug_message(estado);

//---voltando escala
xscale = lerp(xscale, 1, 0.15);
yscale = lerp(yscale, 1, 0.15);

//---- limitando as velocidades

velv = clamp(velv, -max_velv, max_velv);