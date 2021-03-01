//multiplexer with 4 inputs and 1 output. Implement this using three 2-to-1 MUX

module mux4X1(
	input [31:0] in0, in1, in2, in3 
	input selectSignal1, selectSignal2, 
	output reg [31:0] out);

	wire[31:0] outA, outB;
	MUX_2X1 M1(in0, in1, selectSignal1, outA); //MUX in0 and in1 to get outA
	MUX_2X1 M2(in2, in3, selectSignal1, outB); //MUX in2 and in3 to get outB
	MUX_2X1 M3(outA, outB, selectSignal2, out); //MUX outA and outB to get final out

endmodule
 
