#ifndef GAMEOVERSCREEN_HH
#define GAMEOVERSCREEN_HH

#include <iostream>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <SFML/Audio.hpp>
#include <SFML/Network.hpp>

class GameOverScreen{
	private:
		bool inPause;
		bool inputActive;
		
		std::string player;
		
		//Window
		sf::RenderWindow* window;
		sf::Event event;
		
		//Background
		sf::Sprite background;
		sf::Texture backgroundTexture;
		
		//text things
		sf::Font retroFont; 	
		sf::Text text;
		
		//Buttons and textures
		//sf::RectangleShape resumeButton;
		//sf::Texture resumeButtonTexture;
		//sf::RectangleShape exitButton;
		//sf::Texture exitButtonTexture;
		
		//Iniatialize all
		void initializeVariables();
		void initWindow(sf::RenderWindow*&); 
		void initButtons();
		void initBackground();
		void initText();
		
	public:
		//Constructor and Destructor
		GameOverScreen(sf::RenderWindow*&);
		virtual ~GameOverScreen();
		
		//Gets
		bool stopped() const; 
		
		//Funtions
		void pollEvents();
		void update();
		void render(int);
		
		void drawText(int);
	
};

#endif