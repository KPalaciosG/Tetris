#include <iostream>
#include "Game.hh"
extern "C" void create();
int main(){
	//
	//to do... si no esta creado crearlo, sino abrir
	//create();
	Game tetris;
	
	while(tetris.windowOpen()){
		//Update
		tetris.update();
		
		//Render
		tetris.render();
	}
	
	
	return 0;
}
