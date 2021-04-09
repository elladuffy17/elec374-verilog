`timescale 1ns/10ps

module phase3_tb;
	reg clk, rst, stop;
	wire[31:0] InPort_input, OutPort_output, bus_contents;
	wire [4:0] operation;

cpu_phase3 DUT(
	.clock(clk),
  	.Reset(Reset),
  	.Stop(Stop),
  	.InPort_input(InPort_input), //idk about these
 	.OutPort_output(OutPort_output), //idk about these
	.bus_contents(bus_contents),
	.operation(operation)
);

initial
	begin
		clk = 0;
		Reset = 0;
end

always
		#10 clk <= ~clk;

endmodule
