`timescale 1ns/10ps

module gen_reg32_TB;
  reg clk;
  reg  clr;
  reg enable;
  reg [31:0] input_D;
  wire [31:0] output_Q;
  
  clock clock(clk);
  gen_reg32 gen_reg32(clk, clr, enable, input_D, output_Q);
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, gen_reg32);
    
    enable = 0;
    clr = 0;
    input_D = 10;
    #10;
    
    enable = 1;
    input_D = 20;
    #10;

    input_D = 30;
    #10;

    enable = 0;
    input_D = 40;
    #10;
    
    clr = 1;
    #10;
    
    $finish;
  end	
endmodule