// Full Adder Module
module full_adder(A,B,Cin,Sum,Carry);
 input A,B,Cin;
 output Sum,Carry;
 assign Sum = A^B^Cin;
 assign Carry = (A&B)|(B&Cin)|(Cin&A);
endmodule
// 2:1 Multiplexer Module
module mux2x1(a,b,sel,y);
 input a,b,sel;
 output y;
 assign y = sel ? b : a;
endmodule
// 4-bit Carry Select Adder Module
module carry_select_adder_4bit(X,Y,Cin,Sum,Cout);
 input [3:0] X,Y;
 input Cin; //select line of mux
 output [3:0] Sum;
 output Cout;
 wire [3:0] sum0;
 wire [3:0] sum1;
 wire c0,c1; // carry out of parallel adder
 wire [2:0] carry0; // Cin=0
 wire [2:0] carry1; //Cin=1
// First adder line where carry in = 0
 full_adder fa1 (X[0],Y[0],1'b0,sum0[0],carry0[0]);
 full_adder fa2 (X[1],Y[1],carry0[0],sum0[1],carry0[1]);
 full_adder fa3 (X[2],Y[2],carry0[1],sum0[2],carry0[2]);
 full_adder fa4 (X[3],Y[3],carry0[2],sum0[3],c0);
// Second adder line where carry in = 1
 full_adder fa5 (X[0],Y[0],1'b1,sum1[0],carry1[0]);
 full_adder fa6 (X[1],Y[1],carry1[0],sum1[1],carry1[1]);
 full_adder fa7 (X[2],Y[2],carry1[1],sum1[2],carry1[2]);
 full_adder fa8 (X[3],Y[3],carry1[2],sum1[3],c1);
// MUX where input is output of the full adder
 mux2x1 m0 (sum0[0],sum1[0],Cin,Sum[0]);
 mux2x1 m1 (sum0[1],sum1[1],Cin,Sum[1]);
 mux2x1 m2 (sum0[2],sum1[2],Cin,Sum[2]);
 mux2x1 m3 (sum0[3],sum1[3],Cin,Sum[3]);
// Final MUX output is Cout
 mux2x1 m_4 (c0,c1,Cin,Cout);
endmodule
// Testbench
module carry_select_adder_4bit_Test;
 reg [3:0] X,Y;
 reg Cin;
 wire [3:0] Sum;
 wire Cout;
 integer i,j,k;
// DUT instantiation
 carry_select_adder_4bit DUT(X,Y,Cin,Sum,Cout);
// Test case
 initial begin
 for (i=0;i<16;i=i+1) begin
 for (j=0;j<16;j=j+1) begin
 for (k=0;k<2;k=k+1) begin
 X=i;
 Y=j;
 Cin=k;
 #1;
 end
 end
 end
 end
// Display
 initial begin
 $monitor("Time=%0t,X=%b,Y=%b,Cin=%b,Sum=%b,Cout=%b",$time,X,Y,Cin,Sum,Cout);
 #1000 $finish;
 end
endmodule
