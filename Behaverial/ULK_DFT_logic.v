//rtl code
module ULK_DFT_logic (
    input  clk,
    input  reset,
    input  select,
    input  I,
    input  A,
    input  B,
    output reg D0_out,
    output reg D1_out,
    output reg D2_out,
    output Y
);
    wire mux0_out, mux1_out, mux2_out;
// Com output
    assign Y = D2_out | ((~(D0_out & (A & B))) | A);
// MUX logic
    assign mux0_out = (select == 0) ? (A&B):I;
    assign mux1_out = (select == 0) ? ~(D0_out&(A&B)):D0_out;
    assign mux2_out = (select == 0) ? (D1_out&((~(D0_out&(A & B)))|A)):D1_out;
// Flip-Flop with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            D0_out <= 0;
            D1_out <= 0;
            D2_out <= 0;
        end 
		else begin
            D0_out <= mux0_out;
            D1_out <= mux1_out;
            D2_out <= mux2_out;
        end
    end
endmodule
// test bench
module ULK_DFT_logic_Test;
    reg clk,reset,select,I,A,B;
    wire D0_out,D1_out,D2_out,Y;
    integer i;
// DUT
    ULK_DFT_logic r1 (clk,reset,select,I,A,B,D0_out,D1_out,D2_out,Y);
// Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
// Reset logic
    initial begin
        reset = 1;
        #10 reset = 0;
        #100 reset = 1;
		#10 reset=0;
		 #100 reset = 1;
		 #10 reset=0;
		 #100 reset = 1;
    end
// Test case
    initial begin
        for (i=0;i<16;i=i+1) begin
            {A,B} = i[3:2];
            select = i[1];
            I = i[0];
            #20;
        end
    end
// Display results
    initial begin
        $monitor("Time=%0t,clk=%b,reset=%b,select=%b,I=%b,A=%b,B=%b,r1.mux0_out=%b,D0=%b,r1.mux1_out=%b,D1=%b,r1.mux2_out=%b,D2=%b,Y=%b",
					$realtime,clk,reset,select,I,A,B,r1.mux0_out,D0_out,r1.mux1_out,D1_out,r1.mux2_out,D2_out,Y);
        #400 $finish;  
    end
endmodule
