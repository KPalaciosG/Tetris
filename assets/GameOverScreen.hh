#ifndef GAMEOVERSCREEN_HH
#define GAMEOVERSCREEN_HH

#include <iostream>
#include <fstream>
#include <vector>
#include <regex>
#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>
#include <SFML/Audio.hpp>
#include <SFML/Network.hpp>
extern "C" void writeToScores(char* , int);
class GameOverScreen{
	private:
		bool inPause; //Indica si se esta mostrando la pantalla
		bool inputActive; //Puede escribir su nombre
		bool refresh;

		std::string player; //Almacena el nombre del jugador
		
		//Window
		sf::RenderWindow* window;
		sf::Event event;
		
		//Background
		sf::Sprite background;
		sf::Texture backgroundTexture;
		
		//text things
		sf::Font retroFont; 	
		sf::Text text;
		
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
		std::string getPlayer();
		bool getRefresh();
		void setRefresh(bool);

		
		//Funtions
		void update();
		void render(int);
		
		void drawText(int);

		/**
		* @brief Recibe un puntaje junto al nombre de usuario y verifica si el puntaje
		* es suficientemente alto para remplazar a alguno en caso de que hayan otros
		* puntajes en el archivo de puntajes.
		*
		* @param score_p puntaje y nombre de usuario de la partida acabada.
		*/
		void checkScores(std::string score_p);
};

#endif