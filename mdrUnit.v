//designing the mdr unit - figure 4. this is the memory data register which is different from our GPReg since it has two input sources and two output sources
//inputs either come from memory unit or from the bus. contents from the bus can be written into the memory or drive the bus

module mdr_unit(
  output reg [31:0] q,
  input[31:0] busMuxOut, mDataIn, 
  input clk, clr, MDRin, MDRread);
  
wire [31:0] muxOut; //need to feed output from multiplexer into MDR. the multiplexer is used to select between the two inputs. a 2-to-1 MUX is required
mux_2X1 MDRmux (busMuxOut, mDataIn, MDRread, muxOut); //call mux_2X1

//data is stored in the MDR using the synchronous clock signal and the the MDRin control signal
always @(posedge clk)
  if (clr)
    q <= 0;
  else if(MDRin)
    q <= muxOut;
endmodule
