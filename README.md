# 32BIT_SINGLE-STAGE_RISC-V_PROCESSOR
THIS  IS A VERILOG CODE FOR A 32BIT SINGLE STAGE RV PROCESSSOR that supports the implementation of the following subset of RV32I instruction set:
a. R-Type: add, sub, and, or
b. I-Type: addi, andi, ori, lw, jalr
c. B-Type: beq, bne
d. J-Type: jal
e. S-Type: sw
Here the top module is divided into two main modules:
1.datapath 
2. control logic. 
AND The Instruction and Data memories are connected to the top module in the testbench.
/*********************************************************************/
FOR TESTING THIS DESIGN :
I used Venus to generate the machine code for a Fibonacci sequence program as an example to check my design. 
I have Simulated the processor to calculate the 6th Fibonacci number thatequal to 8.
