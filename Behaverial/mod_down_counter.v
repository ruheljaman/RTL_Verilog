//RTL Code
module mod_down_counter(clk,reset,count);
	input clk,reset;
	output reg [3:0] count;
	always @ (posedge clk or posedge reset)begin
		if (reset) begin
		count <= 4'b1111;
		end
		else if (count== 4'b0010)begin
		count <= 4'b1111;
		end
		else begin
		count <= count-1;
		end
	end
endmodule 
//Test bench 
module mod_down_counter_Test;
	reg clk,reset;
	wire [3:0] count;
//dut 
	mod_down_counter r1 (clk,reset,count);
//clock generate 
	initial begin
	clk=0;
	forever #5 clk = ~clk;
	end
//reset condition 
	initial begin
	reset = 0;
        #20 reset = 1;
        #10 reset = 0;
        #90 reset = 1;
        #10 reset = 0;
	end
//Display
	initial begin
        $monitor("Time=%0t,clk=%b,reset=%b,count=%d",$realtime,clk,reset,count);
        #200 $finish;
    end
endmodule
