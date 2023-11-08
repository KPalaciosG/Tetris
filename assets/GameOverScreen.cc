#include "GameOverScreen.hh"

/*
	@return void
	Initializes all the variables of the class
*/
void GameOverScreen::initializeVariables(){
	this->window = nullptr;
	this->inPause = true;
	this->inputActive = true;
	this->retroFont.loadFromFile("assets/Fonts/retro.TTF");
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
	/*std::string gameOverScore = player + " " + std::to_string(score);
	std::cout << gameOverScore;
	checkScores(gameOverScore);*/
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

std::string GameOverScreen::getPlayer(){
	return this->player;
}


