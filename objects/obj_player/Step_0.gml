/// @description Insert description here
// You can write your code in this editor



//------------chao check

chao = place_meeting(x, y + 1, obj_plat);

//----------timer pulo
if(chao){
	timer_pulo = limite_pulo;
	carga = 1;
}
else {
	if(timer_pulo > 0) timer_pulo--;
}

//-------controles

var left, right, jump, jump_s, up, down, avanco_h, dash;

left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
jump = keyboard_check_pressed(ord("K"));
jump_s = keyboard_check_released(ord("K"));
dash = keyboard_check_pressed(ord("L"));

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
		
		//dash
		if(dash && carga > 0){
			
			//decidindo a direção
			dir = point_direction(0, 0, (right - left), (down - up));
			
			estado = state.dash;
			carga--;
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
		
		//buffer do pulo
		if(jump) timer_queda = limite_buffer;
		
		if(timer_queda > 0) buffer_pulo = true;
		else buffer_pulo = false;
		
		if(buffer_pulo){
			if(chao || timer_pulo){
				velv = -max_velv;
				
				//alternando escala
				xscale = 0.5;
				yscale = 1.5;
				
				timer_pulo = 0;
				timer_queda = 0;
			}
			
			timer_queda--;
		}
		
		//controlar altura do pulo
		if(jump_s && velv < 0) velv *= 0.7;
		
		//dash
		if(dash && carga > 0){
			
			//decidindo a direção
			dir = point_direction(0, 0, (right - left), (down - up));
			
			estado = state.dash;
			carga--;
		}
		
		//---- limitando as velocidades
		velv = clamp(velv, -max_velv, max_velv);
		
		break;
		
	case state.dash:
	
		dura--;
		carga = 0;
		
		velh = lengthdir_x(len, dir);
		velv = lengthdir_y(len, dir);
		
		//deformando o player
		if(dir == 90 || dir == 270){
			yscale = 1.5;
			xscale = 0.5;
		}
		else {
			yscale = 0.5;
			xscale = 1.6;
		}
		
		
		//criando o rastro
		var rastro = instance_create_layer(x, y, layer, obj_player_vest);
		rastro.xscale = xscale;
		rastro.yscale = yscale;
		
		//saindo do estado
		if(dura <= 0){
			estado = state.movendo;
			dura = room_speed/4;
			
			
			//diminuindo velocidade
			velh = (max_velh * sign(velh) * 0.5);
			velv = (max_velv * sign(velv) * 0.5);
		}
	
		break;
}

//------debug estado

//show_debug_message(estado);
show_debug_message(carga);

switch(carga){
	
	case 0:
		sat = lerp(sat, 50, 0.05);
		break;

	case 1:
		sat = lerp(sat, 255, 0.05);
		break;
}

//definindo cor
image_blend = make_color_hsv(20, sat, 255);

//---voltando escala
xscale = lerp(xscale, 1, 0.15);
yscale = lerp(yscale, 1, 0.15);



