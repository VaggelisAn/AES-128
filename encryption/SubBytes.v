/**         Implementation of the AES-128 Encryptor     **/
/**                 SubBytes Module                     **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

// SubBytes substitutes each byte of the state using a substitution table (S-box)

`timescale 1ns / 1ps

module SubBytes(in, out);
input [127:0] in;
output [127:0] out;

`include "sbox.v"

genvar i;
generate
    for (i=1; i <= 16; i=i+1) begin : SubBytesLoop
        assign out[(8*i)-1-:8] = sbox(in[(8*i)-1-:8]);
    end
endgenerate

endmodule