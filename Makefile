CXX = g++
CXXFLAGS = -no-pie -std=c++11 -Wall -g
LIBS = -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

AS = nasm
ASFLAGS = -f elf64  # Adjust this for your architecture if needed

all: compile

compile: assets/main.cc matriz.o nextTetrinomio.o
	$(CXX) $(CXXFLAGS) assets/main.cc MakefileOutputs/matriz.o MakefileOutputs/nextTetrinomio.o assets/Game.cc assets/Cerebro.cc assets/ScoresScreen.cc assets/GameOverScreen.cc assets/PauseScreen.cc -o MakefileOutputs/ejecutable $(LIBS)

matriz.o: assets/matriz.asm
	$(AS) $(ASFLAGS) assets/matriz.asm -o MakefileOutputs/matriz.o
	
nextTetrinomio.o: assets/nextTetrinomio.asm
	$(AS) $(ASFLAGS) assets/nextTetrinomio.asm -o MakefileOutputs/nextTetrinomio.o
	
execute: 
	./MakefileOutputs/ejecutable



