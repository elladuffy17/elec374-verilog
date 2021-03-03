/*centralized prcocessing unit for phase 1. as defined in class, the central processing unit (CPU) 
is the electronic circuitry within a computer that carries out the instructions of a computer program 
by performing the basic arithmetic, logical, control and input/output (I/O) operations specified by 
the instructions */

`timescale 1ns/10ps

module cpuPhase1(
  //the input (in.port) and output (out.port) connects the CPU to the outside world
  output wire [31:0] inPortOut,
  input wire [31:0] inPortIn,
  input wire clk, clr, mDataIn,
);
  
  //define 32-to-5 encoder input/output wires
  wire [31:0] encoderInput;
  wire [4:0] encoderOutput;//select signals for MUX
  
  //define and initialize those 32 input wires for the 32-to-5 encoder
  wire R0Out = 0;
  wire R1Out = 0;
  wire R2Out = 0;
  wire R3Out = 0;
  wire R4Out = 0;
  wire R5Out = 0;
  wire R6Out = 0;
  wire R7Out = 0;
  wire R8Out = 0;
  wire R9Out = 0;
  wire R10Out = 0;
  wire R11Out = 0;
  wire R12Out = 0;
  wire R13Out = 0;
  wire R14Out = 0;
  wire R15Out = 0;
  wire hiOut = 0;
  wire loOut = 0;
  wire zHighOut = 0;
  wire zLoOut = 0;
  wire pcOut = 0;
  wire MDRout = 0;
  wire inPortOut = 0;
  wire Cout = 0;
  
  //connect the input wires to the encoder using the concatenation operator
  //assign statement is used since these statements are always active
  //note, {8{1'b0}} is 8 zero bits
  assign encoderInput = {{8{1'b0}}, Cout, inPortOut, MDRout, pcOut, zLoOut, zHighOut, loOut, hiOut, R15Out,
                         R14Out, R13Out, R12Out, R11Out, R10Out, R9Out, R8Out, R7Out, R6Out, R5Out, 
                         R4Out, R3Out, R2Out, R1Out, R0Out};
  
  //instantiate bus encoder
  encoder busEncoder(encoderOutput, encoderInput);
  
  //inputs to the bus MUX (from our registers, output q)
  wire [31:0] busMuxInR0;
  wire [31:0] busMuxInR1;
  wire [31:0] busMuxInR2;
  wire [31:0] busMuxInR3;
  wire [31:0] busMuxInR4;
  wire [31:0] busMuxInR5;
  wire [31:0] busMuxInR6;
  wire [31:0] busMuxInR7;
  wire [31:0] busMuxInR8;
  wire [31:0] busMuxInR9;
  wire [31:0] busMuxInR10;
  wire [31:0] busMuxInR11;
  wire [31:0] busMuxInR12;
  wire [31:0] busMuxInR13;
  wire [31:0] busMuxInR14;
  wire [31:0] busMuxInR15;
  wire [31:0] busMuxInHi;
  wire [31:0] busMuxInLo;
  wire [31:0] busMuxInZHi;
  wire [31:0] busMuxInZLo;
  wire [31:0] busMuxInPC;
  wire [31:0] busMuxInMDR;
  wire [31:0] busMuxInInPort;
  wire [31:0] busMuxInC;
  
  /* design/instantiate the registers RO to R15, PC, IR, Y, Z, MAR, HI and LO.
  first, we want to enable signals for registers*/
  wire R1Enable, R2Enable, R3Enable, R4Enable, R5Enable, R6Enable, R7Enable, R8Enable, R9Enable, 
  R10Enable, R11Enable, R12Enable, R13Enable, R14Enable, R15Enable, hiEnable, loEnable, zHighEnable, 
  zLowEnable, pcEnable, MDREnable, inPortEnable, CEnable; 
  
  wire [31:0] busMuxOut; //feed into registers as the input from the bus
  
  GPReg R1(clk, clr, R1In, busMuxOut)
  
