//or_op_tb.v, testbench for the OR operation module 

`timescale 1ns/10ps

module or_op_tb;

	reg PCout, ZHighout, Zlowout, MDRout, R2out, R4out; 
	reg MARin, Zin, PCin, MDRin, IRin, Yin;
	reg IncPC, Read;
	reg [4:0] OR;
	reg R5in, R2in, R4in; //'OR' changes based on operation we want to test
	reg HIin, LOin, ZHighIn, Cin, ZLowIn;
	reg Clock;
	reg [31:0] Mdatain;
	reg Clear;

	// add any other signals to see in your simulation

	parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
	reg [3:0] Present_state = Default;

	cpu_phase1 DUT(PCout, ZHighout, Zlowout, MDRout, R2out, R4out, MARin, Zin, PCin, MDRin, IRin, Yin, IncPC, Read, OR, R5in, R2in, R4in, Clock, Clear, Mdatain);
	 //the input (in.port) and output (out.port) connects the CPU to the outside world
   //the input (in.port) and output (out.port) connects the CPU to the outside world


	initial
		begin
			Clock = 0;
			forever #10 Clock = ~ Clock; 
	end

	always @(posedge Clock) // finite state machine; if clock rising-edge
		begin
			case(Present_state)

				Default			:	#40 Present_state = Reg_load1a;

				Reg_load1a		:	#40 Present_state = Reg_load1b;

				Reg_load1b		:	#40 Present_state = Reg_load2a;

				Reg_load2a		:	#40 Present_state = Reg_load2b;

				Reg_load2b		:	#40 Present_state = Reg_load3a;

				Reg_load3a		:	#40 Present_state = Reg_load3b;

				Reg_load3b		:	#40 Present_state = T0;

				T0					:	#40 Present_state = T1;

				T1					:	#40 Present_state = T2;

				T2					:	#40 Present_state = T3;

				T3					:	#40 Present_state = T4;

				T4					:	#40 Present_state = T5;



			endcase

		end

	always @ (Present_state) //do the required job in each state
		begin
		PCout = 0; Zlowout = 0; ZHighout = 0;  MDRout= 0;   //initialize the signals
					R2out = 0;   R4out = 0;   MARin = 0;   Zin = 0;  
					PCin =0;   MDRin = 0;   IRin  = 0;   Yin = 0;  
					IncPC = 0;   Read = 0;   OR = 0;
					R5in = 0; R2in = 0; R4in = 0; Mdatain = 32'h00000000;
					Clear = 0;
					
			case(Present_state) //assert the required signals in each clock cycle 
				Default : begin
					PCout <= 0;   Zlowout <= 0; ZHighout <= 0;  MDRout<= 0;   //initialize the signals
					R2out <= 0;   R4out <= 0;   MARin <= 0;   ZLowIn <= 0;  
					PCin <=0;   MDRin <= 0;   IRin  <= 0;   Yin <= 0;  
					IncPC <= 0;   Read <= 0;   OR <= 0;
					R5in <= 0; R2in <= 0; R4in <= 0; Mdatain <= 32'h00000000; Clear = 1;
				end
	
 				Reg_load1a: begin
					Mdatain = 32'h00000022;
					Read = 1; MDRin =1; //the first zero is there for completeness
				end

				Reg_load1b: begin
					 MDRout = 1; R2in = 1;
				end

 				Reg_load2a: begin
					Mdatain = 32'h00000024;
					Read = 1; MDRin = 1;
				end

				Reg_load2b: begin
					MDRout = 1; R4in = 1;
				end

				Reg_load3a: begin
					Mdatain = 32'h00000026;
					Read = 1; MDRin = 1;
				end

				Reg_load3b: begin
					MDRout = 1; R5in = 1;

				end

				T0: begin //see if you need to de-assert these signals
					//Mdatain = 32'h00000007;
					//PCin = 1; MDRout = 1;
					PCout = 1; MARin = 1; IncPC = 1; Zin = 1; 
				end

				T1: begin
					Mdatain = 32'h4A920000;   
					Read = 1; MDRin = 1;
				end

				T2: begin
					MDRin = 1; IRin = 1;
				end

				T3: begin
					R2out = 1; Yin = 1;
				end

				T4: begin
					R4out = 1; OR = 5'b01010; Zin = 1;
				end

				T5: begin
					Zlowout = 1; R5in = 1;
				end

			endcase

		end

endmodule
