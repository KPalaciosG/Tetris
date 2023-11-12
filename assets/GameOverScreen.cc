#include "GameOverScreen.hh"

/*
 * @brief Esta función inicializa todas los atributos de la clase.
 * @param 
 * @return void
 */
void GameOverScreen::initializeVariables(){
	this->window = nullptr;
	this->inPause = true;
	this->inputActive = true;
	this->retroFont.loadFromFile("assets/Fonts/ARCADECLASSIC.TTF");
}


/*
 * @brief Hace que la ventana, sea la misma que la de la partida, para no crear multiples ventanas.
 * @param sf::RenderWindow*& window
 * @return void
 */
void GameOverScreen::initWindow(sf::RenderWindow*& window){
	this->window = window;	
}

/*
 * @brief Configura el texto que va a mostrar el game over en la pantalla.
 * @param 
 * @return void
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
 * @brief Crea y configura el fondo que se muestra en la partida.
		background -> backgroundTexture
 * @param 
 * @return void
 */
void GameOverScreen::initBackground(){
	if (!this->backgroundTexture.loadFromFile("assets/Backgrounds/GameOverBackground.png")) {
        std::cerr << "Falta imagen de background de GameOver" << std::endl;
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
GameOverScreen::GameOverScreen(sf::RenderWindow*& window){
	this->initializeVariables();
	this->initWindow(window);
	this->initBackground();
	this->initText();
}

/*
 * @brief Destructor.
 * @param 
 */
GameOverScreen::~GameOverScreen(){
}



/*
	--------	
	Funtions	
	--------
*/

/*
 * @brief Devuelve un bool que dice si esta mostrando el GameOver.
 * @param 
 * @return bool
 */
bool GameOverScreen::stopped() const{
	return this->inPause;
}

/*
 * @brief Loop principal del GameOver que maneja los eventos del I/O.
 * @param 
 * @return void
 */
void GameOverScreen::update(){
	while(this->window->pollEvent(this->event)){
		switch(this->event.type){
			//Cierra la ventana de GameOver
			case sf::Event::Closed:
				this->inPause = false;
				
				break;
				
			//Casos de Teclado
			case sf::Event::KeyPressed:
				//Escape -> cierra la ventana de GameOver
				if(this->event.key.code == sf::Keyboard::Escape){
					this->inPause = false;
				}
				//Enter -> Deshabilita la entrada por teclado, es decir, ya se introdujo el nombre 
				else if(this->event.key.code == sf::Keyboard::Enter){
					this->inputActive = false;
				}
				
				break;	
			//Caso de entrada de teclas alfa-numericas
			case sf::Event::TextEntered:
				//Mientras que la entrada de texto este activa, y sea un caracter valido, permite escribir
				if (inputActive && event.text.unicode < 128){
					//Verifica si es un espacio
					if (event.text.unicode == 8){
						if (!player.empty()){
							player.pop_back();
						}
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
 * @brief Grafica los elementos de la ventana de GameOver
 * @param int score
 * @return void
 */
void GameOverScreen::render(int score){

	// this->window->clear();
	this->window->draw(this->background);

    // A red filter
    int redFilterOpacity = 5;
    sf::RectangleShape redFilter(sf::Vector2f(window->getSize().x, window->getSize().y));
    redFilter.setFillColor(sf::Color(106, 41, 70, redFilterOpacity));
    this->window->draw(redFilter);
	
	//Draw
	this->drawText(score);
	this->window->display();
}

/*
 * @brief Los textos que se muestran en la pantalla de GameOver
		  Primero muestra un texto que indica al jugador que digite su nombre	
		  Segundo las instrucciones para salir
 * @param int score
 * @return void
 */
void GameOverScreen::drawText(int score){
	//Si aun no ha terminado de escribir, pide su nombre y muestra el nombre que ha escrito hasta el momento
	//Esta capacidad de escribir se termina cuando presiona enter
	if(inputActive){
		this->text.setString("ENTER YOUR NAME: \n" + player + "\nPRESS ENTER WHEN YOU'RE DONE\n" );
	}
	//Si ya termino de escribir su nombre, le muestra el nombre que digito y su score
	else{
		this->text.setString(player + "\nYOUR SCORE: " + std::to_string(score) + "\nPRESS ESC TO EXIT\n" );
	}
	
	this->window->draw(text);
}

/**
 * @brief Recibe un puntaje junto al nombre de usuario y verifica si el puntaje
 * es suficientemente alto para remplazar a alguno en caso de que hayan otros
 * puntajes en el archivo de puntajes.
*/
void GameOverScreen::checkScores(std::string score_p) {
    std::ifstream scores ("scores.txt");
    std::vector<std::string> scoresV;
    if (scores.is_open()) {
        std::string line;
        while (getline(scores, line)) {
            scoresV.push_back(line);
        }
        scores.close();
        //std::cout << "Hay " << scoresV.size() << " scores en el vector" << std::endl;
    }
    if (scoresV.size() != 0) {
        std::regex numberRegex("\\d+"); // Busca numeros en string
        std::smatch match;
        std::vector<int64_t> numScores;
        for (int64_t i = 0; i < (int64_t)scoresV.size(); i++) {
            // regex guarda los numeros en su posicion correspondiente del vector numScores
            std::regex_search(scoresV[i], match, numberRegex);
            std::string matchString = match.str();
            numScores.push_back(std::stoi(matchString));
        }
        // mete el valor del parametro en el vector
        std::regex_search(score_p, match, numberRegex);
        std::string matchString = match.str();
        numScores.push_back(std::stoi(matchString));
        // mete el valor del parametro de una en el vector de scores
        scoresV.push_back(score_p);
        // para ordenar los scores
        for (int64_t i = 0; i < (int64_t)scoresV.size(); i++) {
            int64_t posMayor = i;
            for (int64_t j = i; j < (int64_t)scoresV.size(); j++) {
                if (numScores[j] > numScores[posMayor]) {
                    posMayor = j;
                }
            }
            std::string temp = scoresV[i];
            scoresV[i] = scoresV[posMayor];
            scoresV[posMayor] = temp;
            int64_t tempScore = numScores[i];
            numScores[i] = numScores[posMayor];
            numScores[posMayor] = tempScore;
        }
    } else if (scoresV.size() == 0) {
        scoresV.push_back(score_p);
        for (int64_t i = 0; i < (int64_t)scoresV.size(); i++) {
            //std::cout << scoresV[i] << std::endl;
        }
    }
    writeScores(scoresV);
}

void GameOverScreen::writeScores(std::vector<std::string> scores) {
    // abre archivo para sobreescribir los valores guardados en el archivo.
    std::ofstream outputFile("scores.txt", std::ios::trunc);

    if (outputFile.is_open()) {
        // Write new data to the file
        if (scores.size() <= 3) {
            for (int64_t i = 0; i < (int64_t)scores.size(); i++) {
                if (i == (int64_t)scores.size() - 1) {
                    outputFile << scores[i];
                } else {
                    outputFile << scores[i] << "\n";
                }
            }
        } else {
            for (int64_t i = 0; i < 3; i++) {
                if (i == 2) {
                    outputFile << scores[i];
                } else {
                    outputFile << scores[i] << "\n";
                }
            }
        }
        outputFile.close();
    }
}

/*
 * @brief Retorna el nombre del jugador almacenado
 * @param 
 * @return std::string
 */
std::string GameOverScreen::getPlayer(){
	return this->player;
}


