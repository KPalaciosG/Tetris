#ifndef CEREBRO_HH
#define CEREBRO_HH

#include <iostream>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <SFML/Audio.hpp>
#include <SFML/Network.hpp>

class Cerebro{
	private:
		//Window
		sf::RenderWindow* window;
		sf::Event event;
		
		//GameArea
		char shadowMatrix[20][10]; //It's not real matrix, it is only used to show it in the game easier
		const int rows = 20;
		const int columns = 10;
		const int blockSize = 40;
		
		char currentTetrinomio = 'L';
		int amountOfMoves = 0;
		//Score things
		int currentScore;
		
		sf::Font retroFont; 
		
		sf::Text score;
		
		
		//Playing 
		bool playing;
		
		//Iniatialize all
		void initializeVariables();
		void initWindow(sf::RenderWindow*&);
		
		void initGameArea();
		void initScore();
		
		//To see the game area
		void getGameArea();

		
	public:
		//Constructor and Destructor
		Cerebro(sf::RenderWindow*&);
		virtual ~Cerebro();
		
		//Funtions
		//Gets
		bool finishedGame() const; 
		
		//Run game
		//Main loop for the game
		void startGame();
		
		
		//Principal interface funtions
		void update();
		void render();
		
		//Draw funtions
		void drawMatrix();
		void drawScore();
		
		void prueba();
};

#endif