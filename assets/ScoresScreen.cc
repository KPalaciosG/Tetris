#include "ScoresScreen.hh"

/*
 * @brief Esta función inicializa todas los atributos de la clase.
 * @param 
 * @return void
 */
void ScoresScreen::initializeVariables(){
	this->window = nullptr;
	this->showingScores = true;
	this->retroFont.loadFromFile("assets/Fonts/ARCADECLASSIC.TTF");
	this->topScores = "";
	
}

/*
 * @brief Hace que la ventana, sea la misma que la del menu, para no crear multiples ventanas.
 * @param sf::RenderWindow*& window
 * @return void
 */
void ScoresScreen::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}


/*
 * @brief Configura el texto que va a mostrar los topScores en pantalla.
 * @param 
 * @return void
 */
void ScoresScreen::initTopScore(){
	//Font
	this->scores.setFont(retroFont);
	//Color
	this->scores.setFillColor(sf::Color::White);
	//Size
	this->scores.setCharacterSize(50);
    //Position
    this->scores.setPosition(350.f, 200.f);
	
	//Font
	this->scoreMsg.setFont(retroFont);
	//Color
	this->scoreMsg.setFillColor(sf::Color::White);
	//Size
	this->scoreMsg.setCharacterSize(50);
    //Position
    this->scoreMsg.setPosition(105.f, 25.f);
}

/*
 * @brief Crea y configura los botones que se muestran en la partida y maneja los errores con las texturas.
		exitButton -> exitButtonTexture
 * @param 
 * @return void
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
 * @brief Crea y configura el fondo que se muestra en la partida.
		background -> backgroundTexture
 * @param 
 * @return void
 */
void ScoresScreen::initBackground(){
	if (!this->backgroundTexture.loadFromFile("assets/Backgrounds/ScoresBackground.jpg")) {
        std::cerr << "Falta imagen de boton fondo" << std::endl;
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
ScoresScreen::ScoresScreen(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
	this->initTopScore();
	this->initBackground();
	this->initButtons();
}


/*
 * @brief Destructor.
 * @param 
 */
ScoresScreen::~ScoresScreen(){
	//delete this->window;
}

/*
	--------	
	Funtions	
	--------
*/


/*
 * @brief Devuelve un bool que dice si esta mostrando los topScores.
 * @param 
 * @return bool
 */
bool ScoresScreen::showing() const{
	return this->showingScores;
}


/*
 * @brief Loop principal de la ventana de scores que maneja los eventos del I/O.
 * @param 
 * @return void
 */
void ScoresScreen::update(){
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			//Cierra la ventana de scores y vuelve al menu
			case sf::Event::Closed:
				this->showingScores = false;
				break;
				
			//Casos de I/O
			case sf::Event::KeyPressed:
				//Cierra la ventana de scores y vuelve al menu
				if(this->event.key.code == sf::Keyboard::Escape){
					this->showingScores = false;
				}
				break;
				
			case sf::Event::MouseButtonPressed:
                if(this->event.mouseButton.button == sf::Mouse::Left) {
                    sf::Vector2f mousePos = sf::Vector2f(sf::Mouse::getPosition(*this->window).x, sf::Mouse::getPosition(*this->window).y);
					
					//exitButton -> Cierra la ventana de scores y vuelve al menu
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


/*
 * @brief Grafica los elementos de la ventana de GameOver
 * @param 
 * @return void
 */
void ScoresScreen::render(){
	this->window->clear();
	
	this->window->draw(this->background);
	this->window->draw(this->exitButton);
	
    this->drawScoreMsg();

	this->drawTopScores();
	
	this->window->display();
}


/*
 * @brief Configura y dibuja el titulo de la ventana
 * @param
 * @return void
 */
void ScoresScreen::drawScoreMsg(){
    //The msg to show
	this->scoreMsg.setString("TOP SCORES!");
	this->window->draw(scoreMsg);
}

/*
 * @brief Configura y dibuja los topScores
 * @param
 * @return void
 */
void ScoresScreen::drawTopScores() {
	this->topScores = readScores();
	this->scores.setString(topScores);
	this->window->draw(scores);
}

/*
* @brief Lee los puntajes guardados en el archivo y los devuelve como 1 solo string.
* @return el string con los puntajes leidos.
*/
std::string ScoresScreen::readScores() {
    std::ifstream scores ("scores.txt");
    std::string theScores = "";
    if (scores.is_open()) {
        std::string line;
        int count = 0;
        while (getline(scores, line)) {
            if (count >= 1) {
                theScores = theScores + "\n" + line;
            } else {
                theScores = line;
            }
            count++;
        }
        scores.close(); 
    }
    return theScores;
}



