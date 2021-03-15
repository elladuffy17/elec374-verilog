module CONFFBlock(
  input wire clk, 
  input wire d, 
  output reg q, 
  output reg q_not
);	
	initial begin
		q <= 0;
		q_not <= 1;
	end
	
  always@(clk) 
	begin
		q <= d;
		q_not <= !d;
	end

endmodule
