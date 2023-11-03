#include <iostream>
#include "Game.hh"

int main(){
	//
	Game tetris;
	
	while(tetris.windowOpen()){
		//Update
		tetris.update();
		
		//Render
		tetris.render();
	}
	
	
	return 0;
}

/*mainMenu() {
|	//crear ventana y definir dimensiones
|	//crear y preparar boton de jugar
|	//crear y preparar boton de scores
|	window.display();
|	while( window.isOpen() ) {
|	|
    	|	|	if ( click en jugar ) {
		|	|		window.clear(black);
|	|		Cerebro.startGame(window);
|	|	}
|	|
|	|	if( click en scores ) {
|	|		window.clear(black);
|	|		showScores(window);
|	|	}
|	|	if( event::closed() ) {
|	|		window.close();
|	|    	}
|	}
}*/