#ifndef SCORESSCREEN_HH
#define SCORESSCREEN_HH

#include <iostream>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <SFML/Audio.hpp>
#include <SFML/Network.hpp>

class ScoresScreen{
	private:
		//Window
		sf::RenderWindow* window;
		sf::Event event;
		
		bool playing;
		
		void initializeVariables();
		void initWindow(sf::RenderWindow*&); 
		
	public:
		//Constructor and Destructor
		ScoresScreen(sf::RenderWindow*&);
		virtual ~ScoresScreen();
		 
		bool finishedGame() const; 
		
		 
		//Funtions
		void pollEvents();
		void update();
		void render();
	
};

#endif