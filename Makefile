CXX = g++
CXXFLAGS = -std=c++11 -Wall
LIBS = -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

all: compile

compile: main.cc
	$(CXX) $(CXXFLAGS) main.cc Game.cc Cerebro.cc ScoresScreen.cc -o ejecutable $(LIBS)

execute: 
	./ejecutable



