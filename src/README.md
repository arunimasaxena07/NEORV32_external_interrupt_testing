# Source Files (`src/`)

## Overview
This folder contains the **VHDL source files** used to implement and verify the NEORV32 RISC-V processor, with special emphasis on **External Interrupt Testing**.

These modules form the hardware foundation for the interrupt handling mechanisms tested in this project.

## Key Components
- **neorv32_top.vhd**  
  The top-level module integrating CPU, memories, peripherals, and interrupt controller.

- **neorv32_cpu.vhd**  
  The main CPU core implementing the RV32I base instruction set and additional extensions.

- **neorv32_xirq.vhd**  
  External interrupt controller module (`XIRQ`) responsible for managing 32 external interrupt channels.

- **Other Modules**  
  Supporting components like clock gating, register files, cache memory, GPIO, UART, and timer peripherals.

## Notes
- The source files are primarily written in **VHDL-93 standard**.
- No major architecture changes were made — customizations mainly targeted simulation and external interrupt verification.
- Some files may have minor edits for easier ModelSim integration.

## Directory Structure
```
src/ ├── neorv32_top.vhd ├── neorv32_cpu.vhd ├── neorv32_xirq.vhd ├── (additional VHDL modules...)

```

## Usage
These VHDL files should be added as **design sources** in the simulation environment (e.g., ModelSim or Vivado)  
before compiling and running the testbenches located in the `/testbenches` folder.

