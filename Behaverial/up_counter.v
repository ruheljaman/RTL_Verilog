
module up_counter (clk,reset,Count);
	input clk,reset;
	output reg [3:0]Count;
	always @ (posedge clk or posedge reset) begin
        if (reset)
            Count <= 0;
        else
            Count <= Count+1;
    end
endmodule 
//Test Bench
module up_counter_Test;
    reg clk, reset;
	wire [3:0] Count;
	
// DUT
    up_counter DUT (clk,reset,Count);
// Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
// Reset
    initial begin
        reset = 1;       
        #20  reset = 0; 
        #50  reset = 1;  
        #20  reset = 0;  
        #200 reset = 1; 
        #30  reset = 0;
        #80  reset = 1;  
        #10  reset = 0;
    end
// Monitor output
    initial begin
        $monitor("Time=%0t,clk=%b,reset=%b,Count=%d",$realtime,clk,reset,Count);  
        #200 $finish;
    end
endmodule
