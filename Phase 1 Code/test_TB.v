`timescale 1ns/10ps

module test_TB;
  reg [11:0] ALUControl;
  reg [31:0] A, B;
  reg [31:0] zlow, zhigh;
  
    
  ALU alu(ALUControl, A, B, zlow,zhigh);
  
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, alu);
    #40;
    ALUControl <= 12'b0001_0000_0000;
    A <= 32'd0011_0011_0000_0000_0000_0000_0000_0000; 
    B <= 32'd0101_0101_0000_0000_0000_0000_0000_0000;
    #40;

    $finish;
  end	
endmodule
