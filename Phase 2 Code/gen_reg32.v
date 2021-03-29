`timescale 1ns/10ps

module gen_reg32 (
  input clk,
  input clr,
  input enable,
  input [31:0] input_D,
  output reg [31:0] output_Q
  );
  
  always @(posedge clk)
    begin
      if (clr)
      	output_Q = 0;
      else if (enable)
      	output_Q <= input_D;
    end
endmodule