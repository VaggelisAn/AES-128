/**         Implementation of the AES-128 Encryptor     **/
/**                 AES-128 Encryptor Module            **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

`timescale 1ns / 1ps

/*  Here we implement the aes-128 encryptor, based on the specifications provided
    by the National Institute of Standards and Technology: 
    https://csrc.nist.gov/files/pubs/fips/197/final/docs/fips-197.pdf

    Moreover, we are following the slides provided by the Purdue University:
    https://engineering.purdue.edu/kak/compsec/NewLectures/Lecture8.pdf

    AES on wikipedia:
    https://en.wikipedia.org/wiki/Advanced_Encryption_Standard
*/
`include "KeyExpansion.v"
`include "AddRoundKey.v"
`include "SubBytes.v"
`include "ShiftRows.v"
`include "MixColumns.v"

module AES_128_Encryptor(in, key, cipher);
input [127:0] in;
input [127:0] key;
output [127:0] cipher;

wire [1407:0] RoundKeys;

wire [127:0] state [0:11];

wire [127:0] afterSubBytes [1:11]; 
wire [127:0] afterShiftRows [1:11]; 
wire [127:0] afterMixColumns [1:10]; 
wire [127:0] afterRoundKey [1:11];

// Generate key schedule
KeyExpansion KeyExpansion(key, RoundKeys);

AddRoundKey AddRoundKey0(.in(in), .key(RoundKeys[1407-:128]), .out(state[0]));

genvar i;
generate
	for(i=1; i<10; i=i+1) begin : encryptionLoop
        SubBytes SubBytes(.in(state[i-1]), .out(afterSubBytes[i]));
        ShiftRows ShiftRows(.in(afterSubBytes[i]), .out(afterShiftRows[i]));
        MixColumns MixColumns(.in(afterShiftRows[i]), .out(afterMixColumns[i]));
        AddRoundKey AddRoundKey(.in(afterMixColumns[i]), .key(RoundKeys[(128 * (10-i)) + 127 -: 128]), .out(state[i]));	
    end
endgenerate

SubBytes SubBytes10(.in(state[9]), .out(afterSubBytes[10]));
ShiftRows ShiftRows10(.in(afterSubBytes[10]), .out(afterShiftRows[10]));
AddRoundKey AddRoundKey10(.in(afterShiftRows[10]), .key(RoundKeys[127:0]), .out(state[10]));	

assign cipher = state[10];

endmodule