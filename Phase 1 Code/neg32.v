`timescale 1ns/10ps

module neg32(
  input [31:0] in,
  output [31:0] out
);
  wire [31:0] temp;
  wire cout0;
 
  not32 not32(in,temp);
  adder32 adder32(temp,32'b1,1'b0,out,cout0);
  
  
endmodule