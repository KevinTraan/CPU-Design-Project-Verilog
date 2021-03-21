`timescale 1ns/10ps

//mux2to1 mux2to1(read,input_0,input_1,output_MUX);

module mux2to1(
  input read,
  input [31:0] input_0,
  input [31:0] input_1,
  output reg [31:0] output_MUX
  );
  
  always @ (posedge read)
  	begin
      case(read)
        0: output_MUX <= input_0;
        1: output_MUX <= input_1;
      endcase
    end
endmodule