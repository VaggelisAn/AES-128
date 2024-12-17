/**         Implementation of the AES-128 Encryptor     **/
/**              InvSubBytes Module                     **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

`timescale 1ns / 1ps
`include "inv_sbox.v"

module InvSubBytes(in, out);
input [127:0] in;
output [127:0] out;

inv_sbox inv_sbox[15:0] (.in(in), .out(out));

endmodule