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
		//prueba
		std::vector<std::vector<int>> matrix = {
			{1, 2, 3, 0, 1, 2, 3, 0, 1, 2},
			{0, 1, 2, 3, 0, 1, 2, 3, 0, 1},
			{3, 0, 1, 2, 3, 0, 1, 2, 3, 0},
			{2, 3, 0, 1, 2, 3, 0, 1, 2, 3},
			{1, 2, 3, 0, 1, 2, 3, 0, 1, 2},
			{0, 1, 2, 3, 0, 1, 2, 3, 0, 1},
			{3, 0, 1, 2, 3, 0, 1, 2, 3, 0},
			{2, 3, 0, 1, 2, 3, 0, 1, 2, 3},
			{1, 2, 3, 0, 1, 2, 3, 0, 1, 2},
			{0, 1, 2, 3, 0, 1, 2, 3, 0, 1},
			{3, 0, 1, 2, 3, 0, 1, 2, 3, 0},
			{2, 3, 0, 1, 2, 3, 0, 1, 2, 3},
			{1, 2, 3, 0, 1, 2, 3, 0, 1, 2},
			{0, 1, 2, 3, 0, 1, 2, 3, 0, 1},
			{3, 0, 1, 2, 3, 0, 1, 2, 3, 0},
			{2, 3, 0, 1, 2, 3, 0, 1, 2, 3},
			{1, 2, 3, 0, 1, 2, 3, 0, 1, 2},
			{0, 1, 2, 3, 0, 1, 2, 3, 0, 1},
			{3, 0, 1, 2, 3, 0, 1, 2, 3, 0},
			{2, 3, 0, 1, 2, 3, 0, 1, 2, 3}
		};
		const int rows = 20;
		const int cols = 10;
		const int blockSize = 30;
		//
		bool playing;
		//
		char* actualTetrinomio;
		char* nextTetrinomio;
		
		
		void initializeVariables();
		void initWindow(sf::RenderWindow*&); 
		
	public:
		//Constructor and Destructor
		Cerebro(sf::RenderWindow*&);
		virtual ~Cerebro();
		
		bool finishedGame() const; 
		
		void drawMatrix();
		
		//Funtions
		void startGame();
		void update();
		void render();
	
};

#endif