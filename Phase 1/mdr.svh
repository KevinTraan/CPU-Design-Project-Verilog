`timescale 1ns/10ps


module mdr(
  input select,
  input [31:0] input_0,
  input [31:0] input_1,
  input clr,
  input clk,
  input enable_MDRin,
  output reg [31:0] output_Q
  );
  
  wire [31:0] output_MUX;
  

  mux2to1 mux2to1(select,input_0,input_1,output_MUX);
  gen_reg32 r(clk,clr,enable_MDRin,output_MUX,output_Q);

endmodule