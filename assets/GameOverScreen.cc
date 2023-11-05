#include "GameOverScreen.hh"

/*
	@return void
	Initializes all the variables of the class
*/
void GameOverScreen::initializeVariables(){
	this->window = nullptr;
	this->inPause = true;
	this->inputActive = true;
	this->retroFont.loadFromFile("assets/Fonts/ARCADECLASSIC.TTF");
}


/*
	@return void
	Creates the window on the center of the desktop window:
		height: 960
		width: 1000
		
*/
void GameOverScreen::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}

/*
	@return void
	Sets the kind of the text that will show the current text.	
*/
void GameOverScreen::initText(){
	//Font
	this->text.setFont(retroFont);
	//Color
	this->text.setFillColor(sf::Color::White);
	//Size
	this->text.setCharacterSize(60);
    //Position
    this->text.setPosition(100.f, 400.f);
}

/*
	@return void
	Creates all the buttons of the main menu with their sprites:
		resumeButton -> resumeButtonTexture
		exitButton -> exitButtonTexture
	Also it handle the errors if there's not a sprite

void GameOverScreen::initButtons(){
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
	
}*/

/*
	@return void
	It creates and adds the background sprite
	Also it handle the error if there's not the sprite
*/
void GameOverScreen::initBackground(){
	if (!this->backgroundTexture.loadFromFile("assets/Backgrounds/MenuBackground.jpg")) {
        std::cerr << "Falta imagen de boton fondo" << std::endl;
		this->window->close();
    }
	
    this->background.setTexture(backgroundTexture);
}



//Constructor and Destructor
GameOverScreen::GameOverScreen(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
	//this->initButtons();
	this->initBackground();
	this->initText();
}

GameOverScreen::~GameOverScreen(){
	//delete this->window;
}



//Funtions
/*
	@return bool
	Verify if the window is still open
*/
bool GameOverScreen::stopped() const{
	return this->inPause;
}

//Principal Menu Loop
void GameOverScreen::pollEvents(){
		
}

//Funtions

/*
	@return void
	This call the funtion that handle all the cases posible in the GameOverScreen.
*/
void GameOverScreen::update(){
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			
			case sf::Event::Closed:
				this->inPause = false;
				break;
				
			//Close the GameOverScreen and delete the window
			case sf::Event::KeyPressed:
				if(this->event.key.code == sf::Keyboard::Escape){
					this->inPause = false;
				}
				else if(this->event.key.code == sf::Keyboard::Enter){
					this->inputActive = false;
				}
				break;	
				
			case sf::Event::TextEntered:
				 if (inputActive && event.text.unicode < 128){
					
                    if (event.text.unicode == 8){
                        if (!player.empty())
                            player.pop_back();
                    }
                    else{
                        player += static_cast<char>(event.text.unicode);
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
void GameOverScreen::render(int score){
	this->window->clear();
	
	this->window->draw(this->background);
	
	//Draw the menu
	//this->window->draw(this->resumeButton);
	//this->window->draw(this->exitButton);
	this->drawText(score);
	this->window->display();
}

/*
	@return void
	Draws the actual text in the window
*/
void GameOverScreen::drawText(int score){
	if(inputActive){
		this->text.setString("ENTER YOUR NAME: \n" + player + "\nPRESS ENTER WHEN YOU'RE DONE\n" );
	}
	else{
		this->text.setString(player + "\nYOUR SCORE: " + std::to_string(score) + "\nPRESS ESC TO EXIT\n" );
	}	
	this->window->draw(text);
}


