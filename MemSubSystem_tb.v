`timescale 1 ns/10 ps

module MemSubSystem_tb;
	reg Clocktb, Cleartb, MARintb, MDRintb, W_sigtb;
	reg[31:0] BusMuxOuttb;
	wire[31:0] BusMuxInMDROutputtb;
	

MemSubSystem MSblock(Clocktb, Cleartb, MARintb, MDRintb, W_sigtb, BusMuxOuttb, BusMuxInMDROutputtb);
	initial
		begin
		Clocktb = 1;
		Cleartb = 0; 
		MARintb = 1; 
		MDRintb = 0;
		W_sigtb = 0; 
		BusMuxOuttb = 32'b0; 
		#50;
		Clocktb = 1;
		Cleartb = 0; 
		MARintb = 1; 
		MDRintb = 1;
		W_sigtb = 1; 
		BusMuxOuttb = 32'b0; 
	end
endmodule
