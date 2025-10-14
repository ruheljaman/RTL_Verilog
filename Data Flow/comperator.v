module comperator(A,B,C,D,E);
input A,B;
output C,D,E;
assign C = (A>B)? 1'b1:1'b0;
assign D = (A==B)? 1'b1:1'b0;
assign E = (A<B)? 1'b1:1'b0;
endmodule
module comperator_test;
reg A,B;
wire C,D,E;
integer i;
// DUT (Device Under Test)
comperator DUT (A,B,C,D,E);
// Testbench
initial begin
for (i = 0; i < 4; i = i + 1) begin
{A, B} = i;
#5;
end
#10 $finish;
end
initial begin
$monitor("T=%0t,A=%b,B=%b,C=%b,D=%b,E=%b", $realtime,A,B,C,D,E);
#200 $finish;
end
endmodule
