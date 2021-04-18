`timescale 1ns/10ps

module pc_reg #(parameter VAL = 0)(
  input clk,
  input clr,
  input enable,
  input brIn,
  input [31:0] input_D,
  input select,
  output reg [31:0] output_Q
  );
  initial output_Q = VAL;
  always @(posedge clk)
    begin
      if (enable) begin
        if(brIn) begin
          if(select) begin
            output_Q <= input_D;
          end
        end
        else begin
          output_Q <= input_D;
        end
      end
    end
endmodule