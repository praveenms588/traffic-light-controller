# Traffic Light Controller (4-Way) Using Vivado

## Overview
This project implements a 4-way traffic light controller using Verilog HDL. The design controls traffic lights for four directions: North, South, East, and West, cycling through green, yellow, and red signals to manage traffic flow safely and efficiently.

The module is intended for FPGA implementation and has been developed and tested using Xilinx Vivado.

---

## Module Description

### Module Name
`traffic_light_controller_4way`

### Ports
| Port Name | Direction | Description                           |
| --------- | --------- | ----------------------------------- |
| `clk`     | Input     | Clock signal                        |
| `rst`     | Input     | Synchronous reset signal            |
| `north`   | Output    | 3-bit output controlling North lights |
| `south`   | Output    | 3-bit output controlling South lights |
| `east`    | Output    | 3-bit output controlling East lights  |
| `west`    | Output    | 3-bit output controlling West lights  |

### Signal Encoding for Traffic Lights
- `3'b001` = Green light
- `3'b010` = Yellow light
- `3'b100` = Red light

---

## Functionality

The controller cycles through the following states:

1. **NS_GREEN:** North and South directions have green lights; East and West have red.
2. **NS_YELLOW:** North and South directions switch to yellow; East and West remain red.
3. **ALL_RED:** All directions have red lights for safety transition.
4. **EW_GREEN:** East and West directions have green lights; North and South have red.
5. **EW_YELLOW:** East and West directions switch to yellow; North and South remain red.
6. Returns to **ALL_RED** and repeats the cycle.

---

## Timing Parameters

| Parameter     | Description          | Value          |
| ------------- | -------------------- | -------------- |
| `TIME_GREEN`  | Duration of green light  | 5,000,000 cycles |
| `TIME_YELLOW` | Duration of yellow light | 2,000,000 cycles |
| `TIME_ALL_RED`| Duration of all red     | 1,000,000 cycles |

*Note: Timing values assume a specific clock frequency (e.g., 50 MHz). Adjust these parameters according to your FPGA clock.*

---

## How to Use

1. **Open Vivado** and create a new project.
2. Add the `traffic_light_controller_4way.v` source file.
3. Instantiate the module in your top-level design.
4. Connect the clock and reset signals accordingly.
5. Map the output signals (`north`, `south`, `east`, `west`) to appropriate FPGA pins connected to LEDs or traffic light simulation hardware.
6. Synthesize, implement, and generate the bitstream.
7. Program your FPGA and observe the traffic light sequencing.

---
