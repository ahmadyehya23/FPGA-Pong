# FPGA Pong

A Pong game implemented in SystemVerilog for FPGA hardware.

## Project Overview

This project implements a basic two-player Pong game using an FPGA.

The design includes:

- VGA video timing
- Ball movement and collision detection
- Player paddle movement
- Score tracking
- VGA rendering
- Clock enable generation
- RTL simulation testbench

## Project Structure

```text
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
└── README.md