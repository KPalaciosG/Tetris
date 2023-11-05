#include "Cerebro.hh"

//Funtions from assembly
extern "C" void clearAll();

extern "C" char* getMatrix();
extern "C" char getBlock();
extern "C" void rotateTetrinomio(int, char);
extern "C" void moveRight(char);
extern "C" void moveLeft(char);
extern "C" void moveDown(char);
extern "C" bool checkTetrinomioState();
extern "C" bool checkMatrixState();
extern "C" void clearRows();
extern "C" void dropAllBlocks();
extern "C" char getNextTetrinomio();

extern "C" char* getSubMatrix();
extern "C" void setNextTetrinomio(char);


/*
	@return void
	Initializes all the variables of the class
*/
void Cerebro::initializeVariables(){
	this->window = nullptr;
	
	this->playing = true;
	this->currentScore = 0;
	this->amountOfMoves = 0;
	this->retroFont.loadFromFile("assets/Fonts/ARCADECLASSIC.TTF");
	
	currentTetrinomio = getBlock();
	nextTetrinomio = getNextTetrinomio();
	setNextTetrinomio(nextTetrinomio);

}

/*
	@return void
	Set the current window as the window used in the main menu, to avoid creating multiple windows.	
*/
void Cerebro::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}

void Cerebro::initGameArea(){
	this->getGameArea();
}


/*
	@return void
	Sets the kind of the text that will show the current score.	
*/
void Cerebro::initScore(){
	//Font
	this->score.setFont(retroFont);
	//Color
	this->score.setFillColor(sf::Color::White);
	//Size
	this->score.setCharacterSize(50);
    //Position
    this->score.setPosition(30.f, 2.f);
}


/*
	@return void
	Creates all the buttons of the main menu with their sprites:
		pauseButton -> playButtonTexture
	
	Also it handle the errors if there's not a sprite
*/

void Cerebro::initButtons(){
	if(!this->pauseButtonTexture.loadFromFile("assets/Buttons/PauseButton.png")){
		std::cerr << "Falta imagen de boton de pause" << std::endl;
		this->window->close();
	}

	this->pauseButton.setPosition(700.f, 800.f);
	this->pauseButton.setSize(sf::Vector2f(600.f, 208.f));
    this->pauseButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->pauseButton.setTexture(&pauseButtonTexture);
	
}

/*
	@return void
	It creates and adds the background sprite
	Also it handle the error if there's not the sprite
*/
void Cerebro::initBackground(){
	if (!this->backgroundTexture.loadFromFile("assets/Backgrounds/InGameBackground.jpg")) {
        std::cerr << "Falta imagen de boton fondo" << std::endl;
		this->window->close();
    }
	
    this->background.setTexture(backgroundTexture);
}

/*
	@return void
	Adds all the textures for the blocks
*/
void Cerebro::initBlockTexture(){
	this->emptyBlockTexture.loadFromFile("assets/Blocks/emptyBlock.png");
	this->redBlockTexture.loadFromFile("assets/Blocks/redBlock.png");
	this->greenBlockTexture.loadFromFile("assets/Blocks/greenBlock.png");
	this->blueBlockTexture.loadFromFile("assets/Blocks/blueBlock.png");
	this->yellowBlockTexture.loadFromFile("assets/Blocks/yellowBlock.png");
	this->purpleBlockTexture.loadFromFile("assets/Blocks/purpleBlock.png");
	this->cyanBlockTexture.loadFromFile("assets/Blocks/cyanBlock.png");
	this->orangeBlockTexture.loadFromFile("assets/Blocks/orangeBlock.png");
}

/*
	@return void
	Gets the real matrix, and copy the values in it, to display them.
*/
void Cerebro::getGameArea(){
	char* pMatrix = getMatrix();

	int k = 0;
	for(int i = 0; i < rows; ++i){
		for(int j = 0; j < columns; ++j){
			shadowMatrix[i][j] = pMatrix[k];
			++k;
		}
	}

}

void Cerebro::copyNextTetrinomio(){
	char* pSubMatrix = getSubMatrix();

	int k = 0;
	for(int i = 0; i < 4; ++i){
		for(int j = 0; j < 4; ++j){
			shadowSubMatrix[i][j] = pSubMatrix[k];
			++k;
		}
	}
}


/*
-------------	
Constructor and Destructor
-------------	
*/
Cerebro::Cerebro(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
	this->initGameArea();
	this->initScore();
	this->initBackground();
	this->initButtons();
	this->initBlockTexture();
}

