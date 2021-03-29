`timescale 1ns/10ps

module not32_TB;
  reg[31:0] in;
  wire[31:0] out;
  
  not32 not32(in,out);
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,not32);
    in<=32'b0000_0000_0000_0000_0000_0000_0000_0000;
    #5;
    in<=32'b0000_1111_0000_0000_0000_0000_0000_1111;
    #5;
    $finish;
  end
endmodule
		 
