/*A BCD (Binary-Coded Decimal) adder is a digital circuit that adds two 4-bit BCD numbers and
produces a valid BCD result.BCD numbers range from 0000 (0) to 1001 (9).
A regular binary adder can produce values from 0 to 15 (i.e., 0000 to 1111), but BCD can only
represent 0 to 9. So, if the sum exceeds 9, it must be corrected to remain a valid BCD digit.
If Sum > 9, it's an invalid BCD digit → add 6 (0110₂) to correct it.
Adding 6 makes the binary output skip the six invalid states (1010 to 1111) and return to a valid
2-digit BCD representation.
*/
// 4 bit BCD adder
module bcd_adder (a,b,Result);
 input [3:0] a,b;
 output [4:0] Result;
 wire [4:0] sum_temp;
 assign sum_temp = a+b;
 assign Result = (sum_temp > 4'd9) ? (sum_temp + 4'd6) : sum_temp;
endmodule
// Test bench
module bcd_adder_Test;
 reg [3:0] a, b;
 wire [4:0] Result;
 integer i;
// DUT
 bcd_adder R1(a, b, Result);
// Test Case
 initial begin
 for (i = 0; i < 256; i = i + 1) begin // 2^8=256
 {a, b} = i[7:0]; // a = i[7:4], b = i[3:0]
 #2;
 end
 end
// system task
 initial begin
 $monitor("Time=%0t,a=%4b,b=%4b ,Result=%5b",$realtime,a,b,Result); // b=%4b, 4 bit,Result=%5b 5 bit
 #600 $finish;
 end
endmodule
