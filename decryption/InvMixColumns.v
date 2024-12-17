/**         Implementation of the AES-128 Encryptor     **/
/**              InvMixColumns Module                   **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

/* 
MixColumns calculates the following equations:
[e b d 9]
[9 e b d] (+) S' = S
[d 9 e b] 
[b d 9 e]

where S is the state matrix before Mixing Columns and S' is the state matrix after Mixing Columns
*/

`define USE_LUTS

module InvMixColumns(in, out);
input [127:0] in;
output [127:0] out;

// define USE_LUTS to use LUTS for the multiplication, instead of calculating then.
`ifdef USE_LUTS
    `include "..\\gf_multiplication_luts.v"
`else
    `include "..\\gf_multiplication.v"
`endif

genvar i;
generate
for(i=0;i< 4;i=i+1) begin : m_col
    assign out[(i*32 + 24)+:8]  = multe(in[(i*32 + 24)+:8]) ^ multb(in[(i*32 + 16)+:8]) ^ multd(in[(i*32 + 8)+:8]) ^ mult9(in[i*32+:8]);
	assign out[(i*32 + 16)+:8]  = mult9(in[(i*32 + 24)+:8]) ^ multe(in[(i*32 + 16)+:8]) ^ multb(in[(i*32 + 8)+:8]) ^ multd(in[i*32+:8]);
	assign out[(i*32 + 8)+:8]   = multd(in[(i*32 + 24)+:8]) ^ mult9(in[(i*32 + 16)+:8]) ^ multe(in[(i*32 + 8)+:8]) ^ multb(in[i*32+:8]);
    assign out[i*32+:8]         = multb(in[(i*32 + 24)+:8]) ^ multd(in[(i*32 + 16)+:8]) ^ mult9(in[(i*32 + 8)+:8]) ^ multe(in[i*32+:8]);
end
endgenerate
endmodule