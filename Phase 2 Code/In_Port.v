`timescale 1ns/10ps

module In_Port (
  input clk,
  input clr,
  input [31:0] input_D, //input unit
  output reg [31:0] output_Q //buxmuxinport
  );
  
  always @(posedge clk)
    begin
      if (clr)
      	output_Q = 0;
      else
      	output_Q <= input_D;
    end
endmodule