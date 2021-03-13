//div_op.v, 32-bit DIVISION operation module

`timescale 1ns/10ps

module div_op (input signed [31:0] divisor, dividend, output reg [32*2-1:0] result);

	reg [63:32] hi, lo; //splits the output reg quotient into two sections from 0:31 bits and 32:64 bits
	always @ (*) //'*' indicates all variables are considered in sensitivity list, behaves like combinational logic 
	begin
		hi = dividend % divisor;
		lo = (dividend - hi) / divisor;
		
		begin
			result = {hi, lo};
		end

	end

endmodule