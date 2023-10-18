CXX = g++
CXXFLAGS = -no-pie -std=c++11 -Wall -g
LIBS = -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

AS = nasm
ASFLAGS = -f elf64  # Adjust this for your architecture if needed

all: compile

compile: main.cc matriz.o
	$(CXX) $(CXXFLAGS) main.cc matriz.o Game.cc Cerebro.cc ScoresScreen.cc -o ejecutable $(LIBS)

matriz.o: matriz.asm
	$(AS) $(ASFLAGS) matriz.asm -o matriz.o

execute: 
	./ejecutable



