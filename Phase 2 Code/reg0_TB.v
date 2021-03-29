`timescale 1ns/10ps

module R0_TB;
  reg clk;
  reg  clr;
  reg enable;
  reg [31:0] input_D;
  reg BaOut;
  wire [31:0] BusMuxIn_R0;
  
  clock clock(clk);
  reg0 reg0(clk, clr, enable, input_D, BaOut, BusMuxIn_R0);
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, reg0);
    BaOut = 1;
    enable = 1;
    clr = 0;
    #40;
    input_D = 10;
    #40;
    BaOut = 0;
    input_D = 20;
    #40;
    BaOut = 1;
    #40
    $finish;
  end	
endmodule