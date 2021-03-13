//multiplexer with 4 inputs and 1 output. Implement this using three 2-to-1 MUX

module mux_4X1(
	output [31:0] out,
	input [31:0] in0, in1, in2, in3, 
	input selectSignal1, selectSignal2);

	wire[31:0] outA, outB;
	mux_2X1 m1(outA, in0, in1, selectSignal1); //MUX in0 and in1 to get outA
	mux_2X1 m2(outB, in2, in3, selectSignal1); //MUX in2 and in3 to get outB
	mux_2X1 m3(out, outA, outB, selectSignal2); //MUX outA and outB to get final out

endmodule