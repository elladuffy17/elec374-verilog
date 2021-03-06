/* here we implement the typical bus. we implement the bus using a 32-to-5 encoder and a 32-to-1 mux. note, the mux was created using
a combination of smaller multiplxers. the five select signal inputs for this multiplexer come from our 32-to-5 encoder */

module bus(
  output [31:0] busMuxOut,
  input [31:0] R0In, R1In, R2In, R3In, R4In, R5In, R6In, R7In, R8In, R9In, R10In, 
  R11In, R12In, R13In, R14In, R15In, hiIn, loIn, zHighIn, zLoIn, pcIn, MDRin,
  inPortIn, C_sign_extended,
  input R0Out, R1Out, R2Out, R3Out, R4Out, R5Out, R6Out, R7Out,
  R8Out, R9Out, R10Out, R11Out, R12Out, R13Out, R14Out, R15Out, hiOut, loOut,
  zHighOut, zLoOut, pcOut, MDRout, inPortOut, Cout);
  
  /* in the lab instructions, it says that the signals to the 32-to-5 encoder are simulated in phase 1. the lab instructions state that
  the idea is to choose only one of the registers R0 to R15, HI, LO, Zhigh,Zlow, PC, MDR, In.Port, or the sign-extended version of the 
  constant C, as the source of the bus. The output of the BusMux, BusMuxOut,is the Bus itself */
  
  reg [31:0] busOutput;
  always @ (*)
  begin
  if(R0Out == 1)
    busOutput <= R0In;
   else if (R1Out == 1)
    busOutput <= R1In;
   else if (R2Out == 1)
    busOutput <= R2In;
   else if (R3Out == 1)
    busOutput <= R3In;
   else if (R4Out == 1)
    busOutput <= R4In;
   else if (R5Out == 1)
    busOutput <= R5In;
   else if (R6Out == 1)
     busOutput <= R6In;
   else if (R7Out == 1)
    busOutput <= R7In;
   else if (R8Out == 1)
    busOutput <= R8In;
   else if (R9Out == 1)
    busOutput <= R9In;
   else if (R10Out == 1)
    busOutput <= R10In;
   else if (R11Out == 1)
     busOutput <= R11In;
   else if (R12Out == 1)
    busOutput <= R12In;
   else if (R13Out == 1)
    busOutput <= R13In;
   else if (R14Out == 1)
    busOutput <= R14In;
   else if (R15Out == 1)
    busOutput <= R15In;
   else if (hiOut == 1)
    busOutput <= hiIn;
  else if (loOut == 1)
    busOutput <= loIn;
  else if (zHighOut == 1)
    busOutput <= zHighIn;
  else if (zLoOut == 1)
    busOutput <= zLoIn;
  else if (pcOut == 1)
    busOutput <= pcIn;
  else if (MDRout == 1)
    busOutput <= MDRin;
  else if (inPortOut == 1)
    busOutput <= inPortIn;
  else if (Cout == 1)
    busOutput <= C_sign_extended;
  end

  assign busMuxOut = busOutput;
  
endmodule
  
