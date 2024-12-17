`include "InvMixColumns.v"

// Using the below tool to cross-check results:
// https://legacy.cryptool.org/en/cto/aes-step-by-step

module InvMixColumns_tb;

reg [127:0] in;
wire [127:0] out;

InvMixColumns InvMixColumns(.in(in), .out(out));

initial begin
    in = 128'h000e47fedd502e8ec96b4ee42806ad54;
    #5
    $display("In = \n%h\nOut = \n%h", in, out);
    in = 128'h15846a2cacf3477830a4205399ebdbbc;
    #5
    $display("In = \n%h\nOut = \n%h", in, out);
    //  expecting:
    //  out = 6309518c63a7ca23f46363fc632d53ca
    //  out = fee034fdded7f59cddd818fad371bb0c
    //  works!
end 

endmodule
