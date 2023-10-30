#include "Game.hh"
#include "Cerebro.hh"
#include "ScoresScreen.hh"
/*
	@return void
	Initializes all the variables of the class
*/
void Game::initializeVariables(){
	this->window = nullptr;
}


/*
	@return void
	Creates the window on the center of the desktop window:
		height: 800
		width: 700
		
*/
void Game::initWindow(){
	this->videoMode.height = 960;
	this->videoMode.width = 1000;
	
	this->window = new sf::RenderWindow(this->videoMode, "Tetris", sf::Style::Close);
	this->window->setFramerateLimit(60);
	
	//Gets the screen size
	sf::VideoMode desktopMode = sf::VideoMode::getDesktopMode();

    //Calculate the position to center the window
    int xPos = (desktopMode.width - videoMode.width) / 2;
    int yPos = (desktopMode.height - videoMode.height) / 2;

    //Set the position of the window
    window->setPosition(sf::Vector2i(xPos, yPos));
}


/*
	@return void
	Creates all the buttons of the main menu with their sprites:
		playButton -> playButtonTexture
		scoresButton -> scoresButtonTexture
		exitButton -> exitButtonTexture
	Also it handle the errors if there's not a sprite
*/
void Game::initButtons(){
	if(!this->playButtonTexture.loadFromFile("./Buttons/PlayButton.png")){
		std::cerr << "Falta imagen de boton de play" << std::endl;
		this->window->close();
	}

	this->playButton.setPosition(350.f, 450.f);
	this->playButton.setSize(sf::Vector2f(600.f, 208.f));
    this->playButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->playButton.setTexture(&playButtonTexture);
	
	
	if(!this->scoresButtonTexture.loadFromFile("./Buttons/MenuButton.png")){
		std::cerr << "Falta imagen de boton de scores" << std::endl;
		this->window->close();
	}

	this->scoresButton.setPosition(350.f, 600.f);
	this->scoresButton.setSize(sf::Vector2f(600.f, 208.f));
    this->scoresButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->scoresButton.setTexture(&scoresButtonTexture);
	
	
	if(!this->exitButtonTexture.loadFromFile("./Buttons/ExitButton.png")){
		std::cerr << "Falta imagen de boton de exit" << std::endl;
		this->window->close();
	}

	this->exitButton.setPosition(350.f, 750.f);
	this->exitButton.setSize(sf::Vector2f(600.f, 208.f));
    this->exitButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->exitButton.setTexture(&exitButtonTexture);
	
}

/*
	@return void
	It creates and adds the background sprite
	Also it handle the error if there's not the sprite
*/
void Game::initBackground(){
	if (!this->backgroundTexture.loadFromFile("./Backgrounds/MenuBackground.jpg")) {
        std::cerr << "Falta imagen de boton fondo" << std::endl;
		this->window->close();
    }
	
    this->background.setTexture(backgroundTexture);
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



//Funtions
/*
	@return bool
	Verify if the window is still open
*/
bool Game::windowOpen() const{
	return this->window->isOpen();
}

//Principal Menu Loop
void Game::pollEvents(){
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			
			case sf::Event::Closed:
				this->window->close();
				break;
				
			//Close the game and delete the window
			case sf::Event::KeyPressed:
				if(this->event.key.code == sf::Keyboard::Escape){
					this->window->close();
				}
				break;	
				
			/*
				Cases for the menu
				when it's pressed it gets the position x and y of left mouse button and compared with bounds of each button to verify if the user want to to another screen.
			*/
			case sf::Event::MouseButtonPressed:
                if(this->event.mouseButton.button == sf::Mouse::Left) {
                    sf::Vector2f mousePos = sf::Vector2f(sf::Mouse::getPosition(*this->window).x, sf::Mouse::getPosition(*this->window).y);

                    if (this->playButton.getGlobalBounds().contains(mousePos)) {
                        //window->clear(sf::Color::Black);
						Cerebro* partida = new Cerebro(this->window);
						
						while(partida->finishedGame()){
							//Update
							partida->update();
							
							//Render
							partida->render();
							
						}
						
						delete partida;
						
                        
                    } else if(scoresButton.getGlobalBounds().contains(mousePos)) {
                        ScoresScreen scoresScreen = ScoresScreen(this->window);
						while(scoresScreen.finishedGame()){
							//Update
							scoresScreen.update();
							
							//Render
							scoresScreen.render();
						}
                        
                    } else if (exitButton.getGlobalBounds().contains(mousePos)) {
                        window->close();
                    }
                }
				break;
				
			default:
				break;
		}
	}	
}

//Funtions

/*
	@return void
	This call the funtion that handle all the cases posible in the game.
*/
void Game::update(){
	this->pollEvents();
	//RElative to the screen
	//std::cout << "Mouse pos: " << sf::Mouse::getPosition().x << " " << sf::Mouse::getPosition().y << std::endl;
	
	//RElative to the window
	//std::cout << "Mouse pos: " << sf::Mouse::getPosition(*this->window).x << " " << sf::Mouse::getPosition(*this->window).y << std::endl;
	
	
}


/*
	@return void
	Prepares all the things that will be shown in the window
*/
void Game::render(){
	this->window->clear();
	
	this->window->draw(this->background);
	
	//Draw game
	this->window->draw(this->playButton);
	this->window->draw(this->scoresButton);
	this->window->draw(this->exitButton);
	
	this->window->display();
}




