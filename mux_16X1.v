/*multiplexer with 16 inputs and 1 output. use two 8-to-1 mux and one 2-to-1 mux.*/

module mux_16X1(
  output [31:0] out,
  input [31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15,
  input selectSignal1, selectSignal2, selectSignal3, selectSignal4);
  
  wire[31:0] outA, outB;
  mux_8X1 m1 (outA, in0, in1, in2, in3, in4, in5, in6, in7, selectSignal1, selectSignal2, selectSignal3);
  mux_8X1 m2 (outB, in8, in9, in10, in11, in12, in13, in14, selectSignal1, selectSignal2, selectSignal3);
  mux_2X1 m3 (out, outA, outB, selectSignal4);
  
endmodule