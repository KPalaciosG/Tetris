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
		//Says if the window is open
		bool showingScores;
		
	
		//Window
		sf::RenderWindow* window;
		sf::Event event;
		
		//Background
		sf::Sprite background;
		sf::Texture backgroundTexture;
		
		//Buttons and textures
		sf::RectangleShape exitButton;
		sf::Texture exitButtonTexture;
		
		//Text things
		sf::Font retroFont; 	
		sf::Text scores;
		
		
		std::string topScores;
		
		//Iniatialize all
		void initializeVariables();
		void initWindow(sf::RenderWindow*&); 
		void initTopScore();
		void initButtons();
		void initBackground();
		
	public:
		//Constructor and Destructor
		ScoresScreen(sf::RenderWindow*&);
		virtual ~ScoresScreen();
		 
		//Gets
		bool showing() const; 
		
		 
		//Funtions
		void pollEvents();
		
		void update();
		void render();
	
		//Draw Funtions
		void drawTopScores();
};

#endif