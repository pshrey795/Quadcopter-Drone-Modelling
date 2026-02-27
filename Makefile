CC=g++
CFLAGS = -I/opt/homebrew/Cellar/eigen/5.0.0/include/ -I/opt/homebrew/Cellar/glfw/3.4/include/ -I/opt/homebrew/Cellar/glm/1.0.2/include/ -I/opt/homebrew/Cellar/assimp/6.0.2/include/ -L/opt/homebrew/lib -lglfw -ldl -lassimp
WIDTH = 800
HEIGHT = 600
MODE = 0

compile: main.cpp shader.hpp
	$(CC) -o draw main.cpp glad/glad.o $(CFLAGS) 

run: draw
	./draw $(WIDTH) $(HEIGHT) $(MODE)

clean:
	rm -f draw