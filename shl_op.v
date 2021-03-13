//shl_op.v, 32-bit SHIFT LEFT operation module
`timescale 1ns/10ps

module shl_op (
	input wire [31:0] data_in,
	input wire [31:0] numOfShifts,
	output wire [31:0] data_out
);
	//shifts the input data the given number of shifts to the left and the result is set to data_out, logical shift fills shift with zeros
	assign data_out[31:0] = data_in << numOfShifts; 

endmodule