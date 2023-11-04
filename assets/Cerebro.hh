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

class Cerebro{
	private:
		//Bool that says if there's a game being play
		bool playing;
	
		//Window
		sf::RenderWindow* window;
		sf::Event event;
		
		//Background
		sf::Sprite background;
		sf::Texture backgroundTexture;
		
		//Buttons and textures
		sf::RectangleShape pauseButton;
		sf::Texture pauseButtonTexture;
		
		//Block Texture
		sf::Texture emptyBlockTexture;
		sf::Texture redBlockTexture;
		sf::Texture greenBlockTexture;
		sf::Texture blueBlockTexture;
		sf::Texture yellowBlockTexture;
		sf::Texture purpleBlockTexture;
		sf::Texture cyanBlockTexture;
		sf::Texture orangeBlockTexture;
		
		
		//GameArea
		char shadowMatrix[20][10]; //It's not the real matrix, it is only used to show it in the game easier
		const int rows = 20;
		const int columns = 10;
		const int blockSize = 40;
		
		//Tetrinomio things
		char currentTetrinomio;
		int amountOfMoves = 0; //Repretents the amount of rotation that has been done
	
		//Score things
		int currentScore;
		sf::Font retroFont; 	
		sf::Text score;
		
		
		//Iniatialize all
		void initializeVariables();
		void initWindow(sf::RenderWindow*&);
		void initGameArea();
		void initScore();
		void initButtons();
		void initBackground();
		void initBlockTexture();
		
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
		
		void defaultMoves();
};

#endif