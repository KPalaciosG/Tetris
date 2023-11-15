#ifndef GAME_HH
#define GAME_HH

#include <iostream>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <SFML/Audio.hpp>
#include <SFML/Network.hpp>

#include "Cerebro.hh"
#include "ScoresScreen.hh"

class Game{
	private:
		//Window
		sf::RenderWindow* window;
		sf::VideoMode videoMode;
		sf::Event event;
		
		//Background
		sf::Sprite background;
		sf::Texture backgroundTexture;
		
		//Buttons and textures
		sf::RectangleShape playButton;
		sf::Texture playButtonTexture;
		sf::RectangleShape scoresButton;
		sf::Texture scoresButtonTexture;
		sf::RectangleShape exitButton;
		sf::Texture exitButtonTexture;
		
		//Iniatialize all
		void initializeVariables();
		void initWindow(); 
		void initButtons();
		void initBackground();
		sf::Music PlayingMusic;
	public:
		sf::Music MenuMusic;
		//Constructor and Destructor
		Game();
		virtual ~Game();
		
		//Gets
		bool windowOpen() const; 
		
		//Funtions
		void pollEvents();
		void update();
		void render();
		void initMenuMusic();
		void stopMenuMusic();
	
};

#endif