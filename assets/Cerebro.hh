#ifndef CEREBRO_HH
#define CEREBRO_HH

#include <iostream>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <SFML/Audio.hpp>
#include <SFML/Network.hpp>
#include <SFML/System/Clock.hpp>
#include <SFML/System/Time.hpp>

#include "PauseScreen.hh"
#include "GameOverScreen.hh"


class Cerebro{
	private:
		//Bool que dice si hay una partida en este momento siendo jugada
		bool playing;
		
		//Tetrinomio
		char currentTetrinomio;
		char nextTetrinomio;
		int amountOfRotations; //Cuenta la cantidad de veces que se ha rotado el tetrinomio
		
		//GameArea
		char shadowMatrix[20][10]; //No es la matriz real, se utiliza solo para la  graficacion
		char shadowSubMatrix[4][4]; //Matriz para graficar el siguiente tetrinomio
		
		//Graphics
		const int rows = 20;
		const int columns = 10;
		const int blockSize = 40;
		
	
		//Window
		sf::RenderWindow* window;
		sf::Event event;
		
		//Background
		sf::Sprite background;
		sf::Texture backgroundTexture;
		
		//Buttons and textures
		sf::RectangleShape pauseButton;
		sf::Texture pauseButtonTexture;
		
		//Blocks Textures
		sf::Texture emptyBlockTexture;
		sf::Texture redBlockTexture;
		sf::Texture greenBlockTexture;
		sf::Texture blueBlockTexture;
		sf::Texture yellowBlockTexture;
		sf::Texture purpleBlockTexture;
		sf::Texture cyanBlockTexture;
		sf::Texture orangeBlockTexture;
	
		//Score
		int currentScore;
		sf::Font retroFont; 	
		sf::Text score;
		
		//Para Graficar
		void getGameArea();
		void copyNextTetrinomio();
		
		
		//Inicializaciones
		void initializeVariables();
		void initWindow(sf::RenderWindow*&);
		void initGameArea();
		void initScore();
		void initButtons();
		void initBackground();
		void initBlockTexture();
		

	public:
		//Constructor and Destructor
		Cerebro(sf::RenderWindow*&);
		virtual ~Cerebro();
		
		//Funtions
		void pause();
		void gameOver();		
		void defaultMoves();
		
		//Gets
		bool finishedGame() const; 
		
		//Principal interface funtions
		void update();
		void render();
		
		//Draw funtions
		void drawMatrix();
		void drawSubMatrix();
		void drawScore();
		
};

#endif