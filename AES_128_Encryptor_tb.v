// Testbench for the aes-128-encryptor

`timescale 1ns / 1ps
`include "AES_128_Encryptor.v"

module aes_128_encryptor_tb;
reg [127:0] in;
reg [127:0] key;
wire [127:0] cipher;

AES_128_Encryptor AES_128_Encryptor(.in(in), .key(key), .cipher(cipher));

initial begin
    $dumpfile("aes_128_tb.vcd");
	$dumpvars(0, aes_128_encryptor_tb);
    // generate random hex numbers:
    // data_in = $urandom;
    // key_in = $urandom;
    //in = 128'h00000101030307070f0f1f1f3f3f7f7f;
    //key = 128'h0;
    // values taken from the nist pdf:
    in = 128'h3243f6a8885a308d313198a2e0370734;
    key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
    $display("in=%h\nkey=%h\ncipher=%h",in, key, cipher);
    #300
    in = 128'h00112233445566778899aabbccddeeff;
    key = 128'h000102030405060708090a0b0c0d0e0f;
    #300
    $display("in=%h\nkey=%h\ncipher=%h",in, key, cipher);
    $finish;
end

endmodule