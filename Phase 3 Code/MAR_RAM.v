`timescale 1ns/10ps

module MAR_RAM(
  //RAM
  input read,
  input write,
  input [31:0] MDRMuxIn,
  output reg [31:0] Mdatain,

  // MAR
  input [31:0] BusMuxOut,
  input MARclr,
  input clk,
  input MARin
  );

  wire [8:0] address;
  
  MAR mar(BusMuxOut, MARclr, clk, MARin, address);
  RAM ram(address, MDRMuxIn, read, write, Mdatain);

endmodule //MAR_RAM

module RAM(
  input [8:0] address,
  input [31:0] MDRMuxIn,
  input read, write,
  output reg [31:0] Mdatain
);

  // Memory in RAM
  reg [31:0] memory [511:0];
  //$readmemh(PATH, mem);
	integer i;
	initial begin
    for (i = 0; i < 512; i = i+1)
          begin
			memory[i] = {32{1'b0}};
            //$display ("LOC = %h \t RAM = %b", i, memory[i]);
          end
      
      
      //r0	X	1
      //r1	34	1A	8	19A
      //r2	56	54	66	CC	CD
      //r3	87	88	73	78	CC	1
      //r4	5
      //r5	1D
      //r6	91
      //r7	56	59	FFFFFFA7	58	8	37	0
      //r8	1F
      //r9	96	77
      //r10	5
      //r11	$1F
      //r12	$91
      //r13	0
      //r14 28
      //HI	X	0	4
      //LO	X	91	5
      
      // Encode test program in memory
      memory[0] = 32'b00001_0011_0000_0000000000010000111; // ldi R3, $87 <- R3 = $87
      memory[1] = 32'b00001_0011_0011_0000000000000000001; // ldi R3, 1(R3) <- R3 = $88
      memory[2] = 32'b00000_0010_0000_0000000000001110101; // ld  R2, $75 <- R2 = $56
      memory[3] = 32'b00001_0010_0010_1111111111111111110; // ldi R2, -2(R2) <- R2 = $54
      memory[4] = 32'b00000_0001_0010_0000000000000000100; // ld  R1, 4(R2) <- R1 = $34
      memory[5] = 32'b00001_0000_0000_0000000000000000001; // ldi R0, 1 <- r0 = 1
      memory[6] = 32'b00001_0011_0000_0000000000001110011; // ldi R3, $73 <- r3 = $73
      memory[7] = 32'b10010_0011_0011_0000000000000000011; // brmi R3, 3 <- branch if neg (false)
      memory[8] = 32'b00001_0011_0011_0000000000000000101; // ldi R3, 5(R3) // r3 = $78
      memory[9] = 32'b00000_0111_0011_1111111111111111101; // ld R7, -3(R3) // r6 = $56
	  memory[10] = 32'b11001_000000000000000000000000000; // nop
	  memory[11] = 32'b10010_0111_0010_0000000000000000010; // brpl R7, 2 //branch if positive (true)
	  memory[12] = 32'b00001_0100_0001_0000000000000000110; // ldi R4, 6(R1) //no execute
      memory[13] = 32'b00001_0011_0100_0000000000000000010; // ldi R3, 2(R4) //no execute
      memory[14] = 32'b00011_0011_0010_0011_000000000000000; // add R3, R2, R3 //PC = f - while 12
      memory[15] = 32'b01011_0111_0111_0000000000000000011; // addi R7, R7, <- r3 = $59
      memory[16] = 32'b10000_0111_0111_0000000000000000000; // neg R7, R7 <- r7 = $FFFFFFA7
      memory[17] = 32'b10001_0111_0111_0000000000000000000; // not R7, R7 <- r7 = $58
      memory[18] = 32'b01100_0111_0111_0000000000000001111; // andi R7, R7, $0F <- r7 = 8
      memory[19] = 32'b01101_0111_0001_0000000000000000011; // ori R7, R1, 3 <- r7 = $37
      memory[20] = 32'b00101_0010_0011_0000_000000000000000; // shr R2, R3, R0 <- r2 = $66
      memory[21] = 32'b00010_0010_0000_0000000000001011000; // st $58, R2
      memory[22] = 32'b00111_0001_0001_0000_000000000000000; // ror R1, R1, R0 <- r1 = $1A
      memory[23] = 32'b01000_0010_0010_0000_000000000000000; // rol R2, R2, R0 <- r2 = CC
      memory[24] = 32'b01010_0010_0011_0000_000000000000000; // or R2, R3, R0 <- r2 = CD
      memory[25] = 32'b01001_0001_0010_0001_000000000000000; // and R1, R2, R1 <- R1 = $8
      memory[26] = 32'b00010_0010_0001_0000000000001100111; // st $67(R1), R2 <- expected is CD at $75 but its at 6a
      memory[27] = 32'b00100_0011_0010_0011_000000000000000; // sub R3, R2, R3 <- r3 = 1
      memory[28] = 32'b00110_0001_0010_0000_000000000000000; // shl R1, R2, R0 <- r1 = $19A
      memory[29] = 32'b00001_0100_0000_0000000000000000101; // ldi R4, 5 <- r4 = 5
      memory[30] = 32'b00001_0101_0000_0000000000000011101; // ldi R5, $1D <- r5 = $1D
      memory[31] = 32'b01110_0101_0100_0000000000000000000; // mul R5, R4 <- Hi = 0; LO = $91   
      memory[32] = 32'b10111_0111_00000000000000000000000; // mfhi R7 <- r7 = 0
      memory[33] = 32'b11000_0110_00000000000000000000000; // mflo R6 <- r6 = $91
      memory[34] = 32'b01111_0101_0100_0000000000000000000; // div R5, R4 <- HI = 4 LO = 5
             
      memory[35] = 32'b00001_1010_0100_0000000000000000000; // ldi R10, 0(R4) <- r10 = 5
      memory[36] = 32'b00001_1011_0101_0000000000000000010; // ldi R11, 2(R5) <- r11 = $1F
      memory[37] = 32'b00001_1100_0110_0000000000000000000; // ldi R12, 0(R6) <- r12 = $91
      memory[38] = 32'b00001_1101_0111_0000000000000000000; // ldi R13, 0(R7) <- R13 = 0
      memory[39] = 32'b10100_1100_1110_0000000000000000000; // jal R12 (return address in R14)
      memory[40] = 32'b11010_000000000000000000000000000; // halt
	  
      memory[88] = 32'h34; // 88 = $58
      memory[117] = 32'h56; // 117 = $75
      
      memory[145] = 32'b00011_1001_1010_1100_000000000000000; // add R9, R10, R12 <- r9 = $96
      memory[146] = 32'b00100_1000_1011_1101_000000000000000; // sub R8, R11, R13 <- r8 = $1f
      memory[147] = 32'b00100_1001_1001_1000_000000000000000; // sub R9, R9, R8 <- R9 = $77
	
      memory[148] = 32'b10011_1110_00000000000000000000000; // jr R14
	end
    
  always @ (*) begin
   $display ("LOC = %h \t RAM = %b", i, memory[i]);
    if (read == 1)
      Mdatain <= memory[address];
    if (write == 1) begin
      memory[address] <= MDRMuxIn;
      //$display ("LOC = %h \t RAM = %h", address, MDRMuxIn);
    end
  end

endmodule


module MAR(
	input [31:0] BusMuxOut,
	input clr,
	input clk,
	input MARin,
    output [8:0] address
  );

  wire [31:0] reg_output_Q;
  gen_reg32 MDR_Reg(clk, clr, MARin, BusMuxOut, reg_output_Q);
  assign address = reg_output_Q[8:0];

endmodule