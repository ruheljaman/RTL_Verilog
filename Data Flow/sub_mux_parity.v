/*
Two subtractors take inputs (A, B) and (P, Q), generating four output bits in total.
These outputs are connected to a 4:1 multiplexer, where select lines S0 and S1.
The selected output from the MUX is passed to a parity checker, which produces the final output Out.
*/
RTL Coad with TB:
// Half Subtractor
module half_subtractor (a,b,d,bo);
 input a,b;
 output d,bo;
 assign d=a^b;
 assign bo= a&(~b);
endmodule
// 4:1 Multiplexer
module mux4x1(I0,I1,I2,I3,s0,s1,Y);
 input I0,I1,I2,I3;
 input s0,s1;
 output Y;
 assign Y= s1?(s0?I3:I2):(s0?I1:I0);
endmodule
// Top module with Parity Checker MAIN
module sub_mux_parity (A,B,P,Q,S0,S1,Out);
 input A,B,P,Q;
 input S0,S1;
 output Out;
 wire D,Bo,d,bo; //output of subtractors
wire Y; //output of mux
//Module Instentation
 half_subtractor HS1(A,B,D,Bo); // First Half Subtractor
 half_subtractor HS2(P,Q,d,bo); // Second Half Subtractor
 mux4x1 MUX1(D,Bo,d,bo,S0,S1,Y); // I0=D,I1=Bo,I2=d,I3=bo
// Parity Checker Logic
 wire parity_bit = ^Y; // XOR reduction logic of even parity
 assign Out =(parity_bit)?1'b1:1'b0; // 1 for even, 0 for odd
endmodule
//TB
module sub_mux_parity_Test;
 reg A,B,P,Q;
 reg S0,S1;
 wire Out;
 integer i;
// DUT instantiation
 sub_mux_parity R1(A,B,P,Q,S0,S1,Out);
 initial begin
 for (i =0;i<64;i=i+1) begin
 {A,B,P,Q,S1,S0} = i;
 #2;
 end
 end
 initial begin
 $monitor("Time=%0t,A=%b,B=%b,P=%b,Q=%b,S1=%b,S0=%b,D=%b,Bo=%b,d=%b,bo=%b,Y=%b,Out=%b",
 $realtime,A,B,P,Q,S1,S0,R1.D,R1.Bo,R1.d,R1.bo,R1.Y,Out);
 #200 $finish;
 end
endmodule
