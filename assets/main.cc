#include <iostream>
#include <fstream>
#include "Game.hh"
extern "C" void create();
int main(){
	// Verifica si el archivo de scores ya ha sido creado antes
	std::ifstream scores("scores.txt");
	// si no existe lo crea
	if(!scores.is_open()) {
		create();
	} else {
		// si ya existe solo lo cierra
		scores.close();
	}

	Game tetris;
	
	while(tetris.windowOpen()){
		//Update
		tetris.update();
		
		//Render
		tetris.render();
	}
	
	
	return 0;
}
