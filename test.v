module test;

reg clk;
reg [15:0] w;
reg [3:0] key;

initial begin
w = 16'b1;
key = 4'b1;
$display("w=%b", w);
$display("key=%b", key);
#5
w = 16'b101110;
key=w;
$display("w=%b", w);
$display("key=%b", key);
#5
key = w[11+:4]; 
$display("w=%b", w);
$display("key=%b", key);
#5
key = w[1];
$display("key=%b", key);
end
endmodule