`timescale 1ns/10ps

module ra (
  input clk,
  input clr,
  input enable,
  input [31:0] input_D,
  output reg [31:0] output_Q,
  input enable2
  );
  
  always @(posedge clk)
    begin
      if (clr)
      	output_Q = 0;
      else if (enable)
      	output_Q <= input_D;
      else if (enable2)
        output_Q <= input_D;
    end
endmodule