// Testbench for the aes-128-decryptor

`timescale 1ns / 1ps
`include "AES_128_Decryptor.v"

module aes_128_decryptor_tb;
reg [127:0] in;
reg [127:0] key;
wire [127:0] cipher;

AES_128_Decryptor AES_128_Decryptor(.in(in), .key(key), .cipher(cipher));

initial begin
    $dumpfile("aes_128_tb.vcd");
	$dumpvars(0, aes_128_decryptor_tb);
    // generate random hex numbers:
    // data_in = $urandom;
    // key_in = $urandom;
    //in = 128'h00000101030307070f0f1f1f3f3f7f7f;
    //key = 128'h0;
    // values taken from the nist pdf:
    in = 128'h3925841d02dc09fbdc118597196a0b32;
    key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
    #300
    $display("in=%h\nkey=%h\ncipher=%h",in, key, cipher);
    // expecting: 3243f6a8885a308d313198a2e0370734
    #1
    in = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
    key = 128'h000102030405060708090a0b0c0d0e0f;
    #300
    $display("in=%h\nkey=%h\ncipher=%h",in, key, cipher);
    // expecting: 00112233445566778899aabbccddeeff
    #1
    $finish;
end

endmodule