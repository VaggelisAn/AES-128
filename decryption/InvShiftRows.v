/**         Implementation of the AES-128 Encryptor     **/
/**              InvShiftRows Module                    **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

// Simply reversed the order of the assignements

`timescale 1ns / 1ps

module InvShiftRows(in, out);
input [127:0] in;
output [127:0] out;

assign out[127:120] =   in[127:120];
assign out[87:80]   =   in[119:112];
assign out[47:40]   =   in[111:104];
assign out[7:0]     =   in[103:96];

assign out[95:88]   =   in[95:88];	 
assign out[55:48]   =   in[87:80];	 
assign out[15:8]    =   in[79:72];	 
assign out[103:96]  =   in[71:64];

assign out[63:56]   =   in[63:56];	 
assign out[23:16]   =   in[55:48];	 
assign out[111:104] =   in[47:40];	 
assign out[71:64]   =   in[39:32];

assign out[31:24]   =   in[31:24];	 
assign out[119:112] =   in[23:16];	 
assign out[79:72]   =   in[15:8];	 
assign out[39:32]   =   in[7:0];
	 
endmodule