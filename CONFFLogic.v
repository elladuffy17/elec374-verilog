module CONFFLogic (
  output CONout,
  input CONin,
  input [1:0] IR,
  input [31:0] bus
);
  
  wire [3:0] decoderOutput;
  
  //C2 Field
	wire equal;
	wire not_equal;
	wire positive;
	wire negative;
	wire branchFlag;
	
  //the contents of C2 Field --00, --01, --10 or --11. Therefore, we are only interested in the first 2 bits
  assign equal 		    = (bus == 32'd0) ? 1'b1 : 1'b0; 
	assign not_equal		= (bus != 32'd0) ? 1'b1 : 1'b0;
	assign positive		  = (bus[31] == 0) ? 1'b1 : 1'b0;
	assign negative 	  = (bus[31] == 1) ? 1'b1 : 1'b0;
	
  decoder2to4 decoder(IR, decoderOutput);
  
  assign branchFlag=(decoderOutput[0]&equal)|(decoderOutput[1]&not_equal)|(decoderOutput[2]&positive)|(decoderOutput[3]&negative);
	
  module logic_block(
    output reg QNot, Q,
    input wire clk, input wire D);	
	
    initial begin
		  Q <= 0;
		  QNot <= 1;
	end
	always@(clk) 
	begin
		Q <= D;
		QNot <= !D;
	end
endmodule
  
  //analyzing the diagram given, CONin is fed into the clock input, branchFlag goes to D and CONout is the output
  logic_block CONFFBlock(CONout, CONin, branchFlag);
