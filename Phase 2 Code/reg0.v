`timescale 1ns/10ps


module reg0(
  input clk,
  input clr,
  input enable,
  input [31:0] input_D,
  input BaOut,
  output reg [31:0] BusMuxIn_R0
  );
  wire [31:0] output_Q;
  
  initial BusMuxIn_R0 = 0;
  gen_reg32 r(clk,clr,enable,input_D,output_Q);
  
  always @(posedge clk)
    begin
      if (BaOut)
        BusMuxIn_R0 = 32'b0;
      else
        BusMuxIn_R0 = output_Q;
    end
endmodule