//div_op.v, 32-bit DIVISION operation module

module div_op (input signed [31:0] divisor, dividend, output reg [32*2-1:0] quotient);

	reg [63:32] top, bottom; //splits the output reg quotient into two sections from 0:31 bits and 32:64 bits
	always @ (*) //'*' indicates all variables are considered in sensitivity list, behaves like combinational logic 
	begin
		top = dividend % divisor;
		bottom = (dividend - top) / divisor;
		
		begin
			quotient = {top, bottom};
		end

	end

endmodule

