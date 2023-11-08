#include "PauseScreen.hh"

/*
	@return void
	Initializes all the variables of the class
*/
void PauseScreen::initializeVariables(){
	this->window = nullptr;
	this->inPause = true;
}


/*
	@return void
	Creates the window on the center of the desktop window:
		height: 960
		width: 1000
		
*/
void PauseScreen::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}


/*
	@return void
	Creates all the buttons of the main menu with their sprites:
		resumeButton -> resumeButtonTexture
		exitButton -> exitButtonTexture
	Also it handle the errors if there's not a sprite
*/
void PauseScreen::initButtons(){
	if(!this->resumeButtonTexture.loadFromFile("assets/Buttons/playButton.png")){
		std::cerr << "Falta imagen de boton de play" << std::endl;
		this->window->close();
	}

	this->resumeButton.setPosition(350.f, 450.f);
	this->resumeButton.setSize(sf::Vector2f(600.f, 208.f));
    this->resumeButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->resumeButton.setTexture(&resumeButtonTexture);
	
	
	if(!this->exitButtonTexture.loadFromFile("assets/Buttons/ExitButton.png")){
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
void PauseScreen::initBackground(){
	if (!this->backgroundTexture.loadFromFile("assets/Backgrounds/MenuBackground.jpg")) {
        std::cerr << "Falta imagen de boton fondo" << std::endl;
		this->window->close();
    }
	
    this->background.setTexture(backgroundTexture);
}



//Constructor and Destructor
PauseScreen::PauseScreen(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
	this->initButtons();
	this->initBackground();
}

PauseScreen::~PauseScreen(){
	//delete this->window;
}



//Funtions
/*
	@return bool
	Verify if the window is still open
*/
bool PauseScreen::stopped() const{
	return this->inPause;
}

//Principal Menu Loop
void PauseScreen::pollEvents(){
		
}

//Funtions

/*
	@return void
	This call the funtion that handle all the cases posible in the PauseScreen.
*/
void PauseScreen::update(bool& playing){
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			
			case sf::Event::Closed:
				this->inPause = false;
				break;
				
			//Close the PauseScreen and delete the window
			case sf::Event::KeyPressed:
				if(this->event.key.code == sf::Keyboard::Escape){
					this->inPause = false;
				}
				break;	
				
			/*
				Cases for the menu
				when it's pressed it gets the position x and y of left mouse button and compared with bounds of each button to verify if the user want to to another screen.
			*/
			case sf::Event::MouseButtonPressed:
                if(this->event.mouseButton.button == sf::Mouse::Left) {
                    sf::Vector2f mousePos = sf::Vector2f(sf::Mouse::getPosition(*this->window).x, sf::Mouse::getPosition(*this->window).y);

                    if (this->resumeButton.getGlobalBounds().contains(mousePos)) {
						this->inPause = false;
                   
                    } else if (exitButton.getGlobalBounds().contains(mousePos)) {
                        this->inPause = false;
						playing = false;
                    }
                }
				break;
				
			default:
				break;
		}
	}
}


/*
	@return void
	Prepares all the things that will be shown in the window
*/
void PauseScreen::render(){
	this->window->clear();
	
	this->window->draw(this->background);
	
	//Draw the menu
	this->window->draw(this->resumeButton);
	this->window->draw(this->exitButton);
	
	this->window->display();
}




