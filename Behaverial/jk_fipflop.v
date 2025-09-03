//RTL Code
module jk_fipflop(clk,sync_reset,J,K,Q,Q_bar);
    input clk,sync_reset;
    input J,K;
    output reg Q;
    output Q_bar;
    assign Q_bar = ~Q;
    always @ (posedge clk) begin
        if (sync_reset)
            Q <= 1'b0;
        else begin
            if (J == 1'b0 && K == 1'b0)
                Q <= Q;       
            else if (J == 1'b0 && K == 1'b1)
                Q <= 1'b0;    
            else if (J == 1'b1 && K == 1'b0)
                Q <= 1'b1;    
            else if (J == 1'b1 && K == 1'b1)
                Q <= ~Q;       
        end
    end
endmodule
 //Test bench
module jk_fipflop_Test();
    reg clk;
    reg sync_reset;
    reg J,K;
    wire Q;
    wire Q_bar;
// DUT Instantiation
    jk_fipflop F2 (clk,sync_reset,J,K,Q,Q_bar);
	
    initial begin
        clk = 1'b0;
        sync_reset = 1'b0;
        J = 1'b0;
        K = 1'b0;
    end
// Clock Generation
    always #10 clk = ~clk;
//Test Cases 
    initial begin
        #7   J = 1'b0; K = 1'b0; 
        #15  J = 1'b1; K = 1'b0;  
        #20  J = 1'b0; K = 1'b1;  
        #15  J = 1'b1; K = 1'b1;  
        #10  J = 1'b1; K = 1'b0;  
        #25  J = 1'b0; K = 1'b0;  
        #30  J = 1'b1; K = 1'b1; 
        #20  J = 1'b0; K = 1'b1;  
        #15  J = 1'b1; K = 1'b1;  
        #10  J = 1'b1; K = 1'b0; 
        #25  J = 1'b0; K = 1'b0; 
        #30  J = 1'b1; K = 1'b1;  
        #20  J = 1'b0; K = 1'b1;  
        #15  J = 1'b1; K = 1'b1;  
        #10  J = 1'b1; K = 1'b0;  
        #25  J = 1'b0; K = 1'b0;  
        #30  J = 1'b1; K = 1'b1;  
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
        $monitor("Time=%0t,clk=%b,sync_reset=%b,J=%b,K=%b,Q=%b,Q_bar=%b",$time,clk,sync_reset,J,K,Q,Q_bar);
        #500 $finish;
    end
endmodule
