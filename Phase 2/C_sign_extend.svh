module C_sign_extend(
  input [31:0] in,
  output reg [31:0] out
);
 
  always @ (*) begin
    out <= {{13{in[18]}},{in[18:0]}};
  end
endmodule
  