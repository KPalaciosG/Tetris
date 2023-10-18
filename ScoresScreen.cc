#include "ScoresScreen.hh"

void ScoresScreen::initializeVariables(){
	this->window = nullptr;
	this->playing = true;
}
void ScoresScreen::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}

//Constructor and Destructor
ScoresScreen::ScoresScreen(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
}

ScoresScreen::~ScoresScreen(){
	//delete this->window;
}



//Funtions
bool ScoresScreen::finishedGame() const{
	return this->playing;
}

void ScoresScreen::pollEvents(){
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			case sf::Event::Closed:
				this->window->close();
				break;
			case sf::Event::KeyPressed:
				if(this->event.key.code == sf::Keyboard::Escape){
					this->playing = false;
				}
				break;
			default:
				break;
		}
	}	
}

//Funtions
void ScoresScreen::update(){
	this->pollEvents();
	
}

void ScoresScreen::render(){
	this->window->clear();
	
	this->window->display();
}




