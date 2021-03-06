//add_op.v, 32-bit ADDITION operation module 

`timescale 1ns/10ps

module add_op (input [31:0] regA, input [31:0] regB, input wire cin, 
	output wire [31:0] sum, output wire cout); 

wire cout1; 

CLA16 CLA1 (.regA(regA[15:0]), .regB(regB[15:0]), .cin(cin), .sum(sum[15:0]), .cout(cout1)); //bottom 16-bits
CLA16 CLA2 (.regA(regA[31:16]), .regB(regB[31:16]), .cin(cout1), .sum(sum[31:16]), .cout(cout)); //top 16-bits

endmodule


//implementing a 4-bit carry lookahead adder, CLA4
module CLA4 (input [3:0] regA, input [3:0] regB, input wire cin, output wire [3:0] sum, output wire cout);

	wire [3:0] prop, gen, carry; 

	assign prop = regA ^ regB;
	assign gen = regA & regB;
	assign carry[0] = cin;
	assign carry[1] = gen[0] | (prop[0] & carry[0]);
	assign carry[2]= gen[1] | (prop[1] & gen[0]) | (prop[1] & prop[0] & carry[0]);
	assign carry[3]= gen[2] | (prop[2] & gen[1]) | (prop[2] & prop[1] & gen[0]) | (prop[2] & prop[1] & prop[0] & carry[0]);
	assign cout = gen[3] | (prop[3]&gen[2]) | (prop[3]&prop[2]&gen[1]) | (prop[3]&prop[2]&prop[1]&gen[0]) | (prop[3]&prop[2]&prop[1]&prop[0]&carry[0]);
	assign sum[3:0] = prop ^ carry;

endmodule
	

//implementing 16-bit carry lookahead adder, CLA16
module CLA16 (input [15:0] regA, input [15:0] regB, input wire cin, output wire [15:0] sum, output wire cout);
wire cout1, cout2, cout3;
//composed of four 4-bit carry lookahead adders implemented above 
CLA4 CLA1 (.regA(regA[3:0]), .regB(regB[3:0]), .cin(cin), .sum(sum[3:0]), .cout(cout1)); 
CLA4 CLA2 (.regA(regA[7:4]), .regB(regB[7:4]), .cin(cin), .sum(sum[7:4]), .cout(cout2));
CLA4 CLA3 (.regA(regA[11:8]), .regB(regB[11:8]), .cin(cin), .sum(sum[11:8]), .cout(cout3));
CLA4 CLA4 (.regA(regA[15:12]), .regB(regB[15:12]), .cin(cin), .sum(sum[15:12]), .cout(cout4));

endmodule
