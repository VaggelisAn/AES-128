/**         Implementation of the AES-128 Encryptor     **/
/**                 AES-128 Encryptor Module            **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

`timescale 1ns / 1ps

/*  Here we implement the aes-128 encryptor, based on the specifications provided
    by the National Institute of Standards and Technology: 
    https://csrc.nist.gov/files/pubs/fips/197/final/docs/fips-197.pdf

    Pseudocode for the Cipher, as described in chapter 5.1:
    Cipher(byte in[4*4], byte out[4*4], word w[4*(10+1)])
    begin
        byte state[4,4]
        state = in
        AddRoundKey(state, w[0, 4-1]) // See Sec. 5.1.4
        for round = 1 step 1 to 10–1
            SubBytes(state) // See Sec. 5.1.1
            ShiftRows(state) // See Sec. 5.1.2
            MixColumns(state) // See Sec. 5.1.3
            AddRoundKey(state, w[round*4, (round+1)*4-1])
        end for
        SubBytes(state)
        ShiftRows(state)
        AddRoundKey(state, w[10*4, (10+1)*4-1])
        out = state
    end

    We assign the following paramater values:
    Nk = 4words = 128bits (key length)
    Nb = 4words = 128bits (block size)
    Nr = 10 (number of rounds)
*/


module aes_128_encryptor(clk, state, key, cipher);
input clk;
input [127:0] state;
input [127:0] key;
output [127:0] cipher;

wire [127:0] RoundKey_out;

//AddRoundKey(.in(state), .key(key[3, 0]), .out(RoundKey_out))

endmodule