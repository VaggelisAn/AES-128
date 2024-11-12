`include "SubBytes.v"
// Using the below tool to cross-check results:
// https://legacy.cryptool.org/en/cto/aes-step-by-step

module SubBytes_tb;

reg [127:0] in;
wire [127:0] out;

SubBytes SubBytes(.in(in), .out(out));

initial begin
    in = 128'h00000101030307070f0f1f1f3f3f6f8f;
    #5
    $display("In = \n%h\nOut = \n%h", in, out);
    in = 128'h0c2c341c9ca0fe14c90d2881a92d7721;
    #5
    $display("In = \n%h\nOut = \n%h", in, out);

    //  expecting:
    //  out = 63637c7c7b7bc5c57676c0c07575a873
    //  out = fe71189cdee0bbfaddd7340cd3d8f5fd
    //  works!
end 

endmodule
