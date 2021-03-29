`timescale 1ns/10ps

module test_TB;
  reg [11:0] ALUControl;
  reg [31:0] A, B;
  reg [31:0] zlow, zhigh;
  
    
  DIV div(A, B, zlow,zhigh);
  
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, div);
    #40;
    A <= 32'b0000_0000_0000_0000_0000_0000_0001_1010; 
    B <= 32'b0000_0000_0000_0000_0000_0000_0000_0101;
    #40;

    $finish;
  end	
endmodule