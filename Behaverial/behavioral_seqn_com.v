//RTL Coad
module behavioral_seqn_com (x,Clock,reset,A,B,y);
	 input x;
    input Clock,reset;
    output reg A;
    output reg B;
    output y;
assign y=(A|B)&(~x);
always @(posedge Clock) begin
	if (reset)begin
	A <= 0;
	B <= 0;
	end
	else begin
	A <= (A&x)|(B&x);    
	B <= (~A & x);
	end	
end
endmodule
//Test banch
module behavioral_seqn_com_Test;
	reg x,Clock,reset;
	wire A,B,y;
//DUT 
	behavioral_seqn_com R1 (x,Clock,reset,A,B,y);
// Test Case
  initial begin
    Clock = 0;
    forever #5 Clock = ~Clock;
  end
  initial begin
   reset = 1;
  #10 reset = 0;
  #70 reset = 1;
  #10 reset = 0;
 end
  initial begin
    x = 1; 
    #10 x = 1; 
    #10 x = 1;  
    #10 x = 0;
    #10 x = 1; 
    #10 x = 1;
    #10 x = 1;
    #10 x = 0; 
    #10 x = 1;
    #10 x = 1;
	#10 x = 1; 
    #10 x = 1; 
    #10 x = 1;  
    #10 x = 0;
    #10 x = 1; 
    #10 x = 1;
    #10 x = 1;
    #10 x = 0; 
    #10 x = 1;
    #10 x = 1;
	$finish;
  end
// Display
    initial begin
        $monitor("Time=%0t,x=%b,Clock=%b,reset=%b,A=%b,B=%b,y=%b",$time,x,Clock,reset,A,B,y);
        #200 $finish;
    end
endmodule
