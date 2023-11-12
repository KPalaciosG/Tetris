#include "Cerebro.hh"

/*--------------------------
	Funtions from assembly
  --------------------------*/

//"Delete"
extern "C" void clearAll();
//Gets
extern "C" char* getMatrix();
extern "C" char* getSubMatrix();
extern "C" char getTetrinomio();
extern "C" char getNextTetrinomio();
//Moves
extern "C" void rotateTetrinomio(int, char);
extern "C" void moveRight(char);
extern "C" void moveLeft(char);
extern "C" void moveDown(char);
//State
extern "C" bool checkTetrinomioState();
extern "C" bool checkMatrixState();
//Default
extern "C" int clearRows();
extern "C" void dropAllBlocks();
//Graphic
extern "C" void setNextTetrinomio(char);
//Auxiliar
extern "C" void shuffleTetrinomioOrder();
extern "C" int getRandomInt(int*);


/*
 * @brief Esta función inicializa todas los atributos de la clase.
 * @param 
 * @return void
 */
void Cerebro::initializeVariables(){
	this->window = nullptr;
	
	this->playing = true;
	
	this->currentScore = 0;
	this->amountOfRotations = 0;
	
	shuffleTetrinomioOrder();
	currentTetrinomio = getTetrinomio();
	nextTetrinomio = getNextTetrinomio();
	setNextTetrinomio(nextTetrinomio);
	
	this->retroFont.loadFromFile("assets/Fonts/ARCADECLASSIC.TTF");
}


/*
 * @brief Hace que la ventana, sea la misma que la del menu, para no crear multiples ventanas.
 * @param sf::RenderWindow*& window
 * @return void
 */
void Cerebro::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}

/*
 * @brief Obtiene los valores iniciales de la matriz, para mostrarla.
 * @param 
 * @return void
 */
void Cerebro::initGameArea(){
	this->getGameArea();
}

/*
 * @brief Configura el texto que va a mostrar el score en la pantalla.
 * @param 
 * @return void
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
 * @brief Crea y configura los botones que se muestran en la partida y maneja los errores con las texturas.
		pauseButton -> playButtonTexture
 * @param 
 * @return void
 */
void Cerebro::initButtons(){
	if(!this->pauseButtonTexture.loadFromFile("assets/Buttons/PauseButton.png")){
		std::cerr << "Falta imagen de boton de pause" << std::endl;
		this->window->close();
	}

	this->pauseButton.setPosition(800.f, 800.f);
	this->pauseButton.setSize(sf::Vector2f(100.f, 100.f));
    this->pauseButton.setScale(sf::Vector2f(1.0f, 1.0f));
    this->pauseButton.setTexture(&pauseButtonTexture);
	
}

/*
 * @brief Crea y configura el fondo que se muestra en la partida.
		background -> backgroundTexture
 * @param 
 * @return void
 */
void Cerebro::initBackground(){
	if (!this->backgroundTexture.loadFromFile("assets/Backgrounds/InGameBackground.jpg")) {
        std::cerr << "Falta imagen de background de la partida" << std::endl;
		this->window->close();
    }
	
    this->background.setTexture(backgroundTexture);
}

/*
 * @brief Crea y agrega todas las texturas de los bloques que componen los tetrinomios.
 * @param 
 * @return void
 */
 
 //To do... agregar las verificaciones
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
 * @brief Obtiene un puntero a la verdadera matriz de ensamblador, copia los valores en shadowMatrix, que es la matriz que se utiliza para graficar en el juego.
 * @param 
 * @return void
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


/*
 * @brief Obtiene un puntero a la matriz de ensamblador que contiene el siguiente tetrinomio, copia los valores en shadowSubMatrix, que es la matriz que se utiliza para graficar en el juego.
 * @param 
 * @return void
 */
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
	--------------------------	
	Constructor and Destructor
	--------------------------		
*/

/*
 * @brief Constructor.
 * @param sf::RenderWindow*& window
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

/*
 * @brief Destructor.
 * @param 
 */
Cerebro::~Cerebro(){
	clearAll(); // Limpia todas las variables utilizadas en ensamblador
}


/*
	--------	
	Funtions	
	--------
*/

/*
 * @brief Devuelve un bool que dice si ya termino la partida.
 * @param 
 * @return bool
 */
bool Cerebro::finishedGame() const{
	return this->playing;
}


/*
 * @brief Loop principal del juego que maneja los eventos de I/O.
 * @param 
 * @return void
 */
