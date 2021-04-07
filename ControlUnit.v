/*
FOUR PRINCIPLE SOURCES :
1- The op-code fieldsof the IR
2- Signals from the Datapath such as CONFF,and the condition code registers 
3- Control step information such as signals T0, T1, ...
4- External inputs such as Stop, Reset, Done (if memory is slow), andother signals such as interrupts
*/

// TO check-> neg/not/mul/div/ldi 

`timescale 1ns/10ps

module control_unit(
						 output reg PCout, MDRout, ZHighOut, ZLowOut, HiOut, LoOut, Rin, Rout, Gra, Grb, Grc,  
										BAout, Cout, MDRin, MARin, Zin, Yin, IRin, PCin, CONin, LoIn, HiIn,
										ADD, SUB, MUL, DIV, AND, OR, NEG, NOT, SHR, SHL, ROR, ROL,
										Write, Read, InPortOut, OutPortIn, Run, Clear, 
										
						 // output  // Other inputs and control signals --> FIND ENABLES****
						 
						 output [3:0] ALUOpCode,
										
						 input[31:0] IR,
						 input 		Clock, Reset, Stop, Interrupts, Con_FF);
						 
						 parameter 	Reset_state= 7'b0000000, fetch0= 7'b0000001, fetch1= 7'b0000010, fetch2= 7'b0000011, // ****MADE STATE 5bits to fit the 75 different sub states in Ti-Tend -> 4bits only hold 16 -> do we need 2^7 = 128 spots??
										add3= 7'b0000100, add4= 7'b0000101, add5= 7'b0000110, sub4= 7'b0000111, sub5= 7'b0001000, shr3= 7'b0001001, shr4= 7'b0001010, shr5= 7'b0001011, shl3= 7'b0001100, 
										shl4= 7'b0001101, shl5= 7'b0001110, ror3= 7'b0001111, ror4= 7'b0010000, ror5= 7'b0010001, rol3= 7'b0010010, rol4= 7'b0010011, rol5= 7'b0010100, and3= 7'b0010101, 
										and4= 7'b0010110, and5= 7'b0010111, or3= 7'b0011000, or4= 7'b0011001, or5= 7'b0011010, mult3= 7'b0011011, mult4= 7'b001110, mult5= 7'b0011111, mult6= 7'b0100000, 
										div3= 7'b0100001, div4= 7'b0100010, div5= 7'b0100011, div6= 7'b0100100, neg3= 7'b0100101, neg4= 7'b0100110, neg5= 7'b0100111 , not3= 7'b0101000, not4= 7'b0101001, 
										not5 = 7'b0101010,ld3= 7'b0101011, ld4= 7'b0101100, ld5= 7'b0101101, ld6= 7'b0101110, ld7= 7'b0101111, ldi3= 7'b0110000, ldi4= 7'b0110001, ldi5= 7'b0110010, st3= 7'b0110011,
										st4= 7'b0110101 , st5= 7'b0110110, st6= 7'b0110111, st7= 7'b0111000, addi3= 7'b0111001, addi4= 7'b0111010, addi5= 7'b0111011, andi3= 7'b0111100, andi4= 7'b0111101, 
										andi5= 7'b0111110, ori3= 7'b0111111, ori4= 7'b1000000, ori5= 7'b1000001, branch3= 7'b1000010, branch4= 7'b1000011, branch5= 7'b1000100, branch6= 7'b1000101, jr3= 7'b1000110, 
										jr4= 7'b1000111, jal3= 7'b1001000, jal4= 7'b1001001, mfhi3= 7'b1001010, mflo3= 7'b1001100, in3= 7'b1001101, out3= 7'b1001110, halt= 7'b1001111, nop= 7'b1010000;
										
										
						 reg [6:0] 	Present_state = Reset_state;
						 
						always@(posedgeClock, posedge Reset)	
							begin
								if(Reset == 1'b1) Present_state =  Reset_state;
								else if(Stop == 1'b1) Present_State = halt; // STOP SHOULD HAVE SAME EFFECT AS HALT STATE -> SO JUST SET IT TO THAT STATE IF BIT ACTIVE
								else case(Present_state)
								Reset_state		:		Present_state = fetch0;
								fetch0			:		Present_state = fetch1;
								fetch1			:		Present_state = fetch2;
								fetch2			:		begin 
																case(IR[31:27])   //THIS PICKS T3operation --> THEN BASED ON THAT OPERATION Ti-Tend are executed sequentially based on case state???****
																		5'b00011:Present_state = add3;
																		5'b00100:Present_state = sub3;
																		5'b00101:Present_state = shr3;
																		5'b00110:Present_state = shl3;
																		5'b00111:Present_state = ror3; 
																		5'b01000:Present_state = rol3;
																		5'b01001:Present_state = and3;
																		5'b01010:Present_state = or3;
																		5'b01110:Present_state = mult3; 
																		5'b01111:Present_state = div3;
																		5'b10000:Present_state = neg3;							
																		5'b10001:Present_state = not3;
																		5'b00000:Present_state = ld3; 
																		5'b00001:Present_state = ldi3;
																		5'b00010:Present_state = st3;
																		5'b01011: Present_state = addi3;
																		5'b01100:Present_state = andi3; 
																		5'b01101:Present_state = ori3;
																		5'b00101:Present_state = branch3;
																		5'b10011: Present_state = jr3;
																		5'b10100:Present_state = jal3; 
																		5'b10111:Present_state = mfhi3;
																		5'b11000:Present_state = mflo3;
																		5'b10110: Present_state = out3;
																		5'b10101: Present_state = in3;
																		5'b11100: Present_state = halt; // THAT THE RIGHT BIT PATTERN FOR HALT???
	
																endcase
															end
								add3				:		Present_state = add4;
								add4				: 		Present_state = add5;
								add5				: 		Present_state = fetch0; // IS THIS CORRECT?? DO WE ASSIGN STATE TO NEXT INSTRUCTION FETCH??
								
								sub3				: 		Present_state = sub4;
								sub4				: 		Present_state = sub5;
								sub5				: 		Present_state = fetch0;
								
								shr3				: 		Present_state = shr4;
								shr4				: 		Present_state = shr5;
								shr5				: 		Present_state = fetch0;
									
								shl3 				: 		Present_state = shl4;
								shl4 				: 		Present_state = shl5;
								shl5 				: 		Present_state = fetch0;
								
								ror3 				: 		Present_state = ror4;
								ror4 				: 		Present_state = ror5;
								ror5 				: 		Present_state = fetch0;
								
								rol3 				: 		Present_state = rol4;
								rol4 				: 		Present_state = rol5;
								rol5 				: 		Present_state = fetch0;
								
								and3 				: 		Present_state = and4;
								and4 				: 		Present_state = and5;
								and5 				: 		Present_state = fetch0;
								
								or3 				: 		Present_state = or4;
								or4 				: 		Present_state = or5;
								or5 				: 		Present_state = fetch0;
								
								
								mult3 			: 		Present_state = mult4;
								mult4 			: 		Present_state = mult5;
								mult5 			: 		Present_state = mult6;
								mult6 			: 		Present_state = fetch0;
								
								div3 				: 		Present_state = div4;
								div4 				: 		Present_state = div5;
								div5 				: 		Present_state = div6;
								div6 				: 		Present_state = fetch0;
								
								neg3 				: 		Present_state = neg4;
								neg4 				: 		Present_state = neg5;
								neg5				:		Present_state = fetch0;
								
								not3 				: 		Present_state = not4;
								not4 				: 		Present_state = not5;
								not5				:		Present_state = fetch0;
								
								ld3 				: 		Present_state = ld4;
								ld4 				: 		Present_state = ld5;
								ld5 				: 		Present_state = ld6;
								ld6 				: 		Present_state = ld7;
								ld7 				: 		Present_state = fetch0;
								
								ldi3 				: 		Present_state = ldi4;
								ldi4 				: 		Present_state = ldi5;
								ldi5 				: 		Present_state = ldi6;
								ldi6 				: 		Present_state = ldi7;
								ldi7 				: 		Present_state = fetch0;
								
								st3 				: 		Present_state = st4;
								st4 				: 		Present_state = st5;
								st5 				: 		Present_state = st6;
								st6 				: 		Present_state = st7;
								st7 				: 		Present_state = fetch0;
								
								
								addi3 			: 		Present_state = addi4;
								addi4 			: 		Present_state = addi5;
								addi5 			: 		Present_state = fetch0;
								
								andi3 			: 		Present_state = andi4;
								andi4 			: 		Present_state = andi5;
								andi5 			: 		Present_state = fetch0;
								
								ori3 				: 		Present_state = ori4;
								ori4 				: 		Present_state = ori5;
								ori5 				: 		Present_state = fetch0;
								
							
								branch3 			: 		Present_state = branch4;
								branch4 			: 		Present_state = branch5;
								branch5 			: 		Present_state = branch6;
								branch6 			: 		Present_state = fetch0;
								
								jr3 				: 		Present_state =  jr4;
								jr4 				: 		Present_state = fetch0;
								
								jal3 				: 		Present_state = jal4;
								jal4 				: 		Present_state = fetch0;
								
								mfhi3 			: 		Present_state = fetch0;
								
								mflo3 			: 		Present_state = fetch0;
								
								out3 				: 		Present_state = fetch0;
								
								in3 				: 		Present_state = fetch0;
								
								halt 				: 		Present_state = fetch0;  //NOT SURE ABOUT THIS CASE ****
								
								nop 				: 		Present_state = fetch0;  

								endcase
							end
						always@(Present_state)
							begin
									PCout <=0; MDRout <=0; ZLowOut <=0; HiOut <=0; LoOut <=0; Rin <=0; Rout <=0; Gra <=0; Grb  <=0; Grc <=0;  // This way all signals are initialized to 0 before any proceeding operations
									BAout <=0; Cout <=0; Out_portIn  <=0; MDRin <=0; MARin <=0; Zin <=0; Yin <=0; IRin <=0; PCin <=0; CONin <=0; 
									LoIn <=0; HiIn <=0; ADD <=0; SUB <=0; MUL <=0; DIV <=0; AND <=0; OR <=0; NEG <=0; NOT <=0; SHR <=0; SHL <=0; 
									ROR <=0; ROL <=0; Write <=0; Read <=0; In_portOut <=0; Run <=1 ; Clear <=0; // SHOULD RUN BE SET TO 1 HERE TO RE-ENABLE THE GPRegs --> then set to 0 in reset/halt state????
									
								case(Present_state)       
									Reset_state: begin
													PCout <=0; MDRout <=0; ZLowOut <=0; HiOut <=0; LoOut <=0; Rin <=0; Rout <=0; Gra <=0; Grb  <=0; Grc <=0;  
													BAout <=0; Cout <=0; Out_portIn  <=0; MDRin <=0; MARin <=0; Zin <=0; Yin <=0; IRin <=0; PCin <=0; CONin <=0; 
													LoIn <=0; HiIn <=0; ADD <=0; SUB <=0; MUL <=0; DIV <=0; AND <=0; OR <=0; NEG <=0; NOT <=0; SHR <=0; SHL <=0; 
													ROR <=0; ROL <=0; Write <=0; Read <=0; In_portOut <=0; Run <=1 ; Clear <=0;
									end
//******************************************
									fetch0: begin 
											  PCout<= 1; 
											  MARin <= 1;  
											  IncPC <= 1; 
											  Zin <= 1; 
									end
									fetch1: begin
											  ZLowout <= 1;
											  PCin <= 1;
											  Read <= 1;
											  MDRin <= 1;							
									end
									fetch2: begin
											  MRRout <= 1;
											  IRin <= 1;
									end
//******************************************									
									add3: begin
												Grb <= 1; 
												Rout<= 1;  
												Yin <= 1; 
									end
									add4: begin
											Rout <= 1;
											Grc <= 1;
											ALUOpCode <= 5'b00011; // this will be sent to ALU and it will decode to determine OP
											Zin <= 1;
									end
									add5: begin
											ZlowOut <= 1;
											Rin <= 1;
											Gra <= 1;
									end
//******************************************
									sub3: begin
											Rout <= 1;
											Grb <= 1;
											Yin <= 1;
									end
									sub4: begin
											Rout <= 1;
											Grc <= 1;
											ALUOpCode <= 5'b00100;
											Zin <= 1;
									end
									sub5: begin
											ZlowOut <= 1;
											Rin <= 1;
											Gra <= 1;
									end
//******************************************
									shr3: begin
											Rout <= 1;
											Grb <= 1;
											Yin <= 1;
									end
									shr4: begin
											Rout <= 1;
											Grc <= 1;
											ALUOpCode <= 5'b00101 ;
											Zin <= 1;
									end
									shr5: begin
											ZlowOut <=1;
											Rin <= 1;
											Gra <= 1;
									end
//******************************************
									shl3: begin
											Rout <= 1;
											Grb <= 1;
											Yin <= 1;
									end
									shl4: begin
											Rout <= 1;
											Grc <= 1;
											ALUOpCode <= 5'b00110 ;
											Zin <= 1;
									end
									shl5: begin
											ZlowOut <=1;
											Rin <= 1;
											Gra <= 1;
									end
//******************************************									
									ror3: begin
											Rout <= 1;
											Grb <= 1;
											Yin <= 1;
									end
									ror4: begin
											Rout <= 1;
											Grc <= 1;
											ALUOpCode <= 5'b00111 ;
											Zin <= 1;
									end
									ror5: begin
											ZlowOut <=1;
											Rin <= 1;
											Gra <= 1;
									end
//******************************************											
									rol3: begin
											Rout <= 1;
											Grb <= 1;
											Yin <= 1;
									end
									rol4: begin
											Rout <= 1;
											Grc <= 1;
											ALUOpCode <= 5'b01000 ;
											Zin <= 1;
									end
									rol5: begin
											ZlowOut <=1;
											Rin <= 1;
											Gra <= 1;
									end
//******************************************	
									and3: begin
											Rout <= 1;
											Grb <= 1;
											Yin <= 1;
									end
									and4: begin
											Rout <= 1;
											Grc <= 1;
											ALUOpCode <= 5'b01000 ;
											Zin <= 1;
									end
									and5: begin
											ZlowOut <=1;
											Rin <= 1;
											Gra <= 1;
									end
//******************************************										
									or3: begin
										  Rout <= 1;
										  Grb <= 1;
										  Yin <= 1;
									end
									or4: begin
										  Rout <= 1;
										  Grc <= 1;
										  ALUOpCode <= 5'b01010 ;
									     Zin <= 1;
									end
									or5: begin
										  ZlowOut <=1;
										  Rin <= 1;
										  Gra <= 1;
									end
//******************************************	
									mult3: begin
											 Rout <= 1;
										    Gra <= 1;
										    Yin <= 1;
									end
									mult4: begin
										    Rout <= 1;
										    Grb <= 1;
										    ALUOpCode <= 5'b01110 ;
									       Zin <= 1;	
									end
									mult5: begin
											 ZlowOut <= 1;
											 LoIn <= 1;
									end
									mult6: begin
											 ZhighOut <= 1; // IS THIS CORRECT ORDERING ???
											 HiOut <= 1;
									
									end
//******************************************	
									div3: begin
											Rout <= 1;
										   Gra <= 1;
										   Yin <= 1;
									end
									div4: begin
											Rout <= 1;
										   Grb <= 1;
										   ALUOpCode <= 5'b01111 ;
									      Zin <= 1;
									end
									div5: begin
											ZlowOut <= 1;
											LoIn <= 1;
									end
									div6: begin
											ZhighOut <= 1; // IS THIS CORRECT ORDERING ???
											HiOut <= 1;
									end
//******************************************	
									neg3: begin
									      Rout <= 1;
										   Grb <= 1;
										   Yin <= 1;
									end
									neg4: begin
											Rout <= 1;
										   Grc <= 1;
											ALUOpCode <= 5'b10000;
										   Zin <= 1;
									end
									neg5: begin   // OUR NEG_TB has T5 --> DO WE EVEN NEED IT THOUGH?? B IS OUTPUTED FROM BUS -> CHANGED NEG -> STORED IN A -> based off CPU spec doc
											ZlowOut <= 1;
											Gra <= 1;
											Rin <= 1;
									end
//******************************************	
									not3: begin
									      Rout <= 1;
											Grb <= 1;
											Yin <= 1;
									not4: begin
											Rout <= 1;
										   Grb <= 1;
											ALUOpCode <= 5'b10001;
										   Zin <= 1;
									end
									not5: begin  // SAME QUESTION AS NEG4 ^
											ZlowOut <= 1;
											Gra <= 1;
											Rin <= 1;
									end
//******************************************	
									ld3: begin
										  BAout <= 1;
										  Grb <= 1;
										  Yin <= 1;
									end
									ld4: begin
										  Cout <= 1; 
										  ALUOpCode <= 5'b00011; 
										  Zin <= 1;
									end
									ld5: begin
										  ZLowOut <= 1; 
										  MARin <= 1;
									end
									ld6: begin
										  MDRread <= 1; 
										  MDRin <= 1;  
									end
									ld7: begin
									     MDRout <= 1; 
										  Gra <= 1; 
										  Rin <= 1;
									end
//******************************************	
									ldi3: begin
									      Grb <= 1; 
											BAout <= 1; 
											Yin <= 1;
									end
									ldi4: begin
									      Cout <= 1; 
											ALUOpCode <= 5'b00011; 
											Zin <= 1;
									end
									ldi5: begin
											ZLowOut <= 1; 
											Gra <= 1; 
											Rin <= 1;
									end
//******************************************	
									st3: begin
									     Grb <= 1; 
										  BAout <= 1; 
										  Yin <= 1;
									end
									st4: begin
									     Cout <= 1; 
										  ALUOpCode <= 5'b00011; 
										  Zin <= 1;
									end
									st5: begin
									     ZLowOut <= 1; MARin <= 1;
									end
									st6: begin
									     MDRread <= 0; 
										  MDRin <= 1; 
										  Gra <= 1; 
										  Rout <= 1;  
									end
									st7: begin
									     MDRout <= 1; 
										  Gra <= 0; 
										  Rin <= 0; 
										  MDRin <= 0;
										  W_sig <= 1;
									end
//******************************************	
									addi3: begin
									       Grb <= 1; 
											 BAout <= 1; 
											 Yin <= 1;
									end
									addi4: begin
									       Cout <= 1; 
											 ALUOpCode <= 5'b00011; // add
											 Zin <= 1;
									end
									addi5: begin
									       ZLowOut <= 1; 
											 Gra <= 1; 
											 Rin <= 1;
									end
//******************************************	
									andi3: begin
									       Grb <= 1; 
											 BAout <= 1; 
											 Yin <= 1;
									end
									andi4: begin
									       Cout <= 1; 
											 ALUOpCode <= 5'b01001; // and
											 Zin <= 1;
									end
									andi5: begin
									       ZLowOut <= 1; 
											 Gra <= 1; 
											 Rin <= 1;
									end
//******************************************	
									ori3: begin
									      Grb <= 1; 
											BAout <= 1; 
											Yin <= 1;
									end
									ori4: begin
									      Cout <= 1; 
											ALUOpCode <= 5'b01010; 
											Zin <= 1;
									end
									ori5: begin
									      ZLowOut <= 1; 
											Gra <= 1; 
											Rin <= 1;
									end
//******************************************	
									branch3: begin
									         Gra <= 1; 
												Rout <= 1; 
												CONin <= 1; 
												BAout <= 1;
									end
									branch4: begin
									         PCout <= 1; 
												Zin <= 1;
									end
									branch5: begin               // IS BRANCH 5/6 NEEDED?  --> ADD THEM TO PARAM LIST
									         Cout <= 1; 
												ALUOpCode <= 5'b00011; 
												Yin <= 1;
									end
									branch6: begin
									         if (CONin == 1) begin
													ZLowOut <= 1; PCin <= 0; 
												end
									end
//******************************************	
									jr3: begin
									     Gra <= 1; 
										  Rout <= 1; 
										  PCin <= 1;
									end
//******************************************	// NO JR4/JAL4
									jal3: begin
									      Gra <= 1; 
											PCin <= 1; 
											Rout <= 0;
									end
//******************************************	
									mfhi3: begin
									       Gra <= 1; 
											 Rin <= 1; 
											 LOout <= 1;
									end
//******************************************	
									mflo3: begin
									       Gra <= 1; 
											 Rin <= 1; 
											 HIout <= 1;
									end
//******************************************	
									out3: begin
											Gra <= 1;
											Rout <= 1;
											OutPortIn <= 1;
									end
//******************************************	
									in3: begin
									     Gra <= 1; 
										  Rin <= 1; 
										  InportOut <= 1;
									end
//******************************************	
									halt: begin
											run <= 0;
									end
//******************************************	
									nop: begin
									
									end
								end
			endcase
		end
endmodule


