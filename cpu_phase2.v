/*centralized prcocessing unit for phase 1. as defined in class, the central processing unit (CPU) 
is the electronic circuitry within a computer that carries out the instructions of a computer program 
by performing the basic arithmetic, logical, control and input/output (I/O) operations specified by 
the instructions */

`timescale 1ns/10ps

module cpu_phase2(
  //the input (in.port) and output (out.port) connects the CPU to the outside world
 
   input PCout,
	input ZHighOut,
	input ZLowOut,
	input MDRout,
	input R2Out,
	input R4Out,
	input MARin,
	input Zin,
	input PCin,
	input MDREnable,
	input IRin,
	input Yin,
	input IncPC,
	input MDRread,
   	input [4:0] operation,
	input R5Enable,
	input R2Enable,
	input R4Enable,
	input clk, clr,
	input [31:0] mDataIn,
	input BAout,
	//section 2.5
	input wire [31:0] inPortIn,
	output wire [31:0] inPortOut

 
);
  //for section 2.3
  wire [31:0] busMuxInR0_to_AND;
	
  //define 32-to-5 encoder input/output wires
  wire [31:0] encoderInput;
  wire [4:0] encoderOutput;//select signals for MUX
  
  //define and initialize those 32 input wires for the 32-to-5 encoder
  wire R0Out = 0;
  wire R1Out = 0;
  //wire R2Out = 0;
  wire R3Out = 0;
  //wire R4Out = 0;
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
  wire inPortOut = 0;
  wire Cout = 0;
  wire IROut = 0;
  wire MAROut = 0;
  
  reg clear;
  
  //connect the input wires to the encoder using the concatenation operator
  //assign statement is used since these statements are always active
  //note, {8{1'b0}} is 8 zero bits
  assign encoderInput = {{8{1'b0}}, Cout, inPortOut, MDRout, PCout, ZLowOut, ZHighOut, loOut, hiOut, R15Out,
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
  wire [31:0] busMuxInY;
  wire [31:0] busMuxOutMDR;
  
  wire [31:0] ALUInZHi, ALUInZLo;
	
	//section 2.5 wires
	wire [31:0] busMuxInInport; //output from inport
	
  //enable signals for registers
  wire R1Enable, /*R2Enable,*/ R3Enable, /*R4Enable, R5Enable,*/ R6Enable, R7Enable, R8Enable, R9Enable, 
  R10Enable, R11Enable, R12Enable, R13Enable, R14Enable, R15Enable, hiEnable, loEnable, zHiEnable, 
  zLoEnable, pcEnable, /*MDREnable,*/ inPortEnable, CEnable, InportEnable, OutportEnable; 
  
  wire [31:0] busMuxOut; //feed into registers as the input from the bus
  
  /* Section 2.3 is the revision to the R0 register to support Load and Store instructions */
	//the original output of R0 is ANDED with the Not of BAout
	assign busMuxInR0_to_AND = {32{!BAout}} & busMuxInR0; //is this right?
	GPReg R0(busMuxInR0_to_AND, clk, clr, 1'd0, busMuxOut);
	
  /* design/instantiate the registers*/
  GPReg R1(busMuxInR1, clk, clr, R1Enable, busMuxOut);
  GPReg R2(busMuxInR2, clk, clr, R2Enable, busMuxOut);
  GPReg R3(busMuxInR3, clk, clr, R3Enable, busMuxOut);
  GPReg R4(busMuxInR4, clk, clr, R4Enable, busMuxOut);
  GPReg R5(busMuxInR5, clk, clr, R5Enable, busMuxOut);
  GPReg R6(busMuxInR6, clk, clr, R6Enable, busMuxOut);
  GPReg R7(busMuxInR7, clk, clr, R7Enable, busMuxOut);
  GPReg R8(busMuxInR8, clk, clr, R8Enable, busMuxOut);
  GPReg R9(busMuxInR9, clk, clr, R9Enable, busMuxOut);
  GPReg R10(busMuxInR10, clk, clr, R10Enable, busMuxOut);
  GPReg R11(busMuxInR11, clk, clr, R11Enable, busMuxOut);
  GPReg R12(busMuxInR12, clk, clr, R12Enable, busMuxOut);
  GPReg R13(busMuxInR13, clk, clr, R13Enable, busMuxOut);
  GPReg R14(busMuxInR14, clk, clr, R14Enable, busMuxOut);
  GPReg R15(busMuxInR15, clk, clr, R15Enable, busMuxOut);
  
  GPReg hiReg(busMuxInHi, clk, clr, hiEnable, busMuxOut);
  GPReg loReg(busMuxInLo, clk, clr, loEnable, busMuxOut);
  GPReg zHiReg(busMuxInZHi, clk, clr, Zin, ALUInZHi);
  GPReg zLoReg(busMuxInZLo, clk, clr, Zin, ALUInZLo);
	GPReg pcReg(busMuxInPC, clk, IncPC, pcEnable, busMuxOut); //fix PCReg clear 
  GPReg inPortReg(busMuxInInPort, clk, clr, inPortEnable, busMuxOut);
  GPReg cReg(busMuxInC, clk, clr, CEnable, busMuxOut);
  GPReg Y(busMuxInY, clk, clr, Yin, busMuxOut);
  mdrUnit MDRUnit(busMuxInMDR, busMuxOut, mDataIn, clk, clr, MDREnable, MDRread);
  
  //mux_2X1 MDRmux (busMuxOutMDR, busMuxOut, mDataIn, MDRread);
  //GPReg MDRReg(busMuxInMDR, clk, clr, MDREnable, busMuxOutMDR);
  
  //section 2.5 - input and output ports
	GPReg inputPort(busMuxInInport, clk, clr, InportEnable, inPortIn);
	GPReg outputPort(inPortOut, clk, clr, OutportEnable, busMuxOut);
	
  //now, instantiate the bus
  bus phase1bus(busMuxOut, busMuxInR0, busMuxInR1, busMuxInR2, busMuxInR3, busMuxInR4,
                busMuxInR5, busMuxInR6, busMuxInR7, busMuxInR8, busMuxInR9, busMuxInR10,
                busMuxInR11, busMuxInR12, busMuxInR13, busMuxInR14, busMuxInR15, busMuxInHi,
                busMuxInLo, busMuxInZHi, busMuxInZLo, busMuxInPC, busMuxInMDR, busMuxInInPort,
                busMuxInC, R0Out, R1Out, R2Out, R3Out, R4Out, R5Out, R6Out, R7Out, R8Out, R9Out,
                R10Out, R11Out, R12Out, R13Out, R14Out, R15Out, hiOut, loOut, ZHighOut, ZLowOut, 
                PCout, MDRout, inPortOut, Cout);
  
  //MAR
	MAR_unit MAR(MAROut, MARin, clk, clr, busMuxOut);
	
	//IR
	GPReg IR(IROut, clk, clr, IRin, busMuxOut);
	
	//produce IR logic
	SelectAndEncodeBlock IRLogic(Gra, Grb, Grc, Rin, Rout, BAout, IROut[26:23], IROut[22:19], IROut[18:15], 
				     //confused by this
				     R0Out, R1Out, R2Out, R3Out, R4Out, R5Out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, R0in, R1in, 
		R2in, R3in, R4in, R5in,  R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,C_sign_extended);
	
	//"CONFF" Logic
	conff_logic CONFFLogic (CONout, CONin, IROut, busMuxOut);
  
  //alu
  alu aluPhase1(.regZH(ALUInZHi), .regZL(ALUInZLo), .clock(clk), .clear(clr), .regA(busMuxInY), .regB(busMuxOut), .opcode(operation));
  
  endmodule
  
