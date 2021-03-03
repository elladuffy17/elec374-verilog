//not_op.v, 32_bit NOT operation module
`timescale 1ns/10ps

module not_op (
	input wire [31:0] regA,
	output wire [31:0] regZ
	);

	genvar j;

	generate
		for (j=0; j<32; j=j+1)
		begin : loop
			assign regZ[j] = !regA[j]; //using the built-in NOT fucntion and putting the result in register Z
		end
	endgenerate

endmodule
