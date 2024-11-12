import numpy as np
from generate_mult_luts import mult2

def rcon_recursion(rcon, j):
    rcon[j][0] = mult2(rcon[j-1][0])
    if (j<9):
        rcon_recursion(rcon, j+1)
    else:
        return

def calc_rcon():
    rcon = np.zeros((10, 4), dtype=int)
    rcon[0][0] = 1
    rcon_recursion(rcon, 1)

    for i in range(10):
        print(f"{hex(rcon[i][0])} {hex(rcon[i][1])} {hex(rcon[i][2])} {hex(rcon[i][3])}")

    for i in range(10):
        print(f"4'h{hex(i)[2:]}: rcon=32'h{hex(rcon[i][0])[2:]}000000;")

calc_rcon()