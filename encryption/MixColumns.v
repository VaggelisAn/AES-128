/**         Implementation of the AES-128 Encryptor     **/
/**                 MixColumns Module                   **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

/* 
MixColumns calculates the following equations:
[2 3 1 1]
[1 2 3 1] (+) S = S'
[1 1 2 3] 
[3 1 1 2]

where S is the state matrix before Mixing Columns and S' is the state matrix after Mixing Columns.
*/

`define USE_LUTS

module MixColumns(in, out);
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

    assign out[(i*32 + 24)+:8]= mult2(in[(i*32 + 24)+:8]) ^ mult3(in[(i*32 + 16)+:8]) ^ in[(i*32 + 8)+:8] ^ in[i*32+:8];
	assign out[(i*32 + 16)+:8]= in[(i*32 + 24)+:8] ^ mult2(in[(i*32 + 16)+:8]) ^ mult3(in[(i*32 + 8)+:8]) ^ in[i*32+:8];
	assign out[(i*32 + 8)+:8]= in[(i*32 + 24)+:8] ^ in[(i*32 + 16)+:8] ^ mult2(in[(i*32 + 8)+:8]) ^ mult3(in[i*32+:8]);
    assign out[i*32+:8]= mult3(in[(i*32 + 24)+:8]) ^ in[(i*32 + 16)+:8] ^ in[(i*32 + 8)+:8] ^ mult2(in[i*32+:8]);

end
endgenerate
endmodule