module MAR_unit(
	output reg[8:0] Q,
	input enable, clk, clr,
	input[31:0]D);
	
	always@(posedge clk) begin
	if(clr) begin	
		Q <= 0;
	end else if(enable) begin
		Q <= D[8:0]; //address from IR/PC from BUS --> FIGURE OUT WHAT BITS
	end
	end
endmodule
		