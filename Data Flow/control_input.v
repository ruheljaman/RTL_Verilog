/*
Description: A logic circuit that has two control inputs and four data inputs. The system
performs addition when control input is 0, subtraction when control input is 1, 1’s
complement of inputs when control input is 2 and 2’s complement of inputs when control
input is 3. Design the logic circuit and write data flow level Verilog code.
*/
module control_input (A,B,Ctrl,Y);
 input [3:0]A; // First 4-bit input
 input [3:0]B; // Second 4-bit input
 input [1:0]Ctrl; // 2-bit control input
 output [4:0]Y; // 5-bit output because overflow
 wire [4:0]add_result;
 wire [4:0]sub_result;
 wire [3:0]ones_comp_A;
 wire [3:0]twos_comp_A;
 assign add_result = A + B;
 assign sub_result = A - B;
 assign ones_comp_A = ~A; // 1's complement of A
 assign twos_comp_A = ones_comp_A + 1'b1; // 2's complement of A
 assign Y = (Ctrl == 2'b00) ? add_result :
 (Ctrl == 2'b01) ? sub_result :
 (Ctrl == 2'b10) ? {1'b0, ones_comp_A} : //1-bit zero (1'b0) MSB
 (Ctrl == 2'b11) ? {1'b0, twos_comp_A} :
 5'b00000; // default value
endmodule
//Test Bench
module control_input_Test;
reg [3:0]A;
 reg [3:0]B;
 reg [1:0]Ctrl;
 wire [4:0]Y;
integer i,j,k;
// DUT
control_input R1 (A,B,Ctrl,Y);
//Test Case
 initial begin
 for (i=0;i<16;i=i+1) begin
 for (j=0;j<16;j=j+1) begin
 for (k=0;k<4;k=k+1) begin
 A=i;
 B=j;
 Ctrl=k;
 #1;
 end
 end
 end
 end
// Display
 initial begin
 $monitor("Time=%0t,A=%b,B=%b,Ctrl=%b,Y=%b",$time,A,B,Ctrl,Y);
 #1000 $finish;
 end
endmodule
