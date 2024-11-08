/**         Implementation of the AES-128 Encryptor     **/
/**                 SubBytes Module                     **/
/** Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 **/

`timescale 1ns / 1ps

module SubBytes(in, out);
input [127:0] in;
output [127:0] out;

sbox b0 (.in(in[127:120]),  .out(out[127:120])  );
sbox b1 (.in(in[119:112]),  .out(out[119:112])  );
sbox b2 (.in(in[111:104]),  .out(out[111:104])  );
sbox b3 (.in(in[103:96]),   .out(out[103:96])   );

sbox b4 (.in(in[95:88]),    .out(out[95:88])    );
sbox b5 (.in(in[87:80]),    .out(out[87:80])    );
sbox b6 (.in(in[79:72]),    .out(out[79:72])    );
sbox b7 (.in(in[71:64]),    .out(out[71:64])    );

sbox b8 (.in(in[63:56]),    .out(out[63:56])    );
sbox b9 (.in(in[55:48]),    .out(out[55:48])    );
sbox bA (.in(in[47:40]),    .out(out[47:40])    );
sbox bB (.in(in[39:32]),    .out(out[39:32])    );

sbox bC (.in(in[31:24]),    .out(out[31:24])    );
sbox bD (.in(in[23:16]),    .out(out[23:16])    );
sbox bE (.in(in[15:8]),     .out(out[15:8])     );
sbox bF (.in(in[7:0]),      .out(out[7:0])      );

endmodule