#include "Cerebro.hh"

void Cerebro::initializeVariables(){
	this->window = nullptr;
	this->playing = true;
}
void Cerebro::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}

//Constructor and Destructor
Cerebro::Cerebro(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
}

Cerebro::~Cerebro(){
	
}



//Funtions
bool Cerebro::finishedGame() const{
	return this->playing;
}

void Cerebro::pollEvents(){
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
				
		}
	}	
}

//Funtions
void Cerebro::update(){
	this->pollEvents();
}

void Cerebro::render(){
	this->window->clear();
	
	this->window->display();
}




