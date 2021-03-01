`timescale 1ns/10ps

module mux_2X1(
	input [31:0] in0, in1, 
	input selectSignal, 
	output reg [31:0] out);

  //multiplexer is used to switch one of the several input lines to a single common output line
	always@(*) //continuous loop
	begin
		if (selectSignal == 1)
			out[31:0] <= in1[31:0];
		else
			out[31:0] <= in0[31:0];
		end
	endmodule
 
