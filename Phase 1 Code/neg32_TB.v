`timescale 1ns/10ps

module negate32_TB;
  reg[31:0] in;
  wire[31:0] out;
  
  neg32 neg32(in,out);
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,neg32);
	  in=32'h00000000; 	// z=32'h00000000
	  #5;
      in=32'hAAAAAAAA; 	// z=32'h55555556
	  #5;
      in=32'hFFFFFFFF; 	// z=32'h00000001
      #5;
    $finish;
  end
endmodule
		 
