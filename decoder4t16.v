// based on 0-15 output R0-R15 is selected
module decoder4t16(a, z);
	input [3:0] a;
	output [15:0] z;
	parameter tempParam = 16'b0000_0000_0000_0001; // parameter is a type that allows it to be reused with diff specification (new vals)
	assign z = (a == 4'b0000) ? tempParam   :
               (a == 4'b0001) ? tempParam<<1: 
               (a == 4'b0010) ? tempParam<<2:
               (a == 4'b0011) ? tempParam<<3:
               (a == 4'b0100) ? tempParam<<4:
               (a == 4'b0101) ? tempParam<<5:
               (a == 4'b0110) ? tempParam<<6:
               (a == 4'b0111) ? tempParam<<7:
               (a == 4'b1000) ? tempParam<<8:
               (a == 4'b1001) ? tempParam<<9:
               (a == 4'b1010) ? tempParam<<10:
               (a == 4'b1011) ? tempParam<<11:
               (a == 4'b1100) ? tempParam<<12:
               (a == 4'b1101) ? tempParam<<13:
               (a == 4'b1110) ? tempParam<<14:
               (a == 4'b1111) ? tempParam<<15: 16'bxxxx_xxxx_xxxx_xxxx;
endmodule 