//designing the mdr unit - figure 4. this is the memory data register which is different from our GPReg since it has two input 
//sources and two output sources inputs either come from memory unit or from the bus. contents from the bus can be written 
//into the memory or drive the bus

module mdrUnit(
  output[31:0] q,
  input[31:0] busMuxOut, mDataIn, 
  input clk, clr, MDRin, MDRread);
  
//need to feed output from multiplexer into MDR. the multiplexer is used to select between the two inputs. a 2-to-1 MUX is required
wire [31:0] muxOut, mdr_input;

assign mdr_input = (MDRread) ? mDataIn : busMuxOut;

GPReg MDRReg(q, clk, clr, MDRin, mdr_input);

//data is stored in the MDR using the synchronous clock signal and the the MDRin control signal
/*always @(posedge clk)
  if (clr)
    q <= 0;
  else if(MDRin)
    q <= muxOut;
	*/
endmodule
