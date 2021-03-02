/*centralized prcocessing unit for phase 1. as defined in class, the central processing unit (CPU) 
is the electronic circuitry within a computer that carries out the instructions of a computer program 
by performing the basic arithmetic, logical, control and input/output (I/O) operations specified by 
the instructions */

`timescale 1ns/10ps

module cpuPhase1(
  //the input (in.port) and output (out.port) connects the CPU to the outside world
  output wire [31:0] inPortOut,
  input wire [31:0] inPortIn,
  input wire clk, clr, mDataIn);
  
  
  /* design/instantiate the registers RO to R15, PC, IR, Y, Z, MAR, HI and LO */
  
  GPReg R1(clk, clr, R1In, busMuxOut)
  
