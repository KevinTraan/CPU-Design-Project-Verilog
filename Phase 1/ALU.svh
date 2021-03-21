`timescale 1ns/10ps

module ALU(
     input [11:0] ALUControl,
     input [31:0] A, B,
     output [31:0] zlow, zhigh);

  wire [31:0] zlowAND, zhighAND,
              zlowOR, zhighOR,
              zlowNOT, zhighNOT,
              zlowSUB, zlowADD,
  			  zlowNEG, zhighNEG;
  
  wire zhighADD, zhighSUB;
  
  wire [31:0] zlowMUL, zhighMUL,
              zlowDIV, zhighDIV,
              zlowSHR, zhighSHR,
              zlowSHL, zhighSHL,
              zlowROR, zhighROR,
              zlowROL, zhighROL;

  reg [31:0] zlowTemp, zhighTemp;
    /*
      ALUControl signal meaning
      complete operation when bit number is 1
      ADD - 0
      SUB - 1
      MUL - 2
      DIV - 3
      SHR - 4
      SHL - 5
      ROR - 6
      ROL - 7
      AND - 8
      OR  - 9
      NEG - 10
      NOT - 11
    */

     adder32 ADD(A,B,1'b0,zlowADD,zhighADD);
     sub32 SUB(A,B,1'b0,zlowSUB,zhighSUB);
     DIV DIVIDER(A,B,zlowDIV,zhighDIV);
     ShiftRight SHR(A,B,zlowSHR);
     ShiftLeft SHL(A,B,zlowSHL);
     ror32 ROR(A,B,zlowROR);
     rol32 ROL(A,B,zlowROL);
     neg32 NEG(B,zlowNEG);
     not32 NOT(B,zlowNOT);
  	 booth_mult MUL(A,B,zhighMUL,zlowMUL);


     	always @ * begin
        if(ALUControl == 12'b0000_0000_0001) begin
    			zlowTemp <= zlowADD;
         	    zhighTemp <= zhighADD;
        end else if(ALUControl == 12'b0000_0000_0010) begin
    			zlowTemp <= zlowSUB;
    			zhighTemp <= zhighSUB;
        end else if(ALUControl == 12'b0000_0000_0100) begin
          zlowTemp <= zlowMUL;
          zhighTemp <= zhighMUL;
  		end else if(ALUControl == 12'b0000_0000_1000) begin
          zlowTemp <= zlowDIV;
          zhighTemp <= zhighDIV;
        end else if(ALUControl == 12'b0000_0001_0000) begin
          zlowTemp <= zlowSHR;
          zhighTemp <= 32'd0;
        end else if(ALUControl == 12'b0000_0010_0000) begin
          zlowTemp <= zlowSHL;
          zhighTemp <= 32'd0;
        end else if(ALUControl == 12'b0000_0100_0000) begin
          zlowTemp <= zlowROR;
          zhighTemp <= 0;
        end else if(ALUControl == 12'b0000_1000_0000) begin
          zlowTemp <= zlowROL;
          zhighTemp <= 0;
        end else if(ALUControl == 12'b0001_0000_0000) begin
      	  zlowTemp <= A & B;
          zhighTemp <= 32'b0;
        end else if(ALUControl == 12'b0010_0000_0000) begin
          zlowTemp <= A | B;
          zhighTemp <= 0;
        end else if(ALUControl == 12'b0100_0000_0000) begin
          zlowTemp <= zlowNEG;
          zhighTemp <= 0;
        end else if(ALUControl == 12'b1000_0000_0000) begin
          zlowTemp <= zlowNOT;
          zhighTemp <= 0;
  	   end

    end

    assign zlow = zlowTemp;
  	assign zhigh = zhighTemp;

  endmodule
