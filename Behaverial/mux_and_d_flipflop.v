*

Design a synchronous D flip-flop module with an asynchronous active-low reset (reset_n) and clock input (clk), 
enhanced by combinational logic and a multiplexer to control the input data. The flip-flop input is selected by a 2-to-1 multiplexer controlled by a select signal (sel): 
when sel is 0, the multiplexer passes a logic-AND of two input signals (in1 AND in2); when sel is 1, it passes the logic-OR of another two inputs (in3 OR in4). 
The output of the multiplexer feeds the D input of the flip-flop. On the rising edge of clk, if the asynchronous reset (reset_n) is low, the output (q) resets immediately to zero.
 Otherwise, if reset is inactive, the flip-flop samples the multiplexer output and updates q accordingly. 
 The design should be implemented behaviorally using if-else if statements inside an always @(posedge clk or negedge reset_n) block, correctly handling asynchronous reset, 
 synchronous clocking, and input selection through logic gates and the multiplexer. The output q reflects the registered value after each clock cycle. 
 The module must be synthesizable and designed to ensure glitch-free and deterministic operation.
*/
module mux_and_d_flipflop (clk,reset,select,in1,in2,in3,in4,Q);
	input clk,reset,select,in1,in2,in3,in4;
	output reg Q;
	wire Yout; // Mux output
	assign Yout=(select ==1'b0) ? (in1&in2) : (in3|in4);  // when sel is 0, multiplexer passes a logic-AND of two input signals (in1 AND in2); when sel is 1, it passes the logic-OR of another two inputs (in3 OR in4)
	always @ (posedge clk or negedge reset) begin       //asynchronous active-low reset (reset_n) and clock input (clk)
		if (reset==1'b0) begin
		Q <= 1'b0;
		end
		else begin
		Q <= Yout;
		end
	end
endmodule 
//Test bench
module mux_and_d_flipflop_Test;
    reg clk,reset,select,in1,in2,in3,in4;
    wire Q;
    integer i;
// DUT
    mux_and_d_flipflop R1 (clk,reset,select,in1,in2,in3,in4,Q);
// Clock
    initial begin 
        clk = 0;
        forever #5 clk = ~clk;
    end
// Reset Condition
    initial begin
        reset = 1;
        #10 reset=0;
        #70 reset=1;
    end
// Test Case
    initial begin
        for (i=0;i<16;i=i+1) begin
            {in1,in2,in3,in4} = i[3:0];
            select = 0;
            #10 select = 1;
            #10 select = 0;
            #10 select = 1;
            #10;
        end
    end
// Display
    initial begin
        $monitor("Time=%0t,clk=%b,reset=%b,select=%b,in1=%b,in2=%b,in3=%b,in4=%b,R1.Yout=%b,Q=%b",$time,clk,reset,select,in1,in2,in3,in4,R1.Yout,Q);
        #500 $finish;
    end
endmodule
