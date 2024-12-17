/**         Implementation of the AES-128 Decryptor     **/
/**                 AES-128 Decryptor Module            **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

`timescale 1ns / 1ps

`include "../encryption/KeyExpansion.v"
`include "../encryption/AddRoundKey.v"
`include "InvSubBytes.v"
`include "InvShiftRows.v"
`include "InvMixColumns.v"

module AES_128_Decryptor(in, key, cipher);
input [127:0] in; // cipher to be decrypted
input [127:0] key;
output [127:0] cipher;

wire [1407:0] RoundKeys; 

wire [127:0] state [0:11]; // state

wire [127:0] afterInvSubBytes [0:9]; 
wire [127:0] afterInvShiftRows [0:9]; 
wire [127:0] afterInvMixColumns [0:9]; 
wire [127:0] afterRoundKey [0:11];

// Generate key schedule
KeyExpansion KeyExpansion(key, RoundKeys);

AddRoundKey AddRoundKey0(.in(in), .key(RoundKeys[127:0]), .out(state[10]));

genvar i;
generate
	for(i=9; i>0; i=i-1) begin : decryptionLoop
        InvShiftRows InvShiftRows(.in(state[i+1]), .out(afterInvShiftRows[i]));
        InvSubBytes InvSubBytes(.in(afterInvShiftRows[i]), .out(afterInvSubBytes[i]));
        AddRoundKey AddRoundKey(.in(afterInvSubBytes[i]), .key(RoundKeys[(128 * (10-i)) + 127 -: 128]), .out(afterRoundKey[i]));	
        InvMixColumns InvMixColumns(.in(afterRoundKey[i]), .out(state[i]));
    end
endgenerate

InvShiftRows InvShiftRows(.in(state[1]), .out(afterInvShiftRows[0]));
InvSubBytes InvSubBytes(.in(afterInvShiftRows[0]), .out(afterInvSubBytes[0]));
AddRoundKey AddRoundKey(.in(afterInvSubBytes[0]), .key(RoundKeys[1407:1280]), .out(state[0]));	

// Output is stored in cipher
assign cipher = state[0];

endmodule