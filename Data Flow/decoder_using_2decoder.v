// 2-to-4 Decoder Module
module decoder(A0,A1,en,F0,F1,F2,F3);
 input A0,A1;
 input en;
 output F0,F1,F2,F3;
 assign F0 = (~A0) & (~A1) & en;
 assign F1 = (~A0) & A1 & en;
 assign F2 = A0 & (~A1) & en;
 assign F3 = A0 & A1 & en;
endmodule
// Top Module: 3-to-8 Decoder using two 2-to-4 Decoders
module decoder_using_2decoder(W,En,Y);
 input [2:0] W;
 input En;
 output [7:0] Y;
 wire En1,En2;
// Enable logic for two decoders
 assign En1 = (~W[2]) & En;
 assign En2 = W[2] & En;
// Module instantiation
 decoder FA1 (W[0],W[1],En1,Y[0],Y[1],Y[2],Y[3]);
 decoder FA2 (W[0],W[1],En2,Y[4],Y[5],Y[6],Y[7]);
endmodule
//Tese Bench
// Test Bench
module decoder_using_2decoder_Test;
 reg [2:0] W;
 reg En;
 wire [7:0] Y;
 integer i;
// DUT
 decoder_using_2decoder DUT (W, En, Y);
// Test case
 initial begin
 En = 1'b1;
 for (i = 0; i < 8; i = i + 1) begin
 W = i[2:0];
 #5;
 end
 end
// Display
 initial begin

$monitor("Time=%0t,W[0]=%b,W[1]=%b,W[2]=%b,En=%b,Y[0]=%b,Y[1]=%b,Y[2]=%b,Y[3]=%b,Y[4]=%b,Y[5]=%b,Y
[6]=%b,Y[7]=%b",
 $time,W[0],W[1],W[2],En,Y[0],Y[1],Y[2],Y[3],Y[4],Y[5],Y[6],Y[7]);
 #100 $finish;
 end
endmodule
