//MOD Counter
module mod_up_counter (clk,reset,Count);
	input clk,reset;
	output reg [3:0]Count;
	always @ (posedge clk or posedge reset) begin
        if (reset)
            Count <= 0;
        else if (Count == 4'b1001) 
            Count <= 0;
        else
            Count <= Count+1;
    end
endmodule 
//Test Bench
module mod_up_counter_Test;
    reg clk, reset;
	wire [3:0] Count;
	
	// DUT
    mod_up_counter DUT (clk,reset,Count);
	
	// Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
	
	//for  Reset
    initial begin
        reset = 1;     
        #70 reset = 0;
		#10 reset = 1;
		#90 reset = 0;	
    end
	
	// Monitor output
    initial begin
        $monitor("Time=%0t,clk=%b,Count=%d",$realtime,clk,reset,Count);  
        #200 $finish;
    end
endmodule//MOD Counter
module mod_up_counter (clk,reset,Count);
	input clk,reset;
	output reg [3:0]Count;
	always @ (posedge clk or posedge reset) begin
        if (reset)
            Count <= 0;
        else if (Count == 4'b1001) 
            Count <= 0;
        else
            Count <= Count+1;
    end
endmodule 
//Test Bench
module mod_up_counter_Test;
    reg clk, reset;
	wire [3:0] Count;
	
	// DUT
    mod_up_counter DUT (clk,reset,Count);
	
	// Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
	
	//for  Reset
    initial begin
        reset = 1;     
        #70 reset = 0;
		#10 reset = 1;
		#90 reset = 0;	
    end
	
	// Monitor output
    initial begin
        $monitor("Time=%0t,clk=%b,Count=%d",$realtime,clk,reset,Count);  
        #200 $finish;
    end
endmodule
