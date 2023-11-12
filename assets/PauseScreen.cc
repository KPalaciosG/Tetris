#include "PauseScreen.hh"

/*
 * @brief Esta función inicializa todas los atributos de la clase.
 * @param 
 * @return void
 */
void PauseScreen::initializeVariables(){
	this->window = nullptr;
	this->inPause = true;
}

/*
 * @brief Hace que la ventana, sea la misma que la de la partida, para no crear multiples ventanas.
 * @param sf::RenderWindow*& window
 * @return void
 */
void PauseScreen::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}

/*
 * @brief Crea y configura los botones que se muestran en la ventana de pausa y maneja los errores con las texturas.
		resumeButton -> resumeButtonTexture
		exitButton -> exitButtonTexture
 * @param 
 * @return void
 */
void PauseScreen::initButtons(){
	//Boton de continuar
	if(!this->resumeButtonTexture.loadFromFile("assets/Buttons/ContinueButton.png")){
		std::cerr << "Falta imagen de boton de continue" << std::endl;
		this->window->close();
	}

	this->resumeButton.setPosition(350.f, 450.f);
	this->resumeButton.setSize(sf::Vector2f(600.f, 208.f));
    this->resumeButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->resumeButton.setTexture(&resumeButtonTexture);
	
	//Boton de Salir
	if(!this->exitButtonTexture.loadFromFile("assets/Buttons/ExitButton.png")){
		std::cerr << "Falta imagen de boton de exit" << std::endl;
		this->window->close();
	}

	this->exitButton.setPosition(350.f, 600.f);
	this->exitButton.setSize(sf::Vector2f(600.f, 208.f));
    this->exitButton.setScale(sf::Vector2f(0.5f, 0.5f));
    this->exitButton.setTexture(&exitButtonTexture);
	
}

/*
 * @brief Crea y configura el fondo que se muestra en la partida.
		background -> backgroundTexture
 * @param 
 * @return void
 */
void PauseScreen::initBackground(){
	if (!this->backgroundTexture.loadFromFile("assets/Backgrounds/PauseBackground.png")) {
        std::cerr << "Falta imagen de background de pause" << std::endl;
		this->window->close();
    }
	
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
PauseScreen::PauseScreen(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
	this->initButtons();
	this->initBackground();
}

/*
 * @brief Destructor.
 * @param 
 */
PauseScreen::~PauseScreen(){
}


/*
	--------	
	Funtions	
	--------
*/

/*
 * @brief Devuelve un bool que dice si esta en pausa.
 * @param 
 * @return bool
 */
bool PauseScreen::stopped() const{
	return this->inPause;
}

/*
 * @brief Loop principal de pause que maneja los eventos del teclado.
 * @param bool& playing 
 * @return void
 */
void PauseScreen::update(bool& playing){
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			//Cierra la ventana de Pause
			case sf::Event::Closed:
				this->inPause = false;
				break;
				
			//Casos de I/O
			case sf::Event::KeyPressed:
				//Escape -> Cierra la ventana de Pause
				if(this->event.key.code == sf::Keyboard::Escape){
					this->inPause = false;
				}
				break;	
				
			case sf::Event::MouseButtonPressed:
                if(this->event.mouseButton.button == sf::Mouse::Left) {
                    sf::Vector2f mousePos = sf::Vector2f(sf::Mouse::getPosition(*this->window).x, sf::Mouse::getPosition(*this->window).y);
					
					//resumeButton -> continua la partida actual
                    if (this->resumeButton.getGlobalBounds().contains(mousePos)) {
						this->inPause = false;
                   
					//exitButton -> se sale de la partida actual y la elimina
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
 * @brief Grafica los elementos de la ventana de GameOver
 * @param 
 * @return void
 */
void PauseScreen::render(){
	// this->window->clear();
	this->window->draw(this->background);
	
    // A White filter
    int whiteFilterOpacity = 7;
    sf::RectangleShape whiteFilter(sf::Vector2f(window->getSize().x, window->getSize().y));
    whiteFilter.setFillColor(sf::Color(255, 255, 255, whiteFilterOpacity));
    this->window->draw(whiteFilter);
	
	//Draw
	this->window->draw(this->resumeButton);
	this->window->draw(this->exitButton);
	
	this->window->display();
}




