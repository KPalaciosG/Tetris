#include "Cerebro.hh"

void Cerebro::initializeVariables(){
	this->window = nullptr;
	this->playing = true;
	//this->actualTetrinomio = getBlock()
	//this->nextTetrinomio = getBlock()
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

void Cerebro::startGame(){
	
	while(this->window->pollEvent(this->event)){
		
		switch(this->event.type){
			case sf::Event::Closed:
				this->window->close();
				break;
				
			case sf::Event::KeyPressed:
				if(this->event.key.code == sf::Keyboard::Left){
					this->playing = false;
				}
				
				else if(this->event.key.code == sf::Keyboard::Right){
					this->playing = false;
				}
				
				else if(this->event.key.code == sf::Keyboard::Up){
					this->playing = false;
				}
				
				else if(this->event.key.code == sf::Keyboard::Down){
					this->playing = false;
				}
				
				else if(this->event.key.code == sf::Keyboard::Escape){
					this->playing = false;
				}
				break;
				
			case sf::Event::MouseButtonPressed:
				if(this->event.mouseButton.button == sf::Mouse::Left) {
				   
				}
				break;
		}
		/*
		if(checkState(actualTetrinomio) == false){
			clearRows();
			dropAllBlocks();
			actualTetrinomio = nextTetrinomio;
			nextTetrinomio = getBlock();
		}
		else{
			moveBlock(down, actualTetrinomio);
		}*/
		
		//playing = checkMatriz();
	}	
}

//Funtions
void Cerebro::update(){
	this->startGame();
}

void Cerebro::render(){
	this->window->clear();
	//poner background
	//dibujar matriz
	this->window->display();
}




