//BCD Counting System
//Counter
module Counter(clk,reset,C);
	input clk,reset;
	output reg [3:0]C;
	always @ (posedge clk) begin
        if (reset)
            C <= 0;
        else if (C == 4'b1001) 
            C <= 0;
        else
            C <= C+1;
    end
endmodule 

//7 Segment Display Decoder - EXACT MATCH TO YOUR TABLE
module seven_segment_display (b0,b1,b2,b3,A,B,C,D,E,F,G);
	input b0,b1,b2,b3;
	output A,B,C,D,E,F,G;
	
	assign A = (~b3 & ~b2 & ~b1 & ~b0) | (~b3 & ~b2 & b1 & ~b0) | (~b3 & ~b2 & b1 & b0) | (~b3 & b2 & ~b1 & b0) | (~b3 & b2 & b1 & ~b0) | (~b3 & b2 & b1 & b0) | (b3 & ~b2 & ~b1 & ~b0) | (b3 & ~b2 & ~b1 & b0);
	assign B = (~b3 & ~b2 & ~b1 & ~b0) | (~b3 & ~b2 & ~b1 & b0) | (~b3 & ~b2 & b1 & ~b0) | (~b3 & ~b2 & b1 & b0) | (~b3 & b2 & ~b1 & ~b0) | (~b3 & b2 & b1 & ~b0) | (~b3 & b2 & b1 & b0) | (b3 & ~b2 & ~b1 & ~b0) | (b3 & ~b2 & ~b1 & b0);
	assign C = (~b3 & ~b2 & ~b1 & ~b0) | (~b3 & ~b2 & ~b1 & b0) | (~b3 & ~b2 & b1 & b0) | (~b3 & b2 & ~b1 & ~b0) | (~b3 & b2 & ~b1 & b0) | (~b3 & b2 & b1 & ~b0) | (~b3 & b2 & b1 & b0) | (b3 & ~b2 & ~b1 & ~b0) | (b3 & ~b2 & ~b1 & b0);
	assign D = (~b3 & ~b2 & ~b1 & ~b0) | (~b3 & ~b2 & b1 & ~b0) | (~b3 & ~b2 & b1 & b0) | (~b3 & b2 & ~b1 & b0) | (~b3 & b2 & b1 & ~b0) | (b3 & ~b2 & ~b1 & ~b0) | (b3 & ~b2 & ~b1 & b0);
	assign E = (~b3 & ~b2 & ~b1 & ~b0) | (~b3 & ~b2 & b1 & ~b0) | (~b3 & b2 & b1 & ~b0) | (b3 & ~b2 & ~b1 & ~b0);
	assign F = (~b3 & ~b2 & ~b1 & ~b0) | (~b3 & b2 & ~b1 & ~b0) | (~b3 & b2 & ~b1 & b0) | (~b3 & b2 & b1 & ~b0) | (b3 & ~b2 & ~b1 & ~b0) | (b3 & ~b2 & ~b1 & b0);
	assign G = (~b3 & ~b2 & ~b1 & ~b0) | (~b3 & ~b2 & b1 & ~b0) | (~b3 & ~b2 & b1 & b0) | (~b3 & b2 & ~b1 & ~b0) | (~b3 & b2 & ~b1 & b0) | (~b3 & b2 & b1 & ~b0) | (b3 & ~b2 & ~b1 & ~b0) | (b3 & ~b2 & ~b1 & b0);
endmodule

//Top module
module BCD_counting_system (Clock,Reset,Count,a,b,c,d,e,f,g);
	input Clock;
	input Reset;
	output [3:0] Count;
	output a,b,c,d,e,f,g;
	wire [3:0] C;
	
	//for count value
	assign Count = C;
	
	//Module Instantiation 
	Counter R1 (Clock, Reset, C);  
	seven_segment_display R2 (C[0],C[1],C[2],C[3],a,b,c,d,e,f,g);
endmodule 

//Test Bench
module BCD_counting_system_Test;
    reg Clock, reset;
	wire [3:0] Count;
    wire a,b,c,d,e,f,g;
	
	// DUT
    BCD_counting_system DUT (Clock,reset,Count,a,b,c,d,e,f,g);
	
	// Clock generation
    initial begin
        Clock = 0;
        forever #5 Clock = ~Clock;
    end
	
	//for  Reset
    initial begin
        reset = 1;     
        #10 reset = 0;
    end
	
	// Monitor output
    initial begin
        $monitor("Time=%0t,Clock=%b,Count=%d,a=%b,b=%b,c=%b,d=%b,e=%b,f=%b,g=%b",$realtime,Clock,Count,a,b,c,d,e,f,g);  
        #200 $finish;
    end
endmodule
