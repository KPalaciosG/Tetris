#include "Cerebro.hh"
//Prueba
const int rows = 20;
const int cols = 10;
const int blockSize = 30;

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
					this->matrix[5][9] = 0;
					this->matrix[6][9] = 0;
					this->matrix[7][9] = 0;
				}
				
				else if(this->event.key.code == sf::Keyboard::Right){
					this->matrix[5][9] = 2;
					this->matrix[6][9] = 2;
					this->matrix[7][9] = 2;
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

//Render
void Cerebro::render(){
	this->window->clear();
	//poner background
	//dibujar matriz
	this->drawMatrix();
	this->window->display();
}

void Cerebro::drawMatrix(){
	double centroX = 3;
	double centroY = 6.7;
	
	for (int i = 0; i < rows; ++i) {
		// i es la altura -> i + centroX para centrar
        for (int j = 0; j < cols; ++j) {
			//j es el ancho -> j + centroY para centrar
            sf::RectangleShape block(sf::Vector2f(blockSize, blockSize));
            block.setPosition((j + centroY) * blockSize, (i + centroX) * blockSize);

            switch (this->matrix[i][j]) {
                case 0:
                    block.setFillColor(sf::Color::Black);
                    break;
                case 1:
                    block.setFillColor(sf::Color::Red);
                    break;
                case 2:
                    block.setFillColor(sf::Color::Green);
                    break;
                case 3:
                    block.setFillColor(sf::Color::Blue);
                    break;
                default:
                    // Color predeterminado
                    block.setFillColor(sf::Color::White);
                    break;
            }

            this->window->draw(block);
        }
    }
}




