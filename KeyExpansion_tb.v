`include "KeyExpansion.v"

// Using the below tool to cross-check results:
// https://legacy.cryptool.org/en/cto/aes-step-by-step

module KeyExpansion_tb;

reg [127:0] key;
wire [1407:0] RoundKeys;   

KeyExpansion KeyExpansion(.key(key), .RoundKeys(RoundKeys));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, KeyExpansion_tb);
    key = 128'h0;
    #250
    $display("key = \n%h", key);
    $display("RoundKeys = \n%h", RoundKeys);
    #1
    key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
    #250
    $display("key = \n%h", key);
    $display("RoundKeys = \n%h", RoundKeys);

// with key = 0, expecting:
// 00000000000000000000000000000000
// 626363636263636362636363626363639b9898c9f9fbfbaa9b9898c9f9fbfbaa
// 90973450696ccffaf2f457330b0fac99ee06da7b876a1581759e42b27e91ee2b
// 7f2e2b88f8443e098dda7cbbf34b9290ec614b851425758c99ff09376ab49ba7
// 217517873550620bacaf6b3cc61bf09b0ef903333ba9613897060a04511dfa9f
// b1d4d8e28a7db9da1d7bb3de4c664941b4ef5bcb3e92e21123e951cf6f8f188e

// with key = 2b7e151628aed2a6abf7158809cf4f3c, expecting:
// 2b7e151628aed2a6abf7158809cf4f3ca0fafe1788542cb123a339392a6c7605
// f2c295f27a96b9435935807a7359f67f3d80477d4716fe3e1e237e446d7a883b
// ef44a541a8525b7fb671253bdb0bad00d4d1c6f87c839d87caf2b8bc11f915bc
// 6d88a37a110b3efddbf98641ca0093fd4e54f70e5f5fc9f384a64fb24ea6dc4f
// ead27321b58dbad2312bf5607f8d292fac7766f319fadc2128d12941575c006e
// d014f9a8c9ee2589e13f0cc8b6630ca6
    $finish;
end 
endmodule