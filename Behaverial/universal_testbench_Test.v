/*#########################################################################################
################      Test Bench                                      ###################
################     It can be used in all type of flip flop          ###################   
########################################################################################## */
 module universal_testbench_Test(); // mow it use d flipflop
  // DUT Input
reg D; // Data input 
reg clk; // clock input 
reg sync_reset; // synchronous reset 
  // DUT ouput
  wire Q; // output Q 
// DUT instantiation  
   D_Flip_Flop F2 (D,clk,sync_reset,Q);
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
    D          = 1'b0;   
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
  end
  
  initial begin 
    #7  D = 1;
    #15 D = 0;
    #20 D = 1;
    #15 D = 0;
    #10 D = 1;
    #25 D = 0;
    #30 D = 1; 
end
  
// system task
  initial begin
    $monitor ("clk=%b sync_reset=%b D=%b Q=%b",clk,sync_reset,D,Q);
    #500 $finish;  
  end
endmodule
