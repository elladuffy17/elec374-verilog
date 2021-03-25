module MemSubSystem(Clock, Clear, MARin, MDRin, W_sig, MDRread, BusMuxOut, BusMuxInMDROutput);
	input Clock, Clear, MARin, MDRin, W_sig, MDRread;
	input[31:0] BusMuxOut;
	output[31:0] BusMuxInMDROutput;
	//reg[31:0] BusMuxInMDROutput;//This signal represents the output of MDR onto bus
	

	wire [31:0] mdrQ; // output of mdr to data/bus
	wire[8:0] Address;
	wire [31:0] RamQ; // What is outputted from RAM into MUX
	
	mdrUnit MDR_MS(
		.q(mdrQ),
		.busMuxOut(BusMuxOut), .mDataIn(RamQ), 
		.clk(Clock), .clr(Clear), .MDRin(MDRin), .MDRread(MDRread)); // with megafunction RAM is technically always asserting a read to output value
		
	RAM RAM_inst(
		.address(Address),
		.clock(Clock),
		.data(mdrQ),
		.wren(W_sig),
		.q(RamQ));

	MAR_unit MAR_MS(
		.Q(Address),
		.enable(MARin), .clk(Clock), .clr(Clear),
		.D(BusMuxOut));
		
	assign BusMuxInMDROutput = mdrQ; // this ensures that the output signal on the bus always changes when MDR output onto it changes
	
endmodule
