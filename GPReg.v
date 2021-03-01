`timescale 1ns/10ps //specifies the time unit and precision for the module

//module created to outline figure 2 - the GP register
module reg_32_bits(
	input wire clk, //synchronous clock signal
	input wire clr, //used to reset the registers to a known state
	input wire enable, //control signal that allows the data from the bus to be written onto the register
	input wire [31:0] d, //the input to the register coming from the bus
	output reg [31:0] q //allows the contents of register to be placed on the bus
);
	
  //synchronous clear & active high
	always@(posedge clk) 
	begin
		if (clr) begin
			q[31:0] = 32'b0; //blocking assignment: variable is assigned immediately before continuing to next statement 
		end
		else if(enable) begin
			q[31:0] = d[31:0];
		end 
	end
endmodule