Cerebro::~Cerebro(){
	clearAll();
}

/*
-------------	
Funtions	
-------------	
*/

/*
	@return bool
	Return if the current game is finished or if the user once to finish the program.
*/
bool Cerebro::finishedGame() const{
	return this->playing;
}


/*
	@return void
	It's the main loop of the game.
	Control the cases for each I/O event, and call the funtions in assembly to manipulate the matrix that represents the game area
*/
void Cerebro::update(){
	//this->startGame();
	while(this->window->pollEvent(this->event)){
		
		switch(this->event.type){ 
			//Close the window
			case sf::Event::Closed:
				this->playing = false;
				break;
			
			//Keyboard Cases
			case sf::Event::KeyReleased:
				/*
					This call the funtion that's going to turn to right the current Tetrinomio
				*/
				if(this->event.key.code == sf::Keyboard::Up){
					++this->amountOfMoves;
					rotateTetrinomio(amountOfMoves, currentTetrinomio);
				}
			
				break;
			//Keyboard Cases
			case sf::Event::KeyPressed:
			
				/*
					This call the funtion that's going to move the current Tetrinomio to the Left
				*/
				if(this->event.key.code == sf::Keyboard::Right){	
					moveRight(currentTetrinomio);	
				}
				
				/*
					This call the funtion that's going to move the current Tetrinomio to the Right
				*/
				else if(this->event.key.code == sf::Keyboard::Left){
					//++this->currentScore;
					moveLeft(currentTetrinomio);
				}
				
				/*
					This call the funtion that's going to get down faster the Tetrinomio
				*/
				else if(this->event.key.code == sf::Keyboard::Down){
					moveDown(currentTetrinomio);	
				}
				
				/*
					This call the funtion that's going to move the current Tetrinomio to down, until the tetrinomio can't move anymore
				*/
				else if(this->event.key.code == sf::Keyboard::Space){
					
					while(checkTetrinomioState()){
						moveDown(currentTetrinomio);
					}
				}
				
				/*
					Stop the current game and will come back to the main menu
				*/
				else if(this->event.key.code == sf::Keyboard::Escape){
					this->pause();
				}
				break;
			
			//Mouse Cases
			case sf::Event::MouseButtonPressed:
			
				if(this->event.mouseButton.button == sf::Mouse::Left) {
				sf::Vector2f mousePos = sf::Vector2f(sf::Mouse::getPosition(*this->window).x, sf::Mouse::getPosition(*this->window).y);
				
					if(pauseButton.getGlobalBounds().contains(mousePos)) {
						this->pause();
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
	It calls and make the necessary verifications after each update of the matrix
*/
void Cerebro::defaultMoves(){
	
	if (!checkTetrinomioState()) { //Verify if the current tetrinomio can still go down, if not, create a new one
		clearRows(); //Delete all the complete rows
		dropAllBlocks(); //Drop all the block that have down an empty row
		this->amountOfMoves = 0; //reset the rotations of the new tetrinomio
		currentTetrinomio = getBlock(); //create the new tetrinomio
		nextTetrinomio = getNextTetrinomio();
		setNextTetrinomio(nextTetrinomio);
	} 
	
	moveDown(currentTetrinomio);
	
	if(this->playing){ //If there's a game being played, verify if the player didn't lose
		this->playing = checkMatrixState();
	}	
	
}


void Cerebro::pause(){
	PauseScreen pauseScreen = PauseScreen(this->window);
	while(pauseScreen.stopped()){
		//Update
		pauseScreen.update(this->playing);
		
		//Render
		pauseScreen.render();
	}
	
	if(this->playing){
		this->render();
		sf::sleep(sf::seconds(2));
	}

}

/*
	@return void
	Prepares all the things that will be shown in the window
*/
void Cerebro::render(){
	this->window->clear();
	
	//poner background
	this->window->draw(this->background);
	this->window->draw(this->pauseButton);
	
	//dibujar matriz
	this->drawScore();
	this->drawSubMatrix();
	this->drawMatrix();

	
	this->window->display();
}


/*
	@return void
	It handles the update of the shadowMatrix that shows the real matrix of the game area, this is useful because it lets to the user watch the game, and it easier to control.
*/
void Cerebro::drawMatrix(){
	//Gets new values of the real matrix
	this->getGameArea();
	
	//Use it to center the game area
	double centerX = 7.5;
	double centerY = 2;
	
	//Loops to show the shadowMatrix values
	for (int i = 0; i < rows; ++i) { // CenterX = i + centerX -> height
        for (int j = 0; j < columns; ++j) { // CenterY = j + centerY -> width 

			//Creates each block
            sf::RectangleShape block(sf::Vector2f(blockSize, blockSize));
			
			//Sets the relative position of each block
            block.setPosition((j + centerX) * blockSize, (i + centerY) * blockSize);

			//Verify the value of each cell of the matrix to assing the color of the block
            switch (this->shadowMatrix[i][j]) {
				// 0 = empty
                case '0':
                    //block.setFillColor(sf::Color::White);
					block.setTexture(&emptyBlockTexture);
                    break;
				// 1 = red
                case '1':
                    //block.setFillColor(sf::Color::Red);
					block.setTexture(&redBlockTexture);
                    break;
				// 2 = Green	
                case '2':
                    //block.setFillColor(sf::Color::Green);
					block.setTexture(&greenBlockTexture);
                    break;
				// 3 = Blue
                case '3':
                    //block.setFillColor(sf::Color::Blue);
					block.setTexture(&blueBlockTexture);
                    break;
				// 4 = Yellow
                case '4':
                    //block.setFillColor(sf::Color::Yellow);
					block.setTexture(&yellowBlockTexture);
                    break;
				// 5 = Magenta
                case '5':
                    //block.setFillColor(sf::Color::Magenta);
					block.setTexture(&purpleBlockTexture);
                    break;	
				// 6 = Cyan
                case '6':
                    //block.setFillColor(sf::Color::Cyan);
					block.setTexture(&cyanBlockTexture);
                    break;
				// 7 = orange
                case '7':
                    //block.setFillColor(sf::Color(255, 165, 0));
					block.setTexture(&orangeBlockTexture);
                    break;
					
                default:
                    //block.setFillColor(sf::Color::White);
					block.setTexture(&emptyBlockTexture);
                    break;
            }
			
			//Adds/Draws each block to the window that will be shown 
            this->window->draw(block);
        }
    }
}

void Cerebro::drawSubMatrix(){
	//Gets new values of the real matrix
	this->copyNextTetrinomio();
	
	//Use it to center the game area
	double centerX = 19;
	double centerY = 1.5;
	
	//Loops to show the shadowMatrix values
	for (int i = 0; i < 4; ++i) { // CenterX = i + centerX -> height
        for (int j = 0; j < 4; ++j) { // CenterY = j + centerY -> width 

			//Creates each block
            sf::RectangleShape block(sf::Vector2f(blockSize, blockSize));
			
			//Sets the relative position of each block
            block.setPosition((j + centerX) * blockSize, (i + centerY) * blockSize);

			//Verify the value of each cell of the matrix to assing the color of the block
            switch (this->shadowSubMatrix[i][j]) {
				// 0 = empty
                case '0':
                    block.setFillColor(sf::Color::Black);
                    break;
				// 1 = red
                case '1':
                    //block.setFillColor(sf::Color::Red);
					block.setTexture(&redBlockTexture);
                    break;
				// 2 = Green	
                case '2':
                    //block.setFillColor(sf::Color::Green);
					block.setTexture(&greenBlockTexture);
                    break;
				// 3 = Blue
                case '3':
                    //block.setFillColor(sf::Color::Blue);
					block.setTexture(&blueBlockTexture);
                    break;
				// 4 = Yellow
                case '4':
                    //block.setFillColor(sf::Color::Yellow);
					block.setTexture(&yellowBlockTexture);
                    break;
				// 5 = Magenta
                case '5':
                    //block.setFillColor(sf::Color::Magenta);
					block.setTexture(&purpleBlockTexture);
                    break;	
				// 6 = Cyan
                case '6':
                    //block.setFillColor(sf::Color::Cyan);
					block.setTexture(&cyanBlockTexture);
                    break;
				// 7 = orange
                case '7':
                    //block.setFillColor(sf::Color(255, 165, 0));
					block.setTexture(&orangeBlockTexture);
                    break;
					
                default:
                    block.setFillColor(sf::Color::Black);
                    break;
            }
			
			//Adds/Draws each block to the window that will be shown 
            this->window->draw(block);
        }
    }
}


/*
	@return void
	Draws the actual score in the window
*/
void Cerebro::drawScore(){
	this->score.setString("Score  " + std::to_string(currentScore));
	this->window->draw(score);
}
