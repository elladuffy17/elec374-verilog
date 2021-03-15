//decoder file

module decoder2to4(
  //from figure 7 it looks like there is just one input and 4 possible outputs
  input wire [1:0] decoderInput, 
  output reg [3:0] decoderOutput
);
	always@(*) begin
		case(decoderInput)
         		4'b00 : decoderOutput <= 4'b0001;    
       		 	4'b01 : decoderOutput <= 4'b0010;    
         		4'b10 : decoderOutput <= 4'b0100;    
         		4'b11 : decoderOutput <= 4'b1000;    
      		endcase
   	end
endmodule
