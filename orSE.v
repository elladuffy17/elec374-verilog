module orSE(a, b, c, z); // not sure if modul has to be adjusted based on the fact that 3
	input [3:0] a, b, c;
	output [3:0] z;
	assign z[0] = (a[0]|b[0]|c[0]);  // selecting the appropriate 4-bit fields for Ra, Rb, and Rc in the IR register
	assign z[1] = (a[1]|b[1]|c[1]); 
	assign z[2] = (a[2]|b[2]|c[2]); 
	assign z[3] = (a[3]|b[3]|c[3]); 
endmodule 
