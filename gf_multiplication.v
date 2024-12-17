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
    mult3 = mult2(in) ^ in;
endfunction

// 9x = (8+1)x = (2*2*2 + 1)x
function [7:0] mult9;
    input [7:0] in;
    mult9 = mult2(mult2(mult2(in))) ^ in;
endfunction

// (0xb)x = (9+2)x
function [7:0] multb;
    input [7:0] in;
    multa = mult9(in) ^ mult2(in);
endfunction 

// (0xd)x = ((0xa)+2)x
function [7:0] multd;
    input [7:0] in;
    multd = multa(in) ^ mult2(in);
endfunction 

// (0xe)x = ((0xd)+1)x
function [7:0] multe;
    input [7:0] in;
    multe = multd(in) ^ in;
endfunction 