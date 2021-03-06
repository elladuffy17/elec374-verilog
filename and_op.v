//and_op.v, 32-bit AND operation module 

`timescale 1ns/10ps

module and_op(
	input wire [31:0] regA,
	input wire [31:0] regB,
	output wire [31:0] regZ
);

	genvar j; //initializing generate variable for AND loop below
	
	generate

		for (j=0; j<32; j=j+1) //goes through bits 0 to 31, 32-bits 
		begin : loop
			assign regZ[j] = ((regA[j]) & (regB[j])); //utilize the built-in AND operation and assign the result to register Z
		end

	endgenerate

endmodule
