module C_sign_extended(a, z);
input a;
output reg [31:0] z;

always @(*) begin 
	if(a==1) begin
		 z = 32'b1111_1111_1111_1111_1111_1111_1111_1111;
	end else begin	
		z = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
	end
end
endmodule 