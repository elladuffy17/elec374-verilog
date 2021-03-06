//neg_op.v, 32-bit NEGATION operation module
`timescale 1ns/10ps

module neg_op (
	input wire [31:0] regA,
	input wire [31:0] regB,
	output wire [31:0] regZ
);

	wire [31:0] temp; //holds temporary value
	wire cout; //holds carryout value 

	not_op not_op(.regA(regA), .regZ(temp));
	add_op add_op(.regA(temp), .regB(32'd1), .cin(1'd0), .sum(Rz), .cout(cout));

endmodule
