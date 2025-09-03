///UP Down Counter RTL Code
module up_down_counter (clk,reset,enable,count);
	input clk,reset,enable;
	output reg [3:0] count;
	always @ (posedge clk) begin
		if (enable) begin //enable = 1 its up counter
			if(reset)begin
			count <= 4'b0000; end
			else begin
			count <= count+1;
			end
		end
		else begin  //enable = 0 its down counter
			if (reset)begin
			count <= 4'b1111;
			end
			else begin
			count <= count-1;
			end
		end
	end
endmodule 
//test bench
module up_down_counter_Test;
	reg clk,reset,enable;
	wire [3:0] count;
//dut 
	up_down_counter r1 (clk,reset,enable,count);
//clock generate 
	always clk=0;
		#5 clk = ~clk;
//reset condition
	initial begin
	reset=1;
	#10 reset=0;
	#150 reset=1;
	end
//enable condition when enable=1 its up counter and enable =0 its down Counter
	initial begin
	enable=0;
	#150 enable=1;
	#150 enable=0;
	end
//Display
	initial begin
        $monitor("Time=%0t,clk=%b,reset=%b,enable=%b,count=%d",$realtime,clk,reset,enable,count);
        #500 $finish;
    end
endmodule
