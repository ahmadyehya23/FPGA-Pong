FPGA Pong

A two-player Pong game implemented in SystemVerilog for FPGA hardware, featuring VGA video output, real-time ball and paddle movement, collision detection, scoring, and RTL simulation.

Overview

This project implements the core hardware logic required to run a Pong game on an FPGA.

The design generates VGA timing and graphics while a dedicated game engine controls the ball, paddles, collisions, and score.

The project was developed and verified using Intel Quartus Prime and Questa Altera Starter FPGA Edition.

Features
Two-player Pong game logic
VGA 640×480 video timing
Real-time ball movement
Ball-to-wall collision detection
Ball-to-paddle collision detection
Independent left and right paddle controls
Score tracking
Hardware clock-enable generation
VGA graphics renderer
SystemVerilog RTL
Dedicated RTL simulation testbench
Architecture

The design is divided into several SystemVerilog modules:

pong_engine.sv

Implements the main game logic:

Ball position and movement
Paddle positions
Paddle movement
Wall collisions
Paddle collisions
Score updates
Ball reset after scoring
vga_controller.sv

Generates the VGA timing signals and pixel coordinates for a 640×480 display.

It produces:

Horizontal synchronization
Vertical synchronization
Pixel X/Y coordinates
Video-active signal
renderer.sv

Converts the game state into RGB pixel data.

The renderer draws:

Ball
Left paddle
Right paddle
Background
clock_enable.sv

Generates a slower game-update enable signal from the FPGA's 50 MHz clock.

This allows the game logic to update at a suitable rate while the VGA system continues operating from the main clock.

top.sv

Connects the individual modules together and forms the top-level FPGA design.

Project Structure
FPGA-Pong/
├── rtl/
│   ├── clock_enable.sv
│   ├── pong_engine.sv
│   ├── renderer.sv
│   ├── top.sv
│   └── vga_controller.sv
├── simulation/
│   └── pong_tb.sv
├── .gitignore
├── FPGA-Pong.qpf
├── FPGA-Pong.qsf
├── FPGA-Pong_description.txt
└── README.md
Development Tools
SystemVerilog
Intel Quartus Prime
Questa Altera Starter FPGA Edition
GitHub
VS Code
Target Hardware

The Quartus project is configured for the MAX 10 FPGA used by the Terasic DE10-Lite development board.

FPGA device:

10M50DAF484C7G

Verification

The design was verified using RTL simulation in Questa.

The simulation testbench exercises:

Reset behavior
Ball movement
Paddle movement
Ball/wall interaction
Scoring behavior

The complete FPGA design was also compiled in Intel Quartus Prime with:

0 compilation errors

Simulation

The testbench is located at:

simulation/pong_tb.sv

The Pong engine is simulated independently so that game behavior can be verified without requiring physical FPGA hardware.

Engineering Concepts Demonstrated

This project demonstrates practical FPGA and digital-design concepts including:

Synchronous sequential logic
SystemVerilog RTL design
Finite-state-style game control
Clock enables
VGA timing
Pixel-based rendering
Collision detection
Hardware counters
Parameterized game dimensions
Modular RTL architecture
RTL simulation and waveform analysis
FPGA synthesis and compilation
Future Improvements

Potential extensions include:

VGA-rendered score display
Center court divider
Improved collision physics
Game-over/win condition
Seven-segment score output
Additional player controls
Physical DE10-Lite hardware testing
Improved graphics and game effects