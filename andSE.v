module andSE(a, b, z);
	input [3:0] a;
	input b;
	output [3:0] z;
	
	assign z[0] = b & a[0];
	assign z[1] = b & a[1];
	assign z[2] = b & a[2];
	assign z[3] = b & a[3];
endmodule 
