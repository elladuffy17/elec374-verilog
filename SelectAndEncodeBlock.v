// this module will be selecting the proper registers to send to the datapath based on IR
// The BAout (base address) signal, when asserted, gates 0’s onto the bus if R0 is selected ****
module SelectAndEncodeBlock(
	input wire  Gra, Grb, Grc, Rin, Rout, BAout, // signals anded with IR bits + help produce output
	input wire [3:0] Ra, Rb, Rc, // Bits from IR
	output R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, R0in, R1in, 
							  R2in, R3in, R4in, R5in,  R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
	output [31:0] C_sign_extended);
	
							  	  
	// local param to assign to final ports of top level module						  
	wire[3:0] AndAOut, AndBOut, AndCOut; 
	wire[3:0] DecIn; // the 3 4bit outputs to go into OR12
	wire[15:0] DecOut;
	wire BARorOut; // BAout | Rout output wire
	
	// Instantiation of all sub components --> gates + decoder 
	// predecoder selection
	andSE RaAND(Ra, Gra, AndAOut);
	andSE RbAND(Rb, Grb, AndBOut);
	andSE RcAND(Rc, Grc, AndCOut);
	orSE DecORin(AndAOut, AndBOut, AndCOut, DecIn);
	
	// determining other field for RANDOUT gates
	or2t1  RoutOrBAout(BAout, Rout, BARorOut);
	
	// 4->16 decoder
	decoder4t16 IRdecoder(DecIn, DecOut);
	//R0out-R15out & Rin
	and2t1 R0ANDIN(Rin, DecOut[0], R0in);
	and2t1 R1ANDIN(Rin, DecOut[1], R1in);
	and2t1 R2ANDIN(Rin, DecOut[2], R2in);
	and2t1 R3ANDIN(Rin, DecOut[3], R3in);
	and2t1 R4ANDIN(Rin, DecOut[4], R4in);
	and2t1 R5ANDIN(Rin, DecOut[5], R5in);
	and2t1 R6ANDIN(Rin, DecOut[6], R6in);
	and2t1 R7ANDIN(Rin, DecOut[7], R7in);
	and2t1 R8ANDIN(Rin, DecOut[8], R8in);
	and2t1 R9ANDIN(Rin, DecOut[9], R9in);
	and2t1 R10ANDIN(Rin, DecOut[10], R10in);
	and2t1 R11ANDIN(Rin, DecOut[11], R11in);
	and2t1 R12ANDIN(Rin, DecOut[12], R12in);
	and2t1 R13ANDIN(Rin, DecOut[13], R13in);
	and2t1 R14ANDIN(Rin, DecOut[14], R14in);
	and2t1 R15ANDIN(Rin, DecOut[15], R15in);

	//R0out-R15out & BARorOut
	and2t1 R0ANDOUT(BARorOut,DecOut[0], R0out);
	and2t1 R1ANDOUT(BARorOut,DecOut[1], R1out);
	and2t1 R2ANDOUT(BARorOut,DecOut[2], R2out);
	and2t1 R3ANDOUT(BARorOut,DecOut[3], R3out);
	and2t1 R4ANDOUT(BARorOut,DecOut[4], R4out);
	and2t1 R5ANDOUT(BARorOut,DecOut[5], R5out);
	and2t1 R6ANDOUT(BARorOut,DecOut[6], R6out);
	and2t1 R7ANDOUT(BARorOut,DecOut[7], R7out);
	and2t1 R8ANDOUT(BARorOut,DecOut[8], R8out);
	and2t1 R9ANDOUT(BARorOut,DecOut[9], R9out);
	and2t1 R10ANDOUT(BARorOut,DecOut[10], R10out);
	and2t1 R11ANDOUT(BARorOut,DecOut[11], R11out);
	and2t1 R12ANDOUT(BARorOut,DecOut[12], R12out);
	and2t1 R13ANDOUT(BARorOut,DecOut[13], R13out);
	and2t1 R14ANDOUT(BARorOut,DecOut[14], R14out);
	and2t1 R15ANDOUT(BARorOut,DecOut[15], R15out);
	
	// C_sign_extension output
	C_sign_extended CextensionOut(Rc[3], C_sign_extended); //IR bit 18's type determines C_sign_extension output
endmodule
