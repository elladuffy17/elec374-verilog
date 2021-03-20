//ld_op_tb.v, testbench for the LOAD INSTRUCTION

`timescale 1ns/10ps
module ld_op_tb;
	reg PCout, ZHighOut, ZLowOut, MDRout;
	reg MARin, Zin, PCin, MDRin, IRin, Yin;
	reg IncPC, Read;
	reg [4:0] LD;
	reg HIin, LOin, ZHighIn, Cin, ZLowIn;
	reg Clock;
	reg [31:0] Mdatain;
	reg Clear;
	reg BAout;
	reg Gra, Grb, Grc;
	reg Cout;
	reg MDREnable, MDRread, W_sig;
	reg Rin, Rout, hiEnable, loEnable, pcEnable, inPortEnable, CEnable, CONout, CONin, MAR_enable;
	wire BusMuxOut, BusMuxInMDROutput;
	wire R0Out, R1Out, R2Out, R3Out, R4Out, R5Out, R6Out, R7Out, R8Out, R9Out, R10Out, R11Out, R12Out, R13Out, R14Out, R15Out, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, C_sign_extended;
	parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
	reg [3:0] Present_state = Default;
	
	cpu_phase2 DUT(.PCout(PCout), .ZHighOut(ZHighOut), .ZLowOut(ZLowOut), .MDRout(MDRout), .R2Out(R2Out), .R4Out(R4Out), .MARin(MARin), 
	.Zin(Zin), .PCin(PCin), .MDREnable(MDREnable), .IRin(IRin), .Yin(Yin), .IncPC(IncPC), .MDRread(MDRread), .operation(LD), .clk(Clock),
	.clr(Clear), .BAout(BAout), .Gra(Gra), .Grb(Grb), .Grc(Grc), .MDRin(MDRin), .W_sig(W_sig),
	.BusMuxOut(BusMuxOut), .BusMuxInMDROutput(BusMuxInMDROutput), .Rin(Rin), .Rout(Rout), .hiEnable(hiEnable), .loEnable(loEnable), .pcEnable(pcEnable), .inPortEnable(inPortEnable), .CEnable(CEnable), .CONout(CONout), .CONin(CONin), .MAR_enable(MAR_enable)); 
	
	initial
		begin
			Clock = 0;
			forever #10 Clock = ~ Clock; 
	end

	always @(posedge Clock) // finite state machine; if clock rising-edge
		begin
			case(Present_state)
				Default			:	#40 Present_state = T0;
				T0					:	#40 Present_state = T1;
				T1					:	#40 Present_state = T2;
				T2					:	#40 Present_state = T3;
				T3					:	#40 Present_state = T4;
				T4					:	#40 Present_state = T5;
				T5					: 	#40 Present_state = T6;
				T6					: 	#40 Present_state = T7;
			endcase
		end

	always @ (Present_state) //do the required job in each state
		begin
			PCout <= 0; ZLowOut <= 0; ZHighOut <= 0;  MDRout <= 0;
			MARin <= 0;   Zin <= 0;  PCin <= 0;   MDRin <= 0; IRin <= 0;  
			Yin <= 0;  IncPC <= 0;   Read <= 0; LD <= 0;  Clear <= 0;
			Gra <= 0; Grb <= 0; MDRin <= 0;
					
			case(Present_state) //assert the required signals in each clock cycle 
			
				Default : begin
					PCout <= 0;   ZLowOut <= 0; ZHighOut <= 0;  MDRout<= 0;   //initialize the signals
				   MARin <= 0;   ZLowIn <= 0; PCin <=0;   MDRin <= 0;   
					IRin  <= 0;   Yin <= 0; IncPC <= 0;   Read <= 0; LD <= 0;
					Clear = 1;
				end
				T0: begin
					PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1; 
				end
				T1: begin
					ZLowOut <= 1; PCin <= 1; Read = 1; MDRin <= 1;
				end
				T2: begin
					MDRout <= 1; IRin <= 1;
				end
				T3: begin
					Grb <= 1; BAout <= 1; Yin <= 1;
				end
				T4: begin
					Cout <= 1; LD <= 5'b0000; Zin <= 1;
				end
				T5: begin
					ZLowOut <= 1; MARin <= 1;
				end
				T6: begin
					Read <= 1; MDRin <= 1;  
				end
				T7: begin
					MDRout <= 1; Gra <= 1; Rin <= 1;
				end
			endcase
		end
endmodule

