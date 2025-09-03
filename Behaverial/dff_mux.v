// D flip flop
module RisingEdge_DFlipFlop_SyncReset(d,clk,sync_reset,q);
    input d;           
    input clk;         
    input sync_reset;  
    output reg q;    
    always @(posedge clk) begin
        if (sync_reset == 1'b1)
            q <= 1'b0; 
        else 
            q <= d; 
    end 
endmodule 
// Top module 
module dff_mux (A,B,I,Select,Clk,Reset,Y,Qout);
    input A,B,I,Select,Clk,Reset;
    output Y;
    output Qout;        
    wire w1,w2,w3,w4;
    wire Din0,Din1,Din2;
    wire Q0,Q1;
    assign w1 = A&B;
    assign w2 = ~(w1&Q0);
    assign w3 = A|w2;
    assign w4 = w3|Q1;
// MODULE Instantiation
    // mux outputs
    mux_2x1 m1 (w1,I,Select,Din0);
    mux_2x1 m2 (w2,Q0,Select,Din1);
    mux_2x1 m3 (w4,Q1,Select,Din2);
    // D FlipFlops
    RisingEdge_DFlipFlop_SyncReset FF1 (Din0,Clk,Reset,Q0);
    RisingEdge_DFlipFlop_SyncReset FF2 (Din1,Clk,Reset,Q1);
    RisingEdge_DFlipFlop_SyncReset FF3 (Din2,Clk,Reset,Qout);
    // combinational output
    assign Y = w4|Qout;
endmodule
