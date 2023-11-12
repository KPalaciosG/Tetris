#include "Game.hh"
#include "Cerebro.hh"
#include "ScoresScreen.hh"

/*
 * @brief Esta función inicializa todas los atributos de la clase.
 * @param 
 * @return void
 */
void Game::initializeVariables(){
	this->window = nullptr;
}


/*
 * @brief Crea la ventana que se utiliza en las distintas pantallas
		  height: 960
		  width: 1000
 * @param 
 * @return void
 */
void Game::initWindow(){
	this->videoMode.height = 960; //altura
	this->videoMode.width = 1000; //ancho
	
	this->window = new sf::RenderWindow(this->videoMode, "Tetris", sf::Style::Close);
	this->window->setFramerateLimit(60);
	
	//Obtiene el size de la pantalla del desktop
	sf::VideoMode desktopMode = sf::VideoMode::getDesktopMode();

	//Calcula la posicion central de la pantalla
    int xPos = (desktopMode.width - videoMode.width) / 2;
    int yPos = (desktopMode.height - videoMode.height) / 2;

    //Sets the position of the window
    this->window->setPosition(sf::Vector2i(xPos, yPos));
}

/*
 * @brief Crea y configura los botones que se muestran en l menu principal y maneja los errores con las texturas.
		playButton -> playButtonTexture
		scoresButton -> scoresButtonTexture
		exitButton -> exitButtonTexture
 * @param 
 * @return void
 */
void Game::initButtons(){
	//Carga la textura del boton de play
	if(!this->playButtonTexture.loadFromFile("assets/Buttons/PlayButton.png")){
		std::cerr << "Falta imagen de boton de play" << std::endl;
		this->window->close();
	}
	//Configuracion del boton de play
	this->playButton.setPosition(350.f, 450.f);
	this->playButton.setSize(sf::Vector2f(600.f, 208.f));
    this->playButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->playButton.setTexture(&playButtonTexture);
	
	//Carga la textura del boton de scores
	if(!this->scoresButtonTexture.loadFromFile("assets/Buttons/ScoreButton.png")){
		std::cerr << "Falta imagen de boton de scores" << std::endl;
		this->window->close();
	}
	//Configuracion del boton de scores
	this->scoresButton.setPosition(350.f, 600.f);
	this->scoresButton.setSize(sf::Vector2f(600.f, 208.f));
    this->scoresButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->scoresButton.setTexture(&scoresButtonTexture);
	
	//Carga la textura del boton de exit
	if(!this->exitButtonTexture.loadFromFile("assets/Buttons/ExitButton.png")){
		std::cerr << "Falta imagen de boton de exit" << std::endl;
		this->window->close();
	}
	//Configuracion del boton de exit
	this->exitButton.setPosition(350.f, 750.f);
	this->exitButton.setSize(sf::Vector2f(600.f, 208.f));
    this->exitButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->exitButton.setTexture(&exitButtonTexture);
	
}

/*
 * @brief Crea y configura el fondo que se muestra en el menu principal.
		background -> backgroundTexture
 * @param 
 * @return void
 */
void Game::initBackground(){
	//Carga el sprite del fondo
	if (!this->backgroundTexture.loadFromFile("assets/Backgrounds/MenuBackground.jpg")) {
        std::cerr << "Falta imagen de background del menu" << std::endl;
		this->window->close();
    }
	//Set del sprite
    this->background.setTexture(backgroundTexture);
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
Game::Game(){
	this->initializeVariables();
	this->initWindow();
	this->initButtons();
	this->initBackground();
}

/*
 * @brief Destructor.
 * @param sf::RenderWindow*& window
 */
Game::~Game(){
	  if (this->window != nullptr) {
        delete this->window;
        this->window = nullptr;
    }
}


/*
	--------	
	Funtions	
	--------
*/

/*
 * @brief Devuelve un bool que dice si la ventana esta abierta.
 * @param 
 * @return bool
 */
bool Game::windowOpen() const{
	return this->window->isOpen();
}


/*
 * @brief Loop principal del menu que maneja los eventos de I/O.
 * @param 
 * @return void
 */
void Game::pollEvents(){
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			
			// X -> cierra la ventana
			case sf::Event::Closed:
				this->window->close();
				break;
				
			case sf::Event::KeyPressed:
				// Cierra la ventana
				if(this->event.key.code == sf::Keyboard::Escape){
					this->window->close();
				}
				break;	
			
			/*
				Casos para los botones del menu
				Cuando se presiona el clic izquierdo del mouse, obtiene la posicion (x,y) del mouse y 
				lo compara con el area de cada boton para verificar si se presiono un boton
				Si se presiono, realiza una accion especifica
			*/
			case sf::Event::MouseButtonPressed:
                if(this->event.mouseButton.button == sf::Mouse::Left) {
                    sf::Vector2f mousePos = sf::Vector2f(sf::Mouse::getPosition(*this->window).x, sf::Mouse::getPosition(*this->window).y);

					//Caso del boton de play
                    if (this->playButton.getGlobalBounds().contains(mousePos)) {
						//Construye una partida, pasando la ventana actual como parametro
						std::unique_ptr<Cerebro> partida(new Cerebro(this->window));
						
						//Clock things
						sf::Clock clock;
						float fallSpeed = 0.3f; //Down speed 
						float elapsedTotalTime = 0.0f; //Total of the time elapsed
						
						while(partida->finishedGame()){ //while there is game being played
							
							sf::Time elapsed = clock.restart(); // init the time since the last iteration
							elapsedTotalTime += elapsed.asSeconds(); 
							 
							//Update obtiene las acciones que quiere ejecutar el jugador
							partida->update();
							
							// Para controlar el tiempo de caida de los tetrinomios
							// si el tiempo que a transcurrido, es mayor que la velocidad a la que debe bajar el tetrinomio, lo baja
							if (elapsedTotalTime > fallSpeed) {
								partida->defaultMoves(); //Los movimientos que siempre se deben de realizar en la partida
								elapsedTotalTime = 0.0f; 
							}
							
							//Si el jugador no ha perdido o no ha cerrado la partida
							//Render muestra el resultado de las acciones que se ejecutaron previamente
							if(partida->finishedGame()){
								partida->render();
							}
							sf::sleep(sf::milliseconds(10));
							
						}
						
                    //Caso del boton de score
                    } else if(scoresButton.getGlobalBounds().contains(mousePos)) {
						//Construye una pantalla de scores
                        ScoresScreen scoresScreen = ScoresScreen(this->window);
						
						while(scoresScreen.showing()){
							//Update, se encarga de cargar los top scores
							scoresScreen.update();
							
							//Render, muestra los top scores y los sprites necesarios
							scoresScreen.render();
						}
						
                    //Caso del boton de exit    
                    } else if (exitButton.getGlobalBounds().contains(mousePos)) {
						//Cierra la ventana
                        window->close();
                    }
                }
				break;
				
			default:
				break;
		}
	}	
}

/*
	--------	
	Funtions	
	--------
*/

/*
 * @brief Llama a la funcion que maneja los eventos.
 * @param 
 * @return void
 */
void Game::update(){
	this->pollEvents();
}



/*
 * @brief Grafica todo el menu
 * @param 
 * @return void
 */
void Game::render(){
	this->window->clear();
	
	//Background
	this->window->draw(this->background);
	
	//Draw the menu
	this->window->draw(this->playButton);
	this->window->draw(this->scoresButton);
	this->window->draw(this->exitButton);
	
	this->window->display();
}
