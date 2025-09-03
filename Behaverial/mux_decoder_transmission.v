//2:1 MUX
module mux2x1(I0,I1,S,Y);
	input I0,I1,S;
	output Y;
	assign Y=S?I1:I0;
endmodule
//4:1 MUX
module mux4x1(I,S,Y);
	input[3:0]I;
	input[1:0]S;
	output Y;
	assign Y=S[1]?(S[0]?I[3]:I[2]):(S[0]?I[1]:I[0]);
endmodule
//8:1 MUX using two 4:1 and one 2:1 MUX
module mux_8x1_df(I,S,Yout);
	input[7:0]I;
	input[2:0]S;
	output Yout;
	wire y0,y1;
	mux4x1 m1(I[3:0],S[1:0],y0);
	mux4x1 m2(I[7:4],S[1:0],y1);
	mux2x1 m3(y0,y1,S[2],Yout);
endmodule

//Decoder
module decoder_4to8(W,En,Y);
	input[2:0]W;
	input En;
	output[7:0]Y;
	assign Y[0]=En&(~W[2])&(~W[1])&(~W[0]);
	assign Y[1]=En&(~W[2])&(~W[1])&W[0];
	assign Y[2]=En&(~W[2])&W[1]&(~W[0]);
	assign Y[3]=En&(~W[2])&W[1]&W[0];
	assign Y[4]=En&W[2]&(~W[1])&(~W[0]);
	assign Y[5]=En&W[2]&(~W[1])&W[0];
	assign Y[6]=En&W[2]&W[1]&(~W[0]);
	assign Y[7]=En&W[2]&W[1]&W[0];
endmodule
//Counter
module up_counter(Clk,Reset,Count);
	input Clk,Reset;
	output reg[2:0]Count;
	always@(posedge Clk)begin
		if(Reset)begin
		Count<=3'b000;
		end
		else begin
		Count<=Count+1;
		end
	end
endmodule
//Top Module
module mux_decoder_transmission(SW,Clock,LD);
	input[7:0]SW;
	input Clock;
	output[7:0]LD;
	wire data;
	wire[2:0]B;
	up_counter R1(Clock,1'b0,B);
	mux_8x1_df R2(SW,B,data);
	decoder_4to8 R3(B,data,LD);
endmodule
// Test Bench
module mux_demux_transmission_Test;
    reg [7:0] SW;
    reg Clock;
    wire [7:0] LD;
    integer i;
 // DUT
    mux_decoder_transmission DUT(SW,Clock,LD);
    initial begin
        Clock = 0;
        forever #5 Clock = ~Clock;
    end
    initial begin
        for (i=0;i<256;i=i+1) begin
            SW=i;       
            #5;        
        end
    end
// Display
    initial begin
        $monitor("Time=%0t,SW=%b,Clock=%b,LD=%b", $time,SW,Clock,LD);
		   #1000 $finish;
    end
endmodule
