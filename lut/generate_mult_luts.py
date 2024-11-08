#         Implementation of the AES-128 Encryptor                   #
#     Multiplication with 2 and 3 in GF(2^8) LUT Generation Script  #
#       Vaggelis Ananiadis 03409, Nikh-Maria Kalantzh 03502         #

# Finite field arithmetic explained here:
# https://en.wikipedia.org/wiki/Finite_field_arithmetic

# multiplication by 2 in the finite fields is:
# shifting one bit to the left, 
# and if the original 8 bits had a 1 at the MSB,
# xor the result with 0x1b = 27
def mult2(byte_in):
    byte_out = byte_in << 1
    if (byte_in >> 7) == 1:
        byte_out = byte_out ^ 27
    byte_out %= 256 # Emulating 8-bit overflow
    return byte_out

# multiplication by 3 is done by:		
# multiplication by {02} xor (the original 8 bits)
def mult3(byte_in):
    byte_out = mult2(byte_in) ^ byte_in
    byte_out %= 256 # Emulating 8-bit overflow
    return byte_out

def print_mult2():
    print("Generate LUT for multiplication in the finite fields with 2:")
    for i in range(256):
        hex_i = hex(i)[2:]
        hex_mult2_i = hex(mult2(i))[2:]
        print(f"8'h{hex_i}: out=8'h{hex_mult2_i}")

def print_mult3():
    print("Generate LUT for multiplication in the finite fields with 3:")
    for i in range(256):
        hex_i = hex(i)[2:]
        hex_mult3_i = hex(mult3(i))[2:]
        print(f"8'h{hex_i}: out=8'h{hex_mult3_i}")

print_mult2()
print_mult3()