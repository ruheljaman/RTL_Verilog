//RTL Code
module SR_Flipflop(clk,sync_reset,S,R,Q,Q_bar);
    input clk,sync_reset;
    input S,R;
    output reg Q;
    output Q_bar;
    assign Q_bar = ~Q;
    always @ (posedge clk) begin
        if (sync_reset)
            Q <= 1'b0;
        else begin
            if (S == 1'b0 && R == 1'b0)
                Q <= Q;       
            else if (S == 1'b0 && R == 1'b1)
                Q <= 1'b0;    
            else if (S == 1'b1 && R == 1'b0)
                Q <= 1'b1;    
            else if (S == 1'b1 && R == 1'b1)
                Q <= 1'bx;       
        end
    end
endmodule
//Test casemodule 
module	SR_Flipflop_Test;
    reg clk;
    reg sync_reset;
    reg S,R;
    wire Q;
    wire Q_bar;
// DUT Instantiation
    SR_Flipflop F2 (clk,sync_reset,S,R,Q,Q_bar);
	
    initial begin
        clk = 1'b0;
        sync_reset = 1'b0;
        S = 1'b0;
        R = 1'b0;
    end
// Clock Generation
    always #10 clk = ~clk;
//Test Cases 
    initial begin
        #7   S = 1'b0; R = 1'b0; 
        #15  S = 1'b1; R = 1'b0;  
        #20  S = 1'b0; R = 1'b1;  
        #15  S = 1'b1; R = 1'b1;  
        #10  S = 1'b1; R = 1'b0;  
        #25  S = 1'b0; R = 1'b0;  
        #30  S = 1'b1; R = 1'b1; 
        #20  S = 1'b0; R = 1'b1;  
        #15  S = 1'b1; R = 1'b1;  
        #10  S = 1'b1; R = 1'b0; 
        #25  S = 1'b0; R = 1'b0; 
        #30  S = 1'b1; R = 1'b1;  
        #20  S = 1'b0; R = 1'b1;  
        #15  S = 1'b1; R = 1'b1;  
        #10  S = 1'b1; R = 1'b0;  
        #25  S = 1'b0; R = 1'b0;  
        #30  S = 1'b1; R = 1'b1;  
  end

//  Synchronous Reset 
    initial begin
        sync_reset = 0;
        #5   sync_reset = 0;
        #60  sync_reset = 1;
        #10  sync_reset = 0;
        #70  sync_reset = 1;
        #70  sync_reset = 0;
    end
// Monitor Signals
    initial begin
        $monitor("Time=%0t,clk=%b,sync_reset=%b,S=%b,R=%b,Q=%b,Q_bar=%b",$time,clk,sync_reset,S,R,Q,Q_bar);
        #500 $finish;
    end
endmodule
