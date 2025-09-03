// 
module parameterized_up_down_counter (clk,rst_n,en,up_down,count,overflow,underflow);

    parameter COUNT_WIDTH = 4; // Parameter to define the width of the counter, now it is 4 bit , i can change it to make it 5,6 bit counter
    input clk,rst_n;
	input en; // Enable for counting. counter changes only when en = 1
	input up_down; //Controls direction, when  up_down=1 count up, up_down=0  count down.
    output reg [COUNT_WIDTH-1:0] count;  //The current count value.
    output overflow, underflow;  //overflow  when counting up max  e:g count=15 and underflow when counting down zero e:g count=0.

    wire [COUNT_WIDTH-1:0] next_count;  // // Internal wires for next count value
 
    // Next count logic based on up_down signal
    assign next_count = (up_down == 1'b1) ? count + 1'b1 : count - 1'b1;

    // Counter logic with asynchronous active-low reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= {COUNT_WIDTH{1'b0}};  // Reset to 0
        end
        else if (en) begin
            count <= next_count;
        end
    end
    // Overflow condition when counting up and at max value . use for detection detection its maximum limits.
    assign overflow = (up_down == 1'b1) && (count == {COUNT_WIDTH{1'b1}}) && en;
    // Underflow condition when counting down and at 0.use for detection detection its minimum limits.
    assign underflow = (up_down == 1'b0) && (count == {COUNT_WIDTH{1'b0}}) && en;
endmodule
//Test bench
module parameterized_up_down_counter_Test;
	// Testbench signals
    reg clk;
    reg rst_n;
    reg en;
    reg up_down;
    wire [3:0] count; // Assuming COUNT_WIDTH = 4 for this example
    wire overflow;
    wire underflow;
//dut
	parameterized_up_down_counter(clk, rst_n, en, up_down, count, overflow, underflow);
// Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end
 // Test sequence
    initial begin
        rst_n = 0; // Assert reset
        en = 0;
        up_down = 0;
        #10;

        rst_n = 1; // Release reset
        #10;

        en = 1;
        up_down = 1; // Count up
        #100; // Count from 0 to 10 (and likely trigger overflow)

        up_down = 0; // Count down
        #10;
        en = 0; // Disable
        #10;
        en = 1; // Re-enable
        #100; // Count down (and likely trigger underflow)
        $finish; // End simulation
    end
 // Display messages for overflow/underflow
    always @(posedge clk) begin
        if (overflow) begin
            $display("Time %0t: *** OVERFLOW DETECTED! Count = %d *** ", $time, count);
        end
        if (underflow) begin
            $display("Time %0t: *** UNDERFLOW DETECTED! Count = %d *** ", $time, count);
        end
        $display("Time %0t: count = %d, up_down = %b, en = %b", $time, count, up_down, en);
    end
endmodule
