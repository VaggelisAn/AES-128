
// Implementation of the AES-128 Encryptor
// Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502

// https://csrc.nist.gov/files/pubs/fips/197/final/docs/fips-197.pdf

`timescale 1ns / 1ps

module aes_128_encryptor(clk, cipher_in, key_in, data_out);
input clk;
input [127:0] cipher_in;
input [127:0] key_in;
output [127:0] data_out;



endmodule