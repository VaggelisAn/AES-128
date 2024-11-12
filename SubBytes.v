/**         Implementation of the AES-128 Encryptor     **/
/**                 SubBytes Module                     **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

`timescale 1ns / 1ps
`include "lut//sbox.v"
// TODO add explanation


module SubBytes(in, out);
input [127:0] in;
output [127:0] out;

// Pretty cool way of instantiating multiple modules:
// https://stackoverflow.com/a/41202603
// "This syntax will work as long as they're integer multiples of how they're declared in the module; 
// they'll be spread evenly among each instance, 
// otherwise synthesis will throw an error."
sbox sbox[15:0] (.in(in), .out(out));

endmodule