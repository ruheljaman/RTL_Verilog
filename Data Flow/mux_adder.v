/*
Two 2:1 multiplexers select between inputs (a, c) and (b, d) using a common select line m, producing
outputs w1 and w2.
These outputs w1 and w2 are fed into a half adder, generating the final sum (s0) and carry (s1).
*/
// RTL Code
module mux_2x1 (I0,I1,S,Y);
 input I0,I1,S;
 output Y;
 assign Y= S?I1:I0;
endmodule
module half_adder (A,B,S,C);
 input A,B;
 output S,C;
 assign S=A^B;
 assign C=A&B;
endmodule
//top module
module mux_adder(a,c,b,d,m,s0,s1);
 input a,c,b,d,m;
 output s0,s1;
 wire w1,w2;
 //module instentation
 mux_2x1 f1(a,c,m,w1);
 mux_2x1 f2(b,d,m,w2);
 half_adder f3(w1,w2,s0,s1); //s0=Sum,S1=Carry
endmodule
//Testbench
module mux_adder_test; // Added module keyword
 reg a,c,b,d,m;
 wire s0,s1;
 integer i;
 // DUT instantiation
 mux_adder FA (a,c,b,d,m,s0,s1);
 initial begin
 for (i =0;i<32;i =i+1)begin
 {a,c,b,d,m}=i[4:0];
 #5;
 end
 end
 initial begin
 $monitor("Time=%0t,a=%b,c=%b,b=%b,d=%b,m=%b,w1=%b,w2=%b,s0=%b,s1=%b",
 $realtime,a,c,b,d,m,FA.w1,FA.w2,s0,s1); // for intermediate node FA=handel decleare in DUT 
 #200 $finish;
 end
endmodule 
