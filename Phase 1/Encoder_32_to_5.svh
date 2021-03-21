`timescale 1ns/10ps

module Encoder_32_to_5 (

  input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,

  input HIout, LOout, zhighout, zlowout, PCout, MDRout, InPortout, Cout,

  output reg [4:0] Sout);

/*
  Always block runs whenever any variable changes.
  Checks if input is equal to 1.
  Sets output var S equal to 5 bit value signifying which value is one.
*/

always @ ( * )
  begin

    if (R0out == 1'b1)
      Sout <= 5'b0_0000;
    else if (R1out == 1'b1)
      Sout <= 5'b0_0001;
    else if (R2out == 1'b1)
      Sout <= 5'b0_0010;
    else if (R3out == 1'b1)
      Sout <= 5'b0_0011;
    else if (R4out == 1'b1)
      Sout <= 5'b0_0100;
    else if (R5out == 1'b1)
      Sout <= 5'b0_0101;
    else if (R6out == 1'b1)
      Sout <= 5'b0_0110;
    else if (R7out == 1'b1)
      Sout <= 5'b0_0111;
    else if (R8out == 1'b1)
      Sout <= 5'b0_1000;
    else if (R9out == 1'b1)
      Sout <= 5'b0_1001;
    else if (R10out == 1'b1)
      Sout <= 5'b0_1010;
    else if (R11out == 1'b1)
      Sout <= 5'b0_1011;
    else if (R12out == 1'b1)
      Sout <= 5'b0_1100;
    else if (R13out == 1'b1)
      Sout <= 5'b0_1101;
    else if (R14out == 1'b1)
      Sout <= 5'b0_1110;
    else if (R15out == 1'b1)
      Sout <= 5'b0_1111;

    else if (HIout == 1'b1)
      Sout <= 5'b1_0000;
    else if (LOout == 1'b1)
      Sout <= 5'b1_0001;
    else if (zhighout == 1'b1)
      Sout <= 5'b1_0010;
    else if (zlowout == 1'b1)
      Sout <= 5'b1_0011;
    else if (PCout == 1'b1)
      Sout <= 5'b1_0100;
    else if (MDRout == 1'b1)
      Sout <= 5'b1_0101;
    else if (InPortout == 1'b1)
      Sout <= 5'b1_0110;
    else if (Cout == 1'b1)
      Sout <= 5'b1_0111;

  end

endmodule