//branch_op.v, 32-bit BRANCH instruction module 

`timescale 1ns/10ps

module branch_op (
);

/*conditions   --00: branch if zero       brzr  Ra, C
             --01: branch if nonzero    brnz  Ra, C
             --10: branch if positive   brpl  Ra, c
             --11: branch if negative   brmi  Ra, C
*/