void Cerebro::update(){
	
	while(this->window->pollEvent(this->event)){
		
		switch(this->event.type){ 
			// X -> Termina la partida
			case sf::Event::Closed:
				this->playing = false;
				break;
			
			//Keyboard Cases
			case sf::Event::KeyReleased:
				// Flecha hacia arriba
				// LLama a la funcion de ensamblador que gira el Tetrinomio, lo gira hacia la derecha
				if(this->event.key.code == sf::Keyboard::Up){
					++this->amountOfRotations;
					rotateTetrinomio(amountOfRotations, currentTetrinomio);
				}
			
				break;
				
			//Keyboard Cases
			case sf::Event::KeyPressed:
			
				// Flecha hacia la derecha
				// LLama a la funcion de ensamblador que mueve el tetrinomio hacia la derecha
				if(this->event.key.code == sf::Keyboard::Right){	
					moveRight(currentTetrinomio);	
				}
				
				// Flecha hacia la izquierda
				// LLama a la funcion de ensamblador que mueve el tetrinomio hacia la izquierda
				else if(this->event.key.code == sf::Keyboard::Left){
					//++this->currentScore;
					moveLeft(currentTetrinomio);
				}
				
				/*
					Flecha hacia abajo
					LLama a la funcion de ensamblador que mueve el tetrinomio hacia abajo.
					Moverlo por cuenta propia da 1 pt
				*/
				else if(this->event.key.code == sf::Keyboard::Down){
					moveDown(currentTetrinomio);
					this->currentScore += 1;
				}
				
				/*
					Espacio
					LLama a la funcion de ensamblador que mueve el tetrinomio hacia abajo, hasta que no puede bajar mas.
					Da 1 pt por cada fila que bajo de golpe.
				*/
				else if(this->event.key.code == sf::Keyboard::Space){
					
					while(checkTetrinomioState()){
						moveDown(currentTetrinomio);
						this->currentScore += 1;
					}
					
				}
				
				// Pone la partida actual en pausa
				else if(this->event.key.code == sf::Keyboard::Escape){
					this->pause();
				}
				break;
			
			//Mouse Cases
			case sf::Event::MouseButtonPressed:
			
				if(this->event.mouseButton.button == sf::Mouse::Left) {
					sf::Vector2f mousePos = sf::Vector2f(sf::Mouse::getPosition(*this->window).x, sf::Mouse::getPosition(*this->window).y);
					// Presiona el boton de pausa -> Pone la partida actual en pausa
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
 * @brief Movimientos y verificaciones que se deben hacer siempre despues de leer la entrada de datos.
		Si ya no puede bajar el Tetrinomio acutal
			1. Trata de limpiar las filas
			2. Baja los bloques que puedan
			3. Obtiene el nuevo tetrinomio
			4. Obtiene el siguiente tetrinomio
			5. Pone las rotaciones en 0
			
		Baja el tetrinomio actual
			
		Verifica si ya perdio
			Si ya perdio muestra la pantalla de GameOver
 * @param 
 * @return void
 */
void Cerebro::defaultMoves(){
	
	if (!checkTetrinomioState()) { // Verifica si el tetrinomio puede seguir bajando
		this->currentScore += clearRows(); // Limpia las filas completas y asigna los puntos
		dropAllBlocks(); // Baja los bloques que puedan
		currentTetrinomio = getTetrinomio(); // obtiene el nuevo tetrinomio
		nextTetrinomio = getNextTetrinomio(); // obtiene el siguiente tetrinomio
		setNextTetrinomio(nextTetrinomio);
		this->amountOfRotations = 0; // pone las rotaciones en 0
	} 
	
	moveDown(currentTetrinomio); // Baja el tetrinomio
	
	if(this->playing){ // Verifica si ya perdio
		this->playing = checkMatrixState();
		
		if(!this->playing){
			this->gameOver();
		}
		
	}	
	
}


/*
 * @brief Crea una ventana de pausa, y espera la interaccion con el usuario.
		  Si el usuario decide continuar con la partida se espera 1seg para seguir moviendo el tetrinomio
 * @param 
 * @return void
 */
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
		sf::sleep(sf::seconds(1));
	}

}

/*
 * @brief Crea una ventana de GameOver, y espera la interaccion con el usuario.
		  Pide el nombre del jugador, y llama a la funcion que guarda los scores
 * @param 
 * @return void
 */
void Cerebro::gameOver() {
	GameOverScreen gameOverScreen = GameOverScreen(this->window);
	
	while(gameOverScreen.stopped()){
		//Update
		gameOverScreen.update();
		
		//Render
		gameOverScreen.render(this->currentScore);
	}
	
	
	std::string gameOverScore = gameOverScreen.getPlayer(); //Lee el nombre del jugador
	gameOverScore += " " + std::to_string(this->currentScore); // Crea el string
	gameOverScreen.checkScores(gameOverScore); // Verifica si esta en el top y lo guarda
}

/*
 * @brief Grafica toda partida
 * @param 
 * @return void
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
 * @brief Llama a la funcion que obtiene los valores de la matriz verdadera, dependiendo de cada valor (numeros del 0-7) 
		  agrega una textura cada bloque y lo dibuja en la ventana
 * @param 
 * @return void
 */
void Cerebro::drawMatrix(){
	this->getGameArea(); // Obtiene los valores de la verdadera matriz
	
	// Puntos desde los que se comienzan a graficar los bloques
	double centerX = 7.5; 
	double centerY = 2;
	
	// Loops para ir recorriendo la matriz y graficarla
	for (int i = 0; i < rows; ++i) { // CenterX = i + centerX -> height
        for (int j = 0; j < columns; ++j) { // CenterY = j + centerY -> width 

			//Crea un rectangulo que representa el bloque
            sf::RectangleShape block(sf::Vector2f(blockSize, blockSize));
			
			//Posiciona el bloque
            block.setPosition((j + centerX) * blockSize, (i + centerY) * blockSize);

			// Verifica el valor de cada celda de la matriz y agrega la respectiva textura
            switch (this->shadowMatrix[i][j]) {
				// 0 = empty
                case '0':
					block.setTexture(&emptyBlockTexture);
                    break;
				// 1 = red
                case '1':
					block.setTexture(&redBlockTexture);
                    break;
				// 2 = Green	
                case '2':
					block.setTexture(&greenBlockTexture);
                    break;
				// 3 = Blue
                case '3':
					block.setTexture(&blueBlockTexture);
                    break;
				// 4 = Yellow
                case '4':
					block.setTexture(&yellowBlockTexture);
                    break;
				// 5 = Magenta
                case '5':
					block.setTexture(&purpleBlockTexture);
                    break;	
				// 6 = Cyan
                case '6':
					block.setTexture(&cyanBlockTexture);
                    break;
				// 7 = orange
                case '7':
					block.setTexture(&orangeBlockTexture);
                    break;
					
                default:
					block.setTexture(&emptyBlockTexture);
                    break;
            }
			
			// Agrega y dibuja cada bloque en la ventana
            this->window->draw(block);
        }
    }
}



/*
 * @brief Llama a la funcion que obtiene los valores de la subMatriz que contiene el siguiente bloque, dependiendo de cada valor (numeros del 0-7) 
		  agrega una textura cada bloque y lo dibuja en la ventana
 * @param 
 * @return void
 */
void Cerebro::drawSubMatrix(){
	this->copyNextTetrinomio();  // Obtiene los valores de la verdadera matriz
	
	// Puntos desde los que se comienzan a graficar los bloques
	double centerX = 19;
	double centerY = 1.5;
	
	// Loops para ir recorriendo la matriz y graficarla
	for (int i = 0; i < 4; ++i) { // CenterX = i + centerX -> height
        for (int j = 0; j < 4; ++j) { // CenterY = j + centerY -> width 

			//Crea un rectangulo que representa el bloque
            sf::RectangleShape block(sf::Vector2f(blockSize, blockSize));
			
			//Posiciona el bloque
            block.setPosition((j + centerX) * blockSize, (i + centerY) * blockSize);

			// Verifica el valor de cada celda de la matriz y agrega la respectiva textura
            switch (this->shadowSubMatrix[i][j]) {
				// 0 = empty
                case '0':
                    block.setFillColor(sf::Color::Black);
                    break;
				// 1 = red
                case '1':
					block.setTexture(&redBlockTexture);
                    break;
				// 2 = Green	
                case '2':
					block.setTexture(&greenBlockTexture);
                    break;
				// 3 = Blue
                case '3':
					block.setTexture(&blueBlockTexture);
                    break;
				// 4 = Yellow
                case '4':
					block.setTexture(&yellowBlockTexture);
                    break;
				// 5 = Purple
                case '5':
					block.setTexture(&purpleBlockTexture);
                    break;	
				// 6 = Cyan
                case '6':
					block.setTexture(&cyanBlockTexture);
                    break;
				// 7 = orange
                case '7':
					block.setTexture(&orangeBlockTexture);
                    break;
					
                default:
                    block.setFillColor(sf::Color::Black);
                    break;
            }
			
			// Agrega y dibuja cada bloque en la ventana
            this->window->draw(block);
        }
    }
}


/*
 * @brief Dibuja el score en la ventana
 * @param 
 * @return void
 */
void Cerebro::drawScore(){
	this->score.setString("Score  \n" + std::to_string(currentScore));
	this->window->draw(score);
}


/*
	--------	
	Auxiliar	
	--------
*/

/*
 * @brief Retorna un numero random entre 1-7, que ademas no se encuentre en el arreglo recibido como parametro
 * @param int*
 * @return int
 */
int getRandomInt(int* order){
    int randomInt;
	bool keepLooking = true;
	
    srand(static_cast<unsigned>(time(nullptr)));

    do {
        randomInt = 1 + (rand() % 7); //genera un numero aleatorio
		int i = 0;
		bool found = false;
		
		while(!found && i < 7) {
			if(order[i] == randomInt ){
				found = true; //el numero ya se encuentra en el array
			}
			++i;
		}
		
		if(!found){
			keepLooking = false;
		}
		
    } while(keepLooking); //Sigue hasta que genere un numero que no este en el array

	//std::cout << randomInt << std::endl;
  
    return randomInt;
}