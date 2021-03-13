//multiplexer with 8 inputs to 1 output. use two 4X1 mux and 1 2X1 mux

module mux_8X1(
  output [31:0] out,
  input [31:0] in0, in1, in2, in3, in4, in5, in6, in7, 
  input selectSignal1, selectSignal2, selectSignal3);

  wire[31:0] outA, outB;
  mux_4X1 M1(outA, in0, in1, in2, in3, selectSignal1, selectSignal2); //use multiplexer to transform the 4 inputs in0, in1, in2, in3 into one output outA
  mux_4X1 M2(outB, in4, in5, in6, in7, selectSignal1, selectSignal2); //use multiplexer to transform the 4 inputs in4, in5, in6, in7 into one output outb
  mux_2X1 M3(out, outA, outB, selectSignal3); //use multiplexer to transform the 2 inputs outA, outB into one output out

endmodule