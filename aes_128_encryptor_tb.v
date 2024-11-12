// Testbench for the aes-128-encryptor

`timescale 1ns / 1ps

module aes_128_encryptor_tb;
reg  clk;
reg [127:0] state;
reg [127:0] key;

wire [127:0] cipher;

aes_128_encryptor aes_128_inst (
    .clk(clk), 
    .state(state), 
    .key(key), 
    .cipher(cipher)
);

initial begin
    $dumpfile("aes_128_tb.vcd");
	$dumpvars(0, aes_128_encryptor_tb);
    clk = 0;
    // generate random hex numbers:
    // data_in = $urandom;
    // key_in = $urandom;
    data_in = 128'h00000101030307070f0f1f1f3f3f7f7f;
    key_in = 128'h000010f0;
    #15
    $finish;
end

always #5 clk=~clk;

endmodule