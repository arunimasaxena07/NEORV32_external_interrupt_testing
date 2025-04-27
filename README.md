# External Interrupt Testing on NEORV32

## Project Overview
This project focuses on **testing and verifying external interrupt handling** in the NEORV32 RISC-V processor architecture.  
We developed a **custom simulation environment using ModelSim** and targeted the **External Interrupt Controller (XIRQ)** module.  
Three major test scenarios were designed: 
- General interrupt validation (level-triggered)
- Edge case with elevated operand magnitudes
- Rising edge-triggered interrupt response

> **Note:**  
> This project initially began as a **course project** at the University of California, Davis.  
> After further development, we decided to publish the work on GitHub.  
> As a result, there is no detailed commit history from the early development stages.

## Repository Structure
external_interrupt_testing/ ├── src/# Source VHDL files (NEORV32 modules and any custom modifications) ├── testbenches/ # VHDL-based testbenches for ModelSim simulation ├── docs/ # Project abstract, paper, and related documentation ├── README.md # Project overview and instructions (this file)


## Experimental Setup
- **Processor**: NEORV32 RISC-V (version 9.8)
- **Simulation Tool**: ModelSim by Altera (Intel FPGA)
- **Core Focus**: Testing the `XIRQ` external interrupt controller with 32 independent channels
- **Languages Used**: VHDL (for NEORV32 modules and for testbenches)
- **Verification Strategy**:  
  - Edge case stimulation  
  - High operand magnitude testing  
  - Rising edge sensitivity validation  

Testbenches were carefully crafted to simulate real-world external interrupts using GPIO-driven triggers.

## Key Test Scenarios

| Test Case                        | Purpose                                                     | Trigger Type         | Result |
|----------------------------------|--------------------------------------------------------------|-----------------------|--------|
| **Test Case 1: General Interrupt** | Basic interrupt acknowledgment and validation               | Level-triggered       | Correct ISR execution |
| **Test Case 2: Edge Case**         | Testing with high-magnitude operand values                  | Level-triggered       | No overflow, correct execution |
| **Test Case 3: Rising Edge-Triggered** | Temporal sensitivity validation (0 → 1 transition)         | Rising edge-triggered | Proper detection without false triggers |

> Full details are available in the `docs/Testing_External_Interrupts_in_the_NEORV32_RISC_V_Processor.pdf`.

## How to Simulate
1. **Launch ModelSim**.
2. **Import** the VHDL design files from `src/` as libraries.
3. **Add** the VHDL testbenches from `testbenches/`.
4. **Compile** both VHDL and Verilog sources (mixed-language setup).
5. **Run simulations** according to the desired test case.
6. **Analyze waveforms** for:
   - Interrupt acknowledgment
   - Correct operand processing
   - Timing behavior of rising edge detection

## Future Work
As outlined in our paper:
- Expand testing to additional NEORV32 modules (`neorv32_xirq.vhd`, `neorv32_processor.vhd`, etc.)
- Use GTKWave for advanced waveform analysis
- Simulate electrical noise and glitch filtering
- Introduce nested and masked interrupt scenarios
- Perform Hardware-in-the-Loop (HIL) validation on FPGA boards

## Authors
- Arunima Saxena
- Arindam Bhattacharyya
- Lilian Molina
- Savita Patil
- Hussain Al-Asaad

University of California, Davis  
Course Project — Embedded Systems Architecture and Design

## License
This project is made available for educational purposes.

---
