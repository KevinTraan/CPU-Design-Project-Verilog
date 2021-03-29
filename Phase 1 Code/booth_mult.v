`timescale 1ns / 1ps

module booth_mult (
    input [31:0] mult,
    input [31:0] multr,
    output reg [31:0] ZhighOut,
    output reg [31:0] ZlowOut

  );

  integer i;
  reg cb; //carry bit
  reg [1:0] mb;

  reg [33:0] P1; // answer store temp
  reg [33:0] P2; 
  reg [63:0] prod;
  
  initial begin
  		cb <= 0;
        prod <= 0;
        ZhighOut <= 0;
        ZlowOut <= 0;
  end
 

  wire [33:0] mult_pos_1 = {mult[31], mult[31], mult};
  wire [33:0] mult_neg_1 = -mult_pos_1;;
  wire [33:0] mult_pos_2 = { mult[31], mult, 1'b0 };
  wire [33:0] mult_neg_2 = -mult_pos_2;


  always @(*) begin


      for (i = 0; i < 16; i = i + 1) begin
          if (i==0)
              prod = {32'd0, multr};

          P1 = {prod[63], prod[63], prod[63:32]};

          mb = prod[1:0];

          case( {mb, cb} )
              3'b000: P2 = P1;
              3'b001: P2 = P1 + mult_pos_1;
              3'b010: P2 = P1 + mult_pos_1;
              3'b011: P2 = P1 + mult_pos_2;
              3'b100: P2 = P1 + mult_neg_2;
              3'b101: P2 = P1 + mult_neg_1;
              3'b110: P2 = P1 + mult_neg_1;
              3'b111: P2 = P1;
          endcase


          cb = prod[1];

          prod = {P2, prod[31:2]};

      end
      ZlowOut = prod[31:0]; 
      ZhighOut = prod[63:32]; 

  end
endmodule