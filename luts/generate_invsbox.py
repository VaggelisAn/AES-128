#         Implementation of the AES-128 Encryptor     #
#         inv sbox LUT Generation Script              #
# Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 #

# This script generates the inverse sbox lut.

import numpy as np
from generate_sbox import sbox

# The following code is just an involved way to write the equation:
# inv_sbox[sbox[i]] = i

inv_sbox = [[""]*16 for i in range(16)]
for x in range(16):
    for y in range(16):
        if len(sbox[x][y]) == 3: # case where sbox[x][y] is a single digit hex, eg 0x4
            sbox_x = int("0", 16)
            sbox_y = int((sbox[x][y])[2], 16)
        else:  
            sbox_x = int((sbox[x][y])[2], 16)
            sbox_y = int((sbox[x][y])[3], 16)
        
        # simple example to describe the following line:
        # let x = 2, y = 1, so sbox[x][y] = fd
        # hex(x)[2] = f and hex(y)[2] = d (hex(x) would be 0xf, so we only get the final element)
        # use str() to concantenate the two hexes: "fd"
        # int(.., 16) converts "fd" to an int with base 16
        # and we finally store it as a hex number using hex()

        inv_sbox[sbox_x][sbox_y] = hex(int(str(hex(x)[2]) + str(hex(y)[2]), 16))

print(np.matrix(inv_sbox))