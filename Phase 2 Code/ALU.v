`timescale 1ns/10ps

module ALU(
     input [11:0] ALUControl,
     input [31:0] A, B,
     input reg IncPC,
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

  always @(posedge IncPC)
    begin
  		zlowTemp <= B + 1;
    end
  
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

module adder32(
	input [31:0] a,
	input [31:0] b,
	input wire cin,
	output wire[31:0] sum,
	output wire cout
	);
	
wire cout0;
adder16 CLA0(.a(a[15:0]),.b(b[15:0]),.cin(cin),.sum(sum[15:0]),.cout(cout0));
adder16 CLA1(.a(a[31:16]),.b(b[31:16]),.cin(cout0),.sum(sum[31:16]),.cout(cout));
  
endmodule

module adder16(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire cin,
	
	output wire [15:0] sum,
	output wire cout
	);
	
	wire cout0,cout1,cout2;

  adder4 CLA0(.a(a[3:0]),.b(b[3:0]),.cin(cin),.sum(sum[3:0]),.cout(cout0));
  adder4 CLA1(.a(a[7:4]),.b(b[7:4]),.cin(cout0),.sum(sum[7:4]),.cout(cout1));
  adder4 CLA2(.a(a[11:8]),.b(b[11:8]),.cin(cout1),.sum(sum[11:8]),.cout(cout2));
  adder4 CLA3(.a(a[15:12]),.b(b[15:12]),.cin(cout2),.sum(sum[15:12]),.cout(cout)); 

endmodule

module adder4(
	input wire [3:0] a,
	input wire [3:0] b,
	input wire cin,
	
	output wire[3:0] sum,
	output wire cout
	);

	wire [3:0] P,G,c;
 
	assign P=a^b;	//propagate signal
	assign G=a&b; 	//generate signal
	 
	assign c[0]= cin;
	assign c[1]= G[0] | (P[0]&c[0]);
	assign c[2]= G[1] | (P[1]&G[0]) | P[1]&P[0]&c[0];
	assign c[3]= G[2] | (P[2]&G[1]) | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&c[0];
	assign cout = G[3] | (P[3]&G[2]) | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&c[0];
	assign sum[3:0] =P^c;

endmodule

module sub32(
	input wire [31:0] a,
	input wire [31:0] b,
	input wire cin,

    output wire [31:0] sum,
	output wire cout
	);
	
  wire [31:0] temp;
  
  neg32 neg32(b,temp);
  adder32 adder32(a,temp,cin,sum,cout);	
endmodule

module rol32(

  input  [31:0] in,
  input  [31:0] num_rotate,

  output reg [31:0] out
);
  
   wire [4:0] temp;
    assign temp = num_rotate % 32;
  
	always@(*) begin
      case(temp)
				31:
                  out <= {in[0], in[31:1]};
				30:
                  out <= {in[1:0], in[31:2]};
				29:
                  out <= {in[2:0], in[31:3]};
				28: 	
                  out <= {in[3:0], in[31:4]};
				27: 	
                  out <= {in[4:0], in[31:5]};
				26: 	
                  out <= {in[5:0], in[31:6]};
				25: 	
                  out <= {in[6:0], in[31:7]};
				24: 	
                  out <= {in[7:0], in[31:8]};
				23: 	
                  out <= {in[8:0], in[31:9]};
				22: 	
                  out <= {in[9:0], in[31:10]};
				21: 	
                  out <= {in[10:0], in[31:11]};
				20: 	
                  out <= {in[11:0], in[31:12]};
				19: 	
                  out <= {in[12:0], in[31:13]};
				18: 	
                  out <= {in[13:0], in[31:14]};
				17: 	
                  out <= {in[14:0], in[31:15]};
				16:   
                  out <= {in[15:0], in[31:16]};
				15:   
                  out <= {in[16:0], in[31:17]};
				14:   
                  out <= {in[17:0], in[31:18]};
				13:   
                  out <= {in[18:0], in[31:19]};
				12:   
                  out <= {in[19:0], in[31:20]};
				11:   
                  out <= {in[20:0], in[31:21]};
				10:   
                  out <= {in[21:0], in[31:22]};
				9:   
                  out <= {in[22:0], in[31:23]};
				8:   
                  out <= {in[23:0], in[31:24]};
				7:   
                  out <= {in[24:0], in[31:25]};
				6:   
                  out <= {in[25:0], in[31:26]};
				5:   
                  out <= {in[26:0], in[31:27]};
				4:   
                  out <= {in[27:0], in[31:28]};
				3:   
                  out <= {in[28:0], in[31:29]};
				2:	
                  out <= {in[29:0], in[31:30]};
				1:
                  out <= {in[30:0], in[31]};
				default: out <= in;
		endcase
	end
endmodule

module ror32(

  input  [31:0] in,
  input  [31:0] num_rotate,

  output reg [31:0] out
);
  
    wire [4:0] temp;
    assign temp = num_rotate % 32;
  
	always@(*) begin
      case(temp)
				31:
                  out <= {in[30:0], in[31]};
				30:
                  out <= {in[29:0], in[31:30]};
				29:
                  out <= {in[28:0], in[31:29]};
				28: 	
                  out <= {in[27:0], in[31:28]};
				27: 	
                  out <= {in[26:0], in[31:27]};
				26: 	
                  out <= {in[25:0], in[31:26]};
				25: 	
                  out <= {in[24:0], in[31:25]};
				24: 	
                  out <= {in[23:0], in[31:24]};
				23: 	
                  out <= {in[22:0], in[31:23]};
				22: 	
                  out <= {in[21:0], in[31:22]};
				21: 	
                  out <= {in[20:0], in[31:21]};
				20: 	
                  out <= {in[19:0], in[31:20]};
				19: 	
                  out <= {in[18:0], in[31:19]};
				18: 	
                  out <= {in[17:0], in[31:18]};
				17: 	
                  out <= {in[16:0], in[31:17]};
				16:   
                  out <= {in[15:0], in[31:16]};
				15:   
                  out <= {in[14:0], in[31:15]};
				14:   
                  out <= {in[13:0], in[31:14]};
				13:   
                  out <= {in[12:0], in[31:13]};
				12:   
                  out <= {in[11:0], in[31:12]};
				11:   
                  out <= {in[10:0], in[31:11]};
				10:   
                  out <= {in[9:0], in[31:10]};
				9:   
                  out <= {in[8:0], in[31:9]};
				8:   
                  out <= {in[7:0], in[31:8]};
				7:   
                  out <= {in[6:0], in[31:7]};
				6:   
                  out <= {in[5:0], in[31:6]};
				5:   
                  out <= {in[4:0], in[31:5]};
				4:   
                  out <= {in[3:0], in[31:4]};
				3:   
                  out <= {in[2:0], in[31:3]};
				2:	
                  out <= {in[1:0], in[31:2]};
				1:
                  out <= {in[0], in[31:1]};
				default: out <= in;
		endcase
	end   
endmodule

module ShiftLeft(
	input wire [31:0] dataInput,
    input wire [31:0] shiftNum,
    output wire [31:0] dataOut
    
);
	assign dataOut[31:0] = dataInput << shiftNum;
    
endmodule

module ShiftRight(
	input wire [31:0] dataInput,
    input wire [31:0] shiftNum,
    output wire [31:0] dataOut
    
);
	assign dataOut[31:0] = dataInput >> shiftNum;
    
endmodule

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

module neg32(
  input [31:0] in,
  output [31:0] out
);
  wire [31:0] temp;
  wire cout0;
 
  not32 not32(in,temp);
  adder32 adder32(temp,32'b1,1'b0,out,cout0);
    
endmodule

module not32(
  input [31:0] in,
  output [31:0] out
);
  
  genvar i;
  generate
    for(i=0; i < 32; i=i+1)
      begin : loop
       	assign out[i] = !in[i];
      end
  endgenerate
endmodule
