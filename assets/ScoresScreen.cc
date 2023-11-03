#include "ScoresScreen.hh"

void ScoresScreen::initializeVariables(){
	this->window = nullptr;
	this->showingScores = true;
	this->retroFont.loadFromFile("assets/Fonts/ARCADECLASSIC.TTF");
	//En lugar de ese texto se deberia de llamar una funcion que agarre los top scores
	this->topScores = "Top Scores";
	
}

void ScoresScreen::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}


/*
	@return void
	Sets the kind of the text that will show the top scores.	
*/
void ScoresScreen::initTopScore(){
	//Font
	this->scores.setFont(retroFont);
	//Color
	this->scores.setFillColor(sf::Color::White);
	//Size
	this->scores.setCharacterSize(50);
    //Position
    this->scores.setPosition(120.f, 25.f);
}


/*
	@return void
	Creates all the buttons of the main menu with their sprites:
		playButton -> playButtonTexture
		scoresButton -> scoresButtonTexture
		exitButton -> exitButtonTexture
	Also it handle the errors if there's not a sprite
*/
void ScoresScreen::initButtons(){
	
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
void ScoresScreen::initBackground(){
	if (!this->backgroundTexture.loadFromFile("assets/Backgrounds/ScoresBackground.jpg")) {
        std::cerr << "Falta imagen de boton fondo" << std::endl;
		this->window->close();
    }
	
    this->background.setTexture(backgroundTexture);
}


//Constructor and Destructor
ScoresScreen::ScoresScreen(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
	this->initTopScore();
	this->initBackground();
	this->initButtons();
}

ScoresScreen::~ScoresScreen(){
	//delete this->window;
}



//Funtions

/*
	@return bool
	Return if the window is open.	
*/
bool ScoresScreen::showing() const{
	return this->showingScores;
}


/*
	@return void
	Control the cases for each I/O event
*/
void ScoresScreen::pollEvents(){
	
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			//Close the window
			case sf::Event::Closed:
				this->window->close();
				break;
				
			case sf::Event::KeyPressed:
				/*
					Stop showing the scores and will come back to the main menu
				*/
				if(this->event.key.code == sf::Keyboard::Escape){
					this->showingScores = false;
				}
				break;
				
			case sf::Event::MouseButtonPressed:
                if(this->event.mouseButton.button == sf::Mouse::Left) {
                    sf::Vector2f mousePos = sf::Vector2f(sf::Mouse::getPosition(*this->window).x, sf::Mouse::getPosition(*this->window).y);
					
                    if (exitButton.getGlobalBounds().contains(mousePos)) {
                        this->showingScores = false;
                    }
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
	
	this->window->draw(this->background);
	
	//Draw the menu
	this->window->draw(this->exitButton);
	
	this->drawTopScores();
	
	
	this->window->display();
}

/*
	@return void
	Draws the top scores in the window
*/
void ScoresScreen::drawTopScores(){
	this->scores.setString(topScores);
	this->window->draw(scores);
}




