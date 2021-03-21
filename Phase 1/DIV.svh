`timescale 1ns/10ps

module DIV (

  input [31:0] Q, Mi,
  output [31:0] result,
  output [31:0] remainder

);

reg [63:0] A;
reg [31:0] M;

reg [5:0] loop;


always @ ( * ) begin

  A[31:0] = Q;
  A[63:32] = 0;
  M[31:0] = Mi;

  for (loop = 0; loop < 32; loop = loop + 1) begin

    A = A << 1;

    A[63:32] = A[63:32] - M;

    if (A[63] == 1) begin
      A[63:32] = A[63:32] + M;
      A[0] = 0;
    end else begin
      A[0] = 1;
    end
  end

end

assign result = A[31:0];
assign remainder = A[63:32];

endmodule