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
		
		void drawMatriz();
		
		//Funtions
		void startGame();
		void update();
		void render();
	
};

#endif