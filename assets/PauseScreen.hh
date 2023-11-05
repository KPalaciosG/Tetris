#ifndef PAUSESCREEN_HH
#define PAUSESCREEN_HH

#include <iostream>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <SFML/Audio.hpp>
#include <SFML/Network.hpp>

class PauseScreen{
	private:
		bool inPause;
		
		//Window
		sf::RenderWindow* window;
		sf::VideoMode videoMode;
		sf::Event event;
		
		//Background
		sf::Sprite background;
		sf::Texture backgroundTexture;
		
		//Buttons and textures
		sf::RectangleShape resumeButton;
		sf::Texture resumeButtonTexture;
		sf::RectangleShape exitButton;
		sf::Texture exitButtonTexture;
		
		//Iniatialize all
		void initializeVariables();
		void initWindow(sf::RenderWindow*&); 
		void initButtons();
		void initBackground();
		
	public:
		//Constructor and Destructor
		PauseScreen(sf::RenderWindow*&);
		virtual ~PauseScreen();
		
		//Gets
		bool stopped() const; 
		
		//Funtions
		void pollEvents();
		void update(bool&);
		void render();
	
};

#endif