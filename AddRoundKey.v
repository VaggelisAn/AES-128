/**         Implementation of the AES-128 Encryptor     **/
/**               AddRoundKey Module                    **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

module AddRoundKey(in, key, out);

input [127:0] in;
input [127:0] key;
output [127:0] out;

assign out = key ^ in;

endmodule