/*
A Full Adder receives inputs a, b, and Cin = 1, producing a Sum (s) and Carry (c).
The s and c outputs feed into an OR gate, generating one input of the MUX.
The MUX select lines are driven by inputs c and d.
*/
// Full Adder Module
module full_adder(A,B,Cin,Sum,Carry);
input A,B,Cin;
output Sum,Carry;
 assign Sum = A^B^Cin;
 assign Carry = (A&B)|(B&Cin)|(Cin&A);
endmodule
// 4:1 Multiplexer Module
module mux4x1(I0,I1,I2,I3,S0,S1,y);
input I0,I1,I2,I3;
input S0,S1;
output y;
assign y= S1?(S0?I3:I2):(S0?I1:I0);
endmodule
//Top Module
module adder_nd_mux (a,b,cin,c,d,Y);
input a,b,cin,c,d;
output Y;
wire S,C,D0,D1,D2,D3; // Input Port of Mux is D0,D1,D2,D3 and Output wire of Full adder is S,C;
assign D0=1'b0; //Value of D0=0.
assign D1=S^C; // D1 input= S xor C
assign D2=C;
assign D3=~C;// D3 input
full_adder F1(a,b,cin,S,C);
mux4x1 F2(D0,D1,D2,D3,d,c,Y); // S0=d,S1=c
endmodule
// Testbench
module adder_nd_mux_Test;
reg a,b,cin,c,d;
wire Y;
integer i;
// DUT (Device Under Test) instantiation
adder_nd_mux R1 (a,b,cin,c,d,Y);
initial
for (i =0;i<16;i=i+1) begin
{a,b,c,d}=i;
cin=1'b1;
#2;
end
 initial begin // R1.S get S intermediate node value. Where R1 handel decleare in DUT

$monitor("Time=%0t,a=%b,b=%b,cin=%b,S=%b,C=%b,D0=%b,D1=%b,D2=%b,D3=%b,c=%b,d=%b,Y=%b",$realtime,a,
b,cin,R1.S,R1.C,R1.D0,R1.D1,R1.D2,R1.D3,c,d,Y);
 #1000 $finish; // Stop after 1000 time units
 end
endmodule
