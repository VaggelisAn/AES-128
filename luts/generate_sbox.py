#         Implementation of the AES-128 Encryptor     #
#             sbox LUT Generation Script              #
# Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502 #

#  This script generates the sbox LUT.
import numpy as np

# ----------------------------------------------
# Calculate Multiplicative Inverse, as described in the following stackoverflow:
# https://stackoverflow.com/questions/45442396/a-pure-python-way-to-calculate-the-multiplicative-inverse-in-gf28-using-pytho
def gf_degree(a) :
   res = 0
   a >>= 1
   while (a != 0) :
      a >>= 1
      res += 1
   return res

def gf_invert(a, mod=0x11B) :
   v = mod
   g1 = 1
   g2 = 0
   j = gf_degree(a) - 8

   while (a != 1) :
      if (j < 0) :
         a, v = v, a
         g1, g2 = g2, g1
         j = -j

      a ^= v << j
      g1 ^= g2 << j

      a %= 256  # Emulating 8-bit overflow
      g1 %= 256 # Emulating 8-bit overflow

      j = gf_degree(a) - gf_degree(v)

   if(g1 < 0):
      g1 += mod
   return g1

# Test:
#print("Test gf_invert(x):")
#print(gf_invert(5))
#print(gf_invert(82))
#print(gf_invert(1))
#print(gf_invert(149))
# ----------------------------------------------

#Performs the bit scrambling transformation:
#b'i = bi (+) b(i+4) mod 8 (+) b(i+5) mod 8 (+) b(i+6) mod 8 (+) b(i+7) mod 8 (+) c    
def bit_scrambling(b, c=0x63):
    transformed_byte = 0
    
    # Iterate over each bit position i (0 to 7)
    for i in range(8):
        # Extract the i-th bit of b
        bi = (b >> i) & 1
        # Perform XOR with the specified shifted bits
        b_i_4 = (b >> ((i + 4) % 8)) & 1
        b_i_5 = (b >> ((i + 5) % 8)) & 1
        b_i_6 = (b >> ((i + 6) % 8)) & 1
        b_i_7 = (b >> ((i + 7) % 8)) & 1
        
        # XOR all together along with the constant c (on the i-th bit of c)
        transformed_bit = bi ^ b_i_4 ^ b_i_5 ^ b_i_6 ^ b_i_7 ^ ((c >> i) & 1)
        
        # Set the transformed bit in the result
        transformed_byte |= (transformed_bit << i)
    
    return transformed_byte

# - - - Generate sbox - - -
# 1. Generate the following table:
# [00,01,02,...,0F], 
# [10,11,12,...,1F],
# [...............],
# [F0,F1,F2,...,FF]
sbox = [[f"{i:X}{j:X}" for j in range(16)] for i in range(16)]

#print("Generate starting matrix:\n", np.matrix(sbox))

# 2. Find the Multiplicative Inverse of the table in GF(2^8)
# Our gf_invert function works on dec numbers,
# so we first convert into dec, get the MI inverse of the dec,
# and convert back to hex:
for row in range(16):
   for col in range(16):
      if (row==0 and col==0):
         sbox[0][0] = '0x0'
      else:
         hex_num = sbox[col][row]
         dec_num = int(hex_num, 16)
         MI_dec = gf_invert(dec_num)
         sbox[col][row] = hex(MI_dec)
#print("MI Matrix\n", np.matrix(sbox))

# 3. Apply Bit-Scrambling by applying the following bit transformation:
# bi = bi (+) b(i+4)mod8 (+) b(i+5)mod8 (+) b(i+6)mod8 (+) b(i+7)mod8 (+) c
# where c = 0x63
for row in range(16):
   for col in range(16):
      scrambled_int = bit_scrambling( (int(sbox[col][row], 16)) )
      sbox[col][row] = hex(scrambled_int)

#print("Matrix after bit-scrambling:", np.matrix(sbox))