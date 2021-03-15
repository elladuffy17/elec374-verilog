module MDR_unit(
  output reg [31:0] q,
  input[31:0] busMuxOutMDR, mDataIn, 
  input clk, clr, MDRin, MDRread);
  
//need to feed output from multiplexer into MDR. the multiplexer is used to select between the two inputs. a 2-to-1 MUX is required
	wire [31:0] muxOut;
	mux_2X1 MDRmux (busMuxOutMDR, mDataIn, MDRread, muxOut); //call mux_2X1

//data is stored in the MDR using the synchronous clock signal and the the MDRin control signal
	always @(posedge clk)
		if (clr) 
			q <= 32'b0;
		else if(MDRin) 
			q <= muxOut;
endmodule
