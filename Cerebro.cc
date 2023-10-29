#include "Cerebro.hh"

//Funtions from assembly
extern "C" char* getMatrix();
extern "C" void getBlock();
extern "C" void rotateTetrinomio(int, char);
extern "C" void moveRight(char);
extern "C" void moveLeft(char);
extern "C" void moveDown(char);

/*
	@return void
	Initializes all the variables of the class
*/
void Cerebro::initializeVariables(){
	this->window = nullptr;
	this->playing = true;
	this->currentScore = 0;
	this->retroFont.loadFromFile("retro.ttf");
	
	//this->currentTetrinomio = getBlock()
	//this->nextTetrinomio = getBlock()
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

void Cerebro::initScore(){
	//Font
	this->score.setFont(retroFont);
	//Color
	this->score.setFillColor(sf::Color::White);
	//Size
	this->score.setCharacterSize(50);
}

/*
	@return void
	Gets the real matrix, and copy the values in it, to display them.
*/
void Cerebro::getGameArea(){
	char* pmatrix = getMatrix();

	int k = 0;
	for(int i = 0; i < rows; ++i){
		for(int j = 0; j < columns; ++j){
			shadowMatrix[i][j] = pmatrix[k];
			++k;
		}
	}
}


//Constructor and Destructor
Cerebro::Cerebro(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
	this->initGameArea();
	this->initScore();
}

Cerebro::~Cerebro(){
	
}

//Funtions

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
	Control the cases for each keyboard event, and call the funtions in assembly to manipulate the matrix that represents the game area
*/
void Cerebro::startGame(){
	
	while(this->window->pollEvent(this->event)){
		
		switch(this->event.type){ 
			//Close the window
			case sf::Event::Closed:
				this->window->close();
				break;
			
			//Keyboard Cases
			case sf::Event::KeyPressed:
			
				/*
					This call the funtion that's going to move the current Tetrinomio to the Left
				*/
				if(this->event.key.code == sf::Keyboard::Right){	
					//getBlock();
					//++amountOfMoves;
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
					This call the funtion that's going to turn to right the current Tetrinomio
				*/
				else if(this->event.key.code == sf::Keyboard::Up){
					++amountOfMoves;
					rotateTetrinomio(amountOfMoves, currentTetrinomio);
				}
				
				/*
					This call the funtion that's going to get down faster the Tetrinomio
				*/
				else if(this->event.key.code == sf::Keyboard::Down){
					moveDown(currentTetrinomio);
				}
				
				/*
					Stop the current game and will come back to the main menu
				*/
				else if(this->event.key.code == sf::Keyboard::Escape){
					this->playing = false;
				}
				break;
			
			//Mouse Cases
			case sf::Event::MouseButtonPressed:
				if(this->event.mouseButton.button == sf::Mouse::Left) {
					getBlock();
				}
				break;
				
			default:
				break;
		}
		/*
		if(checkState(currentTetrinomio) == false){
			clearRows();
			dropAllBlocks();
			currentTetrinomio = nextTetrinomio;
			nextTetrinomio = getBlock();
		}
		else{
			moveBlock(down, currentTetrinomio);
		}*/
		
		//playing = checkMatriz();
	}	
}

//Funcion que limipie la matriz


/*
	@return void
	This call the funtion that handle all the cases posible in the game.
*/
void Cerebro::update(){
	this->startGame();
}


/*
	@return void
	Prepares all the things that will be shown in the window
*/
void Cerebro::render(){
	this->window->clear();
	//poner background
	//dibujar matriz
	this->drawScore();
	this->drawMatrix();
	this->window->display();
}


/*
	@return void
	It handles the update of the shadowMatrix that shows the real matrix of the game area, this is useful because it lets to the user watch the game, and it easier to control.
*/
void Cerebro::drawMatrix(){
	//Gets new values of the real matrix
	getGameArea();
	
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
                    block.setFillColor(sf::Color::White);
                    break;
				// 1 = red
                case '1':
                    block.setFillColor(sf::Color::Red);
                    break;
				// 2 = blue	
                case '2':
                    block.setFillColor(sf::Color::Green);
                    break;
				// 3 = green
                case '3':
                    block.setFillColor(sf::Color::Blue);
                    break;
				// 4 = yellow
                case '4':
                    block.setFillColor(sf::Color::Blue);
                    break;
				// 5 = pink
                case '5':
                    block.setFillColor(sf::Color::Blue);
                    break;	
				// 6 = purple
                case '6':
                    block.setFillColor(sf::Color::Blue);
                    break;
				// 7 = orange
                case '7':
                    block.setFillColor(sf::Color::Blue);
                    break;
					
                default:
                    // Color predeterminado
                    block.setFillColor(sf::Color::White);
                    break;
            }
			
			//Adds/Draws each block to the window that will be shown 
            this->window->draw(block);
        }
    }
}


void Cerebro::drawScore(){
	this->score.setString("Score: " + std::to_string(currentScore));
	this->window->draw(score);
}
