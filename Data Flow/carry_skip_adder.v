//Full Adder Module
module full_adder(A,B,Cin,Sum,Carry);
 input A,B,Cin;
 output Sum,Carry;
 assign Sum = A^B^Cin;
 assign Carry = (A&B)|(B&Cin)|(Cin&A);
endmodule
//2:1 Multiplexer Module
module mux2x1(a,b,sel,y);
 input a,b,sel;
 output y;
 assign y =sel?a:b; //sel=0,then y=b,If sel=1,then y=a
endmodule
//Top Module: 4-bit Carry-Skip Adder
module carry_skip_adder(a,b,C0,sum,Cout);
 input [3:0] a,b;
 input C0;
 output Cout;
 output [3:0] sum;
 wire p0,p1,p2,p3;
 wire c1,c2,c3,c4;
 wire S;
// Module Instantiation Full Adders
 full_adder FA0(a[0],b[0],C0,sum[0],c1);
 full_adder FA1(a[1],b[1],c1,sum[1],c2);
 full_adder FA2(a[2],b[2],c2,sum[2],c3);
 full_adder FA3(a[3],b[3],c3,sum[3],c4);
//Propagate Signals a^b
 assign p0 = a[0]^b[0];
 assign p1 = a[1]^b[1];
 assign p2 = a[2]^b[2];
 assign p3 = a[3]^b[3];
 assign S = p0&p1&p2&p3;
//mux where select line is propagete signal
 mux2x1 MUX(C0,c4,S,Cout); //If S=0,output Cout=c4(b),If S=1, output Cout=C0(a)
endmodule
//Test Bench
module carry_skip_adder_Test;
 reg [3:0] a,b;
 reg C0;
 wire Cout;
 wire [3:0] sum;
 integer i,j;
// DUT
 carry_skip_adder dut(a,b,C0,sum,Cout);
// Test Case
 initial begin
 for (j=0;j<2;j=j+1) begin
 C0=j;
 for (i=0;i<256;i=i+1) begin
 {a,b}=i[7:0];
 #2;
 end
 end
 end
//Monitor
 initial begin
 $monitor("Time=%0t,a=%4b,b=%4b,C0=%b,sum=%4b,Cout=%b",$realtime,a,b,C0,sum,Cout);
 #1028 $finish;
 end
endmodule
