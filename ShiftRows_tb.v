`include "ShiftRows.v"

// Using the below tool to cross-check results:
// https://legacy.cryptool.org/en/cto/aes-step-by-step

module ShiftRows_tb;

reg [127:0] in;
wire [127:0] out;

ShiftRows ShiftRows(.in(in), .out(out));

initial begin
    in = 128'h632d6323630953fcf4a751ca6363ca8c;
    #5
    $display("In = \n%h\nOut = \n%h", in, out);
    in = 128'hfe71189cdee0bbfaddd7340cd3d8f5fd;
    #5
    $display("In = \n%h\nOut = \n%h", in, out);
    //  expecting:
    //  out = 6309518c63a7ca23f46363fc632d53ca
    //  out = fee034fdded7f59cddd818fad371bb0c
    //  works!
end 

endmodule
