/*finally we have our 32-to-1 mux to be used in the bus
this multiplexer has 32 inputs and 1 output. we use two 16-to-1 mux and one 2-to1 mux*/

module mux_32X1(
  output[31:0] out,
  input [31:0] in0, in1, in2, in3, in4, in5, in6, in7,
  input [31:0] in8, in9, in10, in11, in12, in13, in14, in15,
  input [31:0] in16, in17, in18, in19, in20, in21, in22, in23,
  input [31:0] in24, in25, in26, in28, in29, in30, in31,
  input selectSignal1, selectSignal2, selectSignal3, selectSignal4, selectSignal5);
  
  wire [31:0] outA, outB;
  mux_16X1 M1 (outA, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, selectSignal1, selectSignal2, selectSignal3, selectSignal4);
  mux_16X1 M2 (outB, in16, in17, in18, in18, in19, in20, in21, in22, in23, in24, in25, in26, in28, in29, in30, in31, selectSignal1, selectSignal2, selectSignal3, selectSignal4);
  mux_2X1 M3 (out, outA, outB, selectSignal5);
  
endmodule