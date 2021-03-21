`timescale 1ns/10ps

module rol32_TB;
  reg [31:0] in;
  reg [31:0] num_rotate;

  wire [31:0] out;
  
  rol32 rol32(in,num_rotate,out);
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,rol32);
    in <= 32'b0000_0000_0000_0000_0000_0000_0000_0001;
    num_rotate <= 1;
    #5;
    in <= 32'b0000_0000_0100_0000_0000_0000_0000_0000;
    num_rotate <= 30;
    #5;
    $finish;
  end	
endmodule
		 
