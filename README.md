# Quadcopter Drone Modeling

![Quadcopter Drone Simulation](assets/drone.gif)

This project implements and simulates a quadcopter drone rendering in an OpenGL environment. The drone can be controlled manually or set to automatically follow a pre-defined curved path over a generated 3D landscape.

## Dependencies

To compile and run this project, the following dependencies are required:
* **g++** compiler
* **OpenGL** and related libraries:
  * [GLFW](https://www.glfw.org/) (Window creation, input parsing)
  * [GLM](https://glm.g-truc.net/) (Mathematics library for graphics)
  * [Assimp](https://github.com/assimp/assimp) (Asset Import Library)
  * [Eigen](https://eigen.tuxfamily.org) (Linear algebra)
* **GLAD** is included within the repository structure.

*Note: Ensure the library paths in the `Makefile` match your local development environment's include (`-I`) and library (`-L`) paths.*

## Compilation

The project comes with a `Makefile` that builds the main executable. To compile the project, run:

```bash
make compile
```

This will link `main.cpp`, `glad/glad.o`, and other dependencies, and output an executable named `draw`.

## Execution Instructions

You can run the executable directly or use the `Makefile`'s run command.

### Using Make

```bash
make run
```
By default, `make run` will execute `./draw 800 600 0`.

### Command Line Options

The `draw` executable accepts three mandatory arguments:

```bash
./draw [WIDTH] [HEIGHT] [MODE]
```

* **`WIDTH`**: The width of the two generated rendering windows (e.g., `800`).
* **`HEIGHT`**: The height of the rendering windows (e.g., `600`).
* **`MODE`**: The execution mode of the simulation.
  * `0`: **Manual Mode**. The simulation allows for manual control over the drone's movements (`processInput`).
  * `1` (or any non-zero value): **Simulation Mode**. The drone autonomously follows a pre-defined path using simulated curve traversal (`simulateDrone`).

## Technical Details

The simulation implements several graphics core concepts, including hierarchical 3D modelling and parametric curves.

### Hierarchical Drone Model

The drone is constructed using a scene graph approach (represented by the `Model` class). 

* **Scene Graph Structure**: The drone model is built hierarchically from primitive 3D shapes (such as cuboids, cylinders, and toruses). 
* **Component Relationships**: The drone consists of a body. Attached to the body are four arms, and each arm features a fan cover and rotating fan blades.
* **Transformations**: Transformations (scaling, translation, rotation) applied to parent nodes (like the body) naturally propagate down to children (like the arms and blades). 

To visualize this hierarchy, refer to the model diagram:

<iframe src="assets/Model.pdf" width="100%" height="600px"></iframe>

### Path and Motion along Curves

When operating in Simulation Mode (`MODE=1`), the quadcopter follows an intricate Bezier/Spline path smoothly.

* **Curve Evaluation**: The path is composed of multiple segments of cubic curves (managed by the `Curve` and `Path` classes). The simulation incrementally evaluates the curve at parameter `t` to determine the drone's position in 3D space (`currentPos`).
* **Orientation via Tangents**: The curve's tangent gives the primary direction of the drone's movement. By finding the cross product between the old and new tangents, the program calculates the correct axis polynomial and angle over which to rotate the hierarchical model, allowing it to realistically tilt and bank into corners.

To understand the mathematics and logic behind the curve motion, refer to the motion diagram:

<iframe src="assets/Motion.pdf" width="100%" height="600px"></iframe>
