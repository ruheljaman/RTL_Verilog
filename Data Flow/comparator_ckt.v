/*
RTL Design with Testbench:4-Bit Signed Comparator with Overflow Detection
*/

// RTL Code for Full Adder
module full_adder(A,B,Cin,Sum,Carry);
 input A,B,Cin;
 output Sum,Carry;
 assign Sum =A^B^Cin;
 assign Carry =(A&B)|(B&Cin)|(A&Cin);
endmodule
//Top module
module comparator_ckt(x,y,c0,V,N,Z);
 input [3:0] x,y;
 input c0;
 output V,N,Z;
 wire c1,c2,c3,c4;
 wire [3:0] W,S;
 assign W = ~y;
 full_adder FA1(x[0],W[0],c0,S[0],c1);
 full_adder FA2(x[1],W[1],c1,S[1],c2);
 full_adder FA3(x[2],W[2],c2,S[2],c3);
 full_adder FA4(x[3],W[3],c3,S[3],c4);
 assign V = c3 ^ c4; //Overflow
 assign N = S[3]; //Negative
 assign Z = ~(S[0]|S[1]|S[2]|S[3]); //Zero
endmodule
//Testbench
module comparator_ckt_Test;
 reg [3:0]x,y;
 reg c0;
 wire V,N,Z;
 integer i;
// DUT
 comparator_ckt R1(x,y,c0,V,N,Z);
//Test Cas
 initial begin
 c0 =1'b1;
 for (i=0;i<256;i=i+1) begin //2^8=256
 {x, y} = i[7:0]; //x=i[7:4],y=i[3:0]
 #2;
 end
 end
//system task
 initial begin
 $monitor("Time=%0t,x=%4b,y=%4b,c0=%b,V=%b,N=%b,Z=%b",$realtime,x,y,c0,V,N,Z);
 #600 $finish;
 end
endmodule
