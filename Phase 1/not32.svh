`timescale 1ns/10ps

module not32(
  input [31:0] in,
  output [31:0] out
);
  
  genvar i;
  generate
    for(i=0; i < 32; i=i+1)
      begin : loop
       	assign out[i] = !in[i];
      end
  endgenerate
endmodule
