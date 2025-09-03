// RTL Code for Full Adder
module full_adder(A, B, Cin, Sum, Carry);
input A,B,Cin;
output Sum,Carry;
assign Sum =A^B^Cin;
assign Carry =(A&B)|(B&Cin)|(A&Cin);
endmodule
// Top Module
module parallel_adder(A,B,Ci,S,Cout);
input [3:0]A,B;
input Ci;
output [3:0]S;
output Cout;
wire [3:0]W;
wire C0,C1,C2;
assign W = B^{4{Ci}};
full_adder FA1(A[0],W[0],Ci,S[0],C0);
full_adder FA2(A[1],W[1],C0,S[1],C1);
full_adder FA3(A[2],W[2],C1,S[2],C2);
full_adder FA4(A[3],W[3],C2,S[3],Cout);
endmodule
// Testbench
module parallel_adder_Test;
reg [3:0]A,B;
reg Ci;
wire [3:0]S;
wire Cout;
integer i;
// DUT instantiation
parallel_adder R1 (A,B,Ci,S,Cout);
initial begin
for (i =0;i<256;i =i+1) begin
{A,B} = i[7:0];
Ci = 1'b0;
#2;
end
end
initial begin
$monitor("Time=%0t, A=%b,B=%b,W=%b,Ci=%b,S=%b,Cout=%b",
$realtime, A,B,R1.W,Ci,S,Cout);
#600 $finish;
end
endmodule
