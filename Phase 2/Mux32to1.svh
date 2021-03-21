`timescale 1ns / 1ps

module Mux32to1 (

  input [31:0] R0MuxIn, R1MuxIn, R2MuxIn, R3MuxIn, R4MuxIn, R5MuxIn, R6MuxIn, R7MuxIn, R8MuxIn, R9MuxIn, R10MuxIn, R11MuxIn, R12MuxIn, R13MuxIn, R14MuxIn, R15MuxIn,

  input [31:0] HIMuxIn, LOMuxIn, zhighMuxIn, zlowMuxIn, PCMuxIn, MDRMuxIn, InPortMuxIn, CMuxIn,

  input reg [4:0] Scode,

  output reg [31:0] BusMuxOut);

/*
  Always block runs whenever any variable changes.
  Checks if Scode is equal to a registers designated code.
  output value of register that sCode designates.
*/

  always @ ( * ) begin

    if (Scode == 5'b0_0000)
      BusMuxOut <= R0MuxIn;
    else if (Scode == 5'b0_0001)
      BusMuxOut <= R1MuxIn;
    else if (Scode == 5'b0_0010)
      BusMuxOut <= R2MuxIn;
    else if (Scode == 5'b0_0011)
      BusMuxOut <= R3MuxIn;
    else if (Scode == 5'b0_0100)
      BusMuxOut <= R4MuxIn;
    else if (Scode == 5'b0_0101)
      BusMuxOut <= R5MuxIn;
    else if (Scode == 5'b0_0110)
      BusMuxOut <= R6MuxIn;
    else if (Scode == 5'b0_0111)
      BusMuxOut <= R7MuxIn;
    else if (Scode == 5'b0_1000)
      BusMuxOut <= R8MuxIn;
    else if (Scode == 5'b0_1001)
      BusMuxOut <= R9MuxIn;
    else if (Scode == 5'b0_1010)
      BusMuxOut <= R10MuxIn;
    else if (Scode == 5'b0_1011)
      BusMuxOut <= R11MuxIn;
    else if (Scode == 5'b0_1100)
      BusMuxOut <= R12MuxIn;
    else if (Scode == 5'b0_1101)
      BusMuxOut <= R13MuxIn;
    else if (Scode == 5'b0_1110)
      BusMuxOut <= R14MuxIn;
    else if (Scode == 5'b0_1111)
      BusMuxOut <= R15MuxIn;

    else if (Scode == 5'b1_0000)
      BusMuxOut <= HIMuxIn;
    else if (Scode == 5'b1_0001)
      BusMuxOut <= LOMuxIn;
    else if (Scode == 5'b1_0010)
      BusMuxOut <= zhighMuxIn;
    else if (Scode == 5'b1_0011)
      BusMuxOut <= zlowMuxIn;
    else if (Scode == 5'b1_0100)
      BusMuxOut <= PCMuxIn;
    else if (Scode == 5'b1_0101)
      BusMuxOut <= MDRMuxIn;
    else if (Scode == 5'b1_0110)
      BusMuxOut <= InPortMuxIn;
    else if (Scode == 5'b1_0111)
      BusMuxOut <= CMuxIn;
  end

  
endmodule