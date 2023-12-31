# Weight Stationary Systolic Array Implementation

This project implements a 16x16 weight stationary systolic array for matrix multiplication in Verilog HDL.

## Project Files
**MAC.v** - MAC unit implementation

**ROW.v** - Row unit with 16 MACs

**MMU.v** - Top level 16x16 systolic array

**RTL_testbench.v** - Testbench for RTL simulation

**Synthesis_testbench.v** - Testbench for gate-level simulation

## Modules
The systolic array design consists of the following modules:

**MAC** - The MAC unit performs the multiplication and accumulation operations.

**ROW** - The ROW unit contains 16 MAC units connected in series to replicate a row of the systolic array. 

**MMU** - The MMU is the top-level module containing 16 ROW units to create the full 16x16 systolic array.

## Simulation
The design was validated through:

- RTL simulation using a testbench to verify correct matrix multiplication results.

- Gate-level post-synthesis simulation using a separate testbench due to differences in how multidimensional arrays are represented.

## Scalability 
The design is easily scalable to larger sizes like 256x256 by modifying the 'size' parameter. Generate blocks in Verilog can be used to instantiate the repetitive structures.
