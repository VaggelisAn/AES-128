/**         Implementation of the AES-128 Encryptor     **/
/**                 MixColumns Module                   **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

module MixColumns(in, out);
input [127:0] in;
output [127:0] out;

/*  multiplication by 2 in the finite fields is calculated by:   
    shifting one bit to the left, 
    and if the original 8 bits had a 1 at the MSB,   
    xor the result with 0x1b = 27    */
function [7:0] mult2;
	input [7:0] in;
	begin 
        if  (in[7] == 1) mult2 = ((in << 1) ^ 8'h1b);
        else mult2 = in << 1; 
	end 	
endfunction

/*  multiplication by 3 is done by:
    (multiplying the original 8 bits by 0x02) xor (the original 8 bits) */
function [7:0] mult3; //multiply by 3 
	input [7:0] in;
	begin 		
        mult3 = mult2(in) ^ in;
	end 
endfunction


/* Describing the following equations:
s0,c′​=((02)⋅s0,c​)(+)((03)⋅s1,c​)(+)s2,c​(+)s3,c​
s1,c′=s0,c(+)((02)⋅s1,c)(+)((03)⋅s2,c)(+)s3,c
s1,c′​=s0,c​(+)((02)⋅s1,c​)(+)((03)⋅s2,c​)(+)s3,c​
s2,c′=s0,c(+)s1,c(+)((02)⋅s2,c)(+)((03)⋅s3,c)
s2,c′​=s0,c​(+)s1,c​(+)((02)⋅s2,c​)(+)((03)⋅s3,c​)
s3,c′=((03)⋅s0,c)(+)s1,c(+)s2,c(+)((02)⋅s3,c)
s3,c′​=((03)⋅s0,c​)(+)s1,c​(+)s2,c​(+)((02)⋅s3,c​)
*/

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