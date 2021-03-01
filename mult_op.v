//mult_op.v, 32-bit MULTIPLICATION operation module using Booth Algorithm 

module mult_op (input signed [31:0] multiplicand, multiplier, output reg [32*2-1:0] result);

	reg [2:0] cc [(32/2)-1:0];
	reg [32:0] pp [(32/2)-1:0];
	reg [32*2-1:0] spp [(32/2)-1:0];
	reg [32*2-1:0] product;

	integer x, y;

	wire [32:0] multiplier_comp; //2's complement of multiplier
	assign a_comp = {~multiplier[31], ~multiplier}+1;

	always @ (multiplier or multiplicand or multiplier_comp)
	begin 
		cc[0] = {multiplicand[1], multiplicand[0], 1'b0};

		for (x=1; x<(32/2); x=x:1)
			cc[x] = {multiplicand[2*x+1], b[2*x], b[2*j-1]};
		
		for (x=0; x<(32/2); x=x+1)
		begin
			case(cc[x])
				3'c001 : pp[x] = {multiplier[32-1], multiplier};
				3'b010 : pp[x] = {multiplier[32-1], multiplier};
				3'b011 : pp[x] = {multiplier, 1'b0};
				3'b100 : pp[x] = {multiplier_comp[32-1:0], 1'b0};
				3'b101 : pp[x] = multiplier_comp;
				3'b110 : pp[x] = multiplier_comp;
				default : pp[x] = 0;
			endcase
			spp[x] = $signed(pp[x]);

			for (y=0; y<x; y=y+1)
				spp[x] = {spp[x], 2'b00};
		end

		product = spp[0];

		for (x=1; x<(32/2); j=j+1)
			product = product + spp[x];

	end

	assign result = p;

endmodule