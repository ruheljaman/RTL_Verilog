// T Flip-Flop
module T_Flipflop(T,clk,sync_reset,Q);
    input T,clk,sync_reset;   
    output reg Q;

    always @ (posedge clk or posedge sync_reset) begin
        if (sync_reset == 1'b1)
            Q <= 0;
        else if (T == 1'b1)
            Q <= ~Q;
        else
            Q <= Q;
    end
endmodule
/*#########################################################################################
################      Test Bench                                      ###################
################     It can be used in all type of flip flop          ###################   
########################################################################################## */
 module T_Flipflop_Test(); // T flip flop Test Name
 
  // DUT Input

reg T; // Data input 
reg clk; // clock input 
reg sync_reset; // synchronous reset 

  // DUT ouput
  
  wire Q; // output Q 

// DUT instantiation  

   T_Flipflop F2 (T,clk,sync_reset,Q);
  
// Test Case Generation 
  /*
Here we are going to verify the D flip flop.
SO we are taking clock, Data input and rest as a 
ref variable to verify the DUT functionality and we will
check either we are getting correct Q_Out output waveform
as our expection 


*/
   // this block suggest that all the variable
   //  here we are including all inital value are zero 
  initial begin  
    
    clk        = 1'b0;
    sync_reset = 1'b0;
    T          = 1'b0;   
    
  end
  
  
  
// Clock Generation
  
  always #10 clk = ~clk; // Time Period T=20ns
  
// reset 
  initial begin
   #5  sync_reset = 1;
    #10 sync_reset = 0;
    #40 sync_reset = 1;
    #10 sync_reset = 0;
    #30 sync_reset = 1;
    #20 sync_reset = 0;
	#20 sync_reset = 1;
	#30 sync_reset = 0;
  end
  
  initial begin 
   #5  T = 1'b1;
  #10  T = 1'b0;
  #10  T = 1'b1;
  #5   T = 1'b0;
  #15  T = 1'b1;
  #12   T = 1'b0;
  #17   T = 1'b1;
  #27   T = 1'b0;
  #25   T = 1'b1;
  #5    T = 1'b1;
  #10  T = 1'b0;
  #10  T = 1'b1;
  #5   T = 1'b0;
  #5  T = 1'b1;
  #10  T = 1'b0;
  #10  T = 1'b1;
  #5   T = 1'b0;
  #15  T = 1'b1;
  #12   T = 1'b0;
  #17   T = 1'b1;
  #27   T = 1'b0;
  #25   T = 1'b1;
  #5    T = 1'b1;
  #10  T = 1'b0;
  #10  T = 1'b1;
  #5   T = 1'b0;
    
    
end
  
// system task
  initial begin
    $monitor ("clk=%b sync_reset=%b T=%b Q=%b",clk,sync_reset,T,Q);
    #500 $finish;
  
  end

endmodule
