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
  initial begin
    //-----Part 3.A Load Instructions------
    
    /*LAB_Load_TB.svh*/
    //Case 1 - ld r1, $85
    memory[0]  = 'b00000_0001_0000_0000_000000010000101;
    memory['h85] = 'b0000_0000_0000_0000_0000_0000_0000_1111;
    //Case 2 - ld r0, $35(R1)
    memory[1]  = 'b00000_0000_0001_0000_000000000110101;
    memory['h44] = 'b1111_1111_1111_1111_1111_1111_1111_0000; // 15b + 53b = 68b = 44h
    
    /*LAB_Load_Immediate_TB.svh*/
    //Case 3 - ldi r1, $85
    //memory[0]  = 'b00001_0001_0000_0000_000000010000101;
    //Case 4 - ldi r0, $35(R1)
    //memory[1]  = 'b00001_0000_0001_0000_000000000110101;
    
    //-----Part 3.B Store Instructions------
    
    /*LAB_Store_TB.svh*/
    //Case 1 - st $90, r1
    //memory[0]  = 'b00001_0001_0000_0000_000000010000101; //ldi r1, $85
    //memory[1]  = 'b00010_0001_0000_0000_000000010010000; //st $90, r1
    
    /*LAB_Store_TB.svh*/
    //Case 2 - st $90(r1), r1
    //memory[0]  = 'b00001_0001_0000_0000_000000010000101; //ldi r1, $85
    //memory[1]  = 'b00010_0001_0001_0000_000000010010000; //st $90(r1), r1
    
    //-----Part 3.C ALU Immediate Instructions------
    
    /*LAB_ALU_ADDI_TB.svh*/
    //memory[0]  = 'b00001_0001_0000_0000_000000000000010; //ldi R1, $2
    //memory[1]  = 'b01011_0010_0001_1111111111111111011; //addi r2,r1,-5
    
    /*LAB_ANDI_TB.svh*/
    //memory[0]  = 'b00001_0001_0000_0000_000000000001111; //ldi r1, 15
    //memory[1]  = 'b01100_0010_0001_0000_000000000100110; //andi r2, r1, $26
    
    /*LAB_ORI_TB.svh*/
    //memory[0]  = 'b00001_0001_0000_0000_000000000001111; //ldi r1, 15
    //memory[1]  = 'b01101_0010_0001_0000_000000000100110; //ori r2, r1, $26
    
    
    //-----Part 3.D Branch Instructions------
    
    /*LAB_BR_TB.svh*/
    //Case 1 - Branch Taken - Branch if zero
    //memory[0] = 'b00000_0010_0000_0000000000000000000; //ldi r2, 0
    //memory[1] = 'b10010_0010_0000_0000000000000100011; //brzr r2,35
    
    /*LAB_BR_TB.svh*/
    //Case 1 - Branch Not Taken
    //memory[0] = 'b00000_0010_0000_0000000000000100001; //ldi r2, 33
    //memory[1] = 'b10010_0010_0000_0000000000000100011; //brzr r2,35
    
    /*LAB_BR_TB.svh*/
    //Case 2 - Branch Taken - Branch if not zero
    //memory[0] = 'b00000_0010_0000_0000000000000000001; //ldi r2, 1
    //memory[1] = 'b10010_0010_0001_0000000000000100011; //brnz r2,35
    
    /*LAB_BR_TB.svh*/
    //Case 2 - Branch Not Taken
    //memory[0] = 'b00000_0010_0000_0000000000000000000; //ldi r2, 0
    //memory[1] = 'b10010_0010_0001_0000000000000100011; //brnz r2,35
    
    /*LAB_BR_TB.svh*/
    //Case 3 - Branch Taken - Branch if positive
    //memory[0] = 'b00000_0010_0000_0000_000000000000001; //ldi r2, 1
    //memory[1] = 'b10010_0010_0010_0000000000000100011; //brpl r2,35
    
    /*LAB_BR_TB.svh*/
    //Case 3 - Branch Not Taken
    //memory[0] = 'b00000_0010_0000_1111111111111111111; //ldi r2, -1
    //memory[1] = 'b10010_0010_0010_0000000000000100011; //brpl r2,35
    
    /*LAB_BR_TB.svh*/
    //Case 4 - Branch Taken - Branch if negative
    //memory[0] = 'b00000_0010_0000_1111111111111111111; //ldi r2, -1
    //memory[1] = 'b10010_0010_0011_0000000000000100011; //brmi r2,35
    
    /*LAB_BR_TB.svh*/
    //Case 4 - Branch Not Taken
    //memory[0] = 'b00000_0010_0000_0000000000000000001; //ldi r2, 1
    //memory[1] = 'b10010_0010_0011_0000000000000100011; //brmi r2,35
    
    //-----Part 3.E Jump Instructions------
    
    /*LAB_JR_TB.svh*/
    //memory[0] = 'b00000_0001_0000_0000000000000011110; //ldi r1, 30
    //memory[1] = 'b10011_0001_00000000000000000000000; //jr r1 - don't save
    
    /*LAB_JAL_TB.svh*/
    //memory[0] = 'b00000_0001_0000_0000000000000011110; //ldi r1, 30
    //memory[1] = 'b10100_0001_00000000000000000000000; //jal r1 ,saves currentPC into r15 and jumps to 30
    
    //-----Part 3.F Special Instructions------
    
    /*LAB_MFLO_TB.svh*/
    //memory[0] = 'b00000_0001_0000_0000000000000001111; //ldi r1, 15
    //memory[1] = 'b11000_0010_0000_0000000000000000000; //mflo r2
    
    /*LAB_MFHI_TB.svh*/
    //memory[0] = 'b00000_0001_0000_0000000000000001111; //ldi r1, $ffff
    //memory[1] = 'b10111_0010_0000_0000000000000000000; //mfhi r2
    
    //-----Part 3.G Input/Output Instructions------
    
    /*LAB_Out_TB.svh*/
    //memory[0] = 'b00000_0001_0000_0000000000000001111; //ldi r1, 15
    //memory[1] = 'b10110_0001_00000000000000000000000; //out r1
    
    /*LAB_In_TB.svh*/
    //memory[0] = 'b11010_0001_0000_0000000000000000000; //in r1
  end
  
  always @ ( * ) begin
    //$monitor ("RAM = %h at location 'h85", memory['h90]);
    $monitor ("RAM = %h at location 'h115", memory['h115]);
    if (read == 1)
      Mdatain <= memory[address];
    if (write == 1) begin
      memory[address] <= MDRMuxIn;
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