CXX = g++
CXXFLAGS = -no-pie -std=c++11 -Wall -g
LIBS = -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio

AS = nasm
ASFLAGS = -f elf64  # Adjust this for your architecture if needed

all: compile

compile: assets/main.cc matriz.o
	$(CXX) $(CXXFLAGS) assets/main.cc MakefileOutputs/matriz.o assets/Game.cc assets/Cerebro.cc assets/ScoresScreen.cc -o MakefileOutputs/ejecutable $(LIBS)

matriz.o: assets/matriz.asm
	$(AS) $(ASFLAGS) assets/matriz.asm -o MakefileOutputs/matriz.o

execute: 
	./MakefileOutputs/ejecutable



