`timescale 1 ns/10 ps

module SelectAndEncodeBlock_tb;
	reg Gratb, Grbtb, Grctb, Rintb, Routtb, BAouttb;
	reg [3:0] Ratb, Rbtb, Rctb; // The Inputs --> initialized as regs to assign values
	
	wire R0outtb, R1outtb, R2outtb, R3outtb, R4outtb, R5outtb, R6outtb, R7outtb, R8outtb, R9outtb, R10outtb, R11outtb, R12outtb, R13outtb, R14outtb, 
			 R15outtb, R0intb, R1intb, R2intb, R3intb, R4intb, R5intb,  R6intb, R7intb, R8intb, R9intb, R10intb, R11intb, R12intb, R13intb, R14intb, R15intb, C_sign_out; // assigned as wires to display output

	initial
		begin
		// Signals from control unit
			Gratb = 1; // should set whatever R# high --> #  based on val in A/B/C high REG
			Grbtb = 0; 
			Grctb = 0;
			Rintb = 0; 
			Routtb = 1;
			BAouttb = 0;
		// Signals from IR
			Ratb = 4'b1100;
			Rbtb = 4'b0000 ;
			Rctb = 4'b0000 ;
			#70;
			Gratb = 0;
			Grbtb = 0; 
			Grctb = 1;
			Rintb = 1; 
			Routtb = 0;
			BAouttb = 0;
			Ratb = 4'b0000;
			Rbtb = 4'b0000 ;
			Rctb = 4'b1111 ;
			#30
			Rintb = 0; 
			Routtb = 1;
			BAouttb = 1;
		end
	SelectAndEncodeBlock SEB(.Gra(Gratb), .Grb(Grbtb), .Grc(Grctb), .Rin(Rintb), .Rout(Routtb), .BAout(BAouttb), .Ra(Ratb), .Rb(Rbtb), .Rc(Rctb), .R0out(R0outtb), .R1out(R1outtb), .R2out(R2outtb), .R3out(R3outtb), .R4out(R4outtb), .R5out(R5outtb), 
							  .R6out(R6outtb), .R7out(R7outtb), .R8out(R8outtb), .R9out(R9outtb), .R10out(R10outtb), .R11out(R11outtb), .R12out(R12outtb), .R13out(R13outtb), .R14out(R14outtb), .R15out(R15outtb), .R0in(R0intb), .R1in(R1intb), 
							  .R2in(R2intb), .R3in(R3intb), .R4in(R4intb), .R5in(R5intb),  .R6in(R6intb), .R7in(R7intb), .R8in(R8intb), .R9in(R9intb), .R10in(R10intb), .R11in(R11intb), .R12in(R12intb), .R13in(R13intb), .R14in(R14intb), .R15in(R15intb), .C_sign_extended(C_sign_out));
endmodule 
