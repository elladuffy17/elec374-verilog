/*sub_op.v, 32-bit SUBTRACTION operation module*/
`timescale 1ns/10ps

module sub_op (input [31:0] regA, input [31:0] regB, input wire cin, 
	output wire [31:0] difference, output wire cout); 

	wire [31:0] temp; //holds temporary value

	neg_op neg(.regA(regB), .regZ(temp));
	add_op add(.regA(regA), .regB(temp), .cin(cin), .sum(difference), .cout(cout));

endmodule
