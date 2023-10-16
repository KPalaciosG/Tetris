#include "Game.hh"

void Game::initializeVariables(){
	this->window = nullptr;
}
void Game::initWindow(){
	this->videoMode.height = 800;
	this->videoMode.width = 700;
	
	this->window = new sf::RenderWindow(this->videoMode, "Tetris", sf::Style::Close);
	this->window->setFramerateLimit(60);
}

void Game::initButtons(){
	//playButton -> playButtonTexture
	//scoresButton -> scoresButtonTexture
	//exitButton -> exitButtonTexture
	if(!this->playButtonTexture.loadFromFile("play.jpg")){
		std::cerr << "Falta imagen de boton de play" << std::endl;
		this->window->close();
	}

	this->playButton.setPosition(280.f, 150.f);
	this->playButton.setSize(sf::Vector2f(350.f, 250.f));
    this->playButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->playButton.setTexture(&playButtonTexture);
	
	
	if(!this->scoresButtonTexture.loadFromFile("scores.jpg")){
		std::cerr << "Falta imagen de boton de scores" << std::endl;
		this->window->close();
	}

	this->scoresButton.setPosition(280.f, 350.f);
	this->scoresButton.setSize(sf::Vector2f(350.f, 250.f));
    this->scoresButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->scoresButton.setTexture(&scoresButtonTexture);
	
	
	if(!this->exitButtonTexture.loadFromFile("exit.jpg")){
		std::cerr << "Falta imagen de boton de exit" << std::endl;
		this->window->close();
	}

	this->exitButton.setPosition(280.f, 550.f);
	this->exitButton.setSize(sf::Vector2f(350.f, 250.f));
    this->exitButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->exitButton.setTexture(&exitButtonTexture);
	
}

void Game::initBackground(){
	if (!backgroundTexture.loadFromFile("Fondo.jpg")) {
        std::cerr << "Falta imagen de boton fondo" << std::endl;
		this->window->close();
    }
	
    background.setTexture(backgroundTexture);
}

//Constructor and Destructor
Game::Game(){
	this->initializeVariables();
	this->initWindow();
	this->initButtons();
	this->initBackground();
}

Game::~Game(){
	delete this->window;
}


bool Game::playing() const{
	return this->window->isOpen();
}

void Game::pollEvents(){
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			case sf::Event::Closed:
				this->window->close();
				break;
			case sf::Event::KeyPressed:
				if(this->event.key.code == sf::Keyboard::Escape){
					this->window->close();
				}
				break;	
		}
	}	
}

//Funtions
void Game::update(){
	this->pollEvents();
	//RElative to the screen
	//std::cout << "Mouse pos: " << sf::Mouse::getPosition().x << " " << sf::Mouse::getPosition().y << std::endl;
	
	//RElative to the window
	//std::cout << "Mouse pos: " << sf::Mouse::getPosition(*this->window).x << " " << sf::Mouse::getPosition(*this->window).y << std::endl;
	
	
}

void Game::render(){
	this->window->clear();
	
	this->window->draw(this->background);
	
	//Draw game
	this->window->draw(this->playButton);
	this->window->draw(this->scoresButton);
	this->window->draw(this->exitButton);
	
	this->window->display();
}




