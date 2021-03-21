`timescale 1ns/10ps

module LAB_ROR_TB;
  
  //Output for bus
  reg [31:0] BusMuxOut;

  //Inputs for Encoder
  reg R0out, R1out,
      R2out, R3out,
      R4out, R5out,
      R6out, R7out,
      R8out, R9out,
      R10out, R11out,
      R12out, R13out,
      R14out, R15out;
  
  //enable for registers
  reg R0in, R1in,
      R2in, R3in,
      R4in, R5in,
      R6in, R7in,
      R8in, R9in,
      R10in, R11in,
      R12in, R13in,
      R14in, R15in,
  	  Zin, Yin,
  	  LOin, HIin,
  	  MDRin;
  
  wire [31:0] R0MuxIn, R1MuxIn,
              R2MuxIn, R3MuxIn,
              R4MuxIn, R5MuxIn,
              R6MuxIn, R7MuxIn,
              R8MuxIn, R9MuxIn,
              R10MuxIn, R11MuxIn,
              R12MuxIn, R13MuxIn,
              R14MuxIn, R15MuxIn;
  
  reg HIout, LOout,
      Zhighout, Zlowout,
      PCout, MDRout,
      InPortout, Cout;
  
  wire [31:0] HIMuxIn, LOMuxIn,
  			  ZhighMuxIn, ZlowMuxIn,
  			  PCMuxIn, MDRMuxIn,
              InPortMuxIn, CMuxIn;

  //ALU Simulator (FIX IN Phase3)
  reg [11:0] ALUControl;
  
  //inputs for MDR
  reg [31:0] Mdatain; //input_1
  reg MDRRead; //MDR select 

  //other
  wire clk;
  reg clr = 0;
  reg MARin;
  reg IRin;
  reg IncPC;
  reg PCin;
  wire [31:0] Yout;

  //instantiate bus
  bus BUS_TB(BusMuxOut,
             
    		 R0out,R1out,
  			 R2out, R3out,
  			 R4out, R5out,
      		 R6out, R7out,
     		 R8out, R9out,
     	  	 R10out, R11out,
    	  	 R12out, R13out,
       		 R14out, R15out,
             
             R0in, R1in,
             R2in, R3in,
             R4in, R5in,
             R6in, R7in,
             R8in, R9in,
             R10in, R11in,
             R12in, R13in,
             R14in, R15in,
             Zin, Yin,
             LOin, HIin,
             MDRin,
             
             R0MuxIn, R1MuxIn,
             R2MuxIn, R3MuxIn,
             R4MuxIn, R5MuxIn,
             R6MuxIn, R7MuxIn,
             R8MuxIn, R9MuxIn,
             R10MuxIn, R11MuxIn,
             R12MuxIn, R13MuxIn,
             R14MuxIn, R15MuxIn,
             
             HIout, LOout,
             Zhighout, Zlowout,
             PCout, MDRout,
             InPortout, Cout,
             
             HIMuxIn, LOMuxIn,
             ZhighMuxIn, ZlowMuxIn,
             PCMuxIn, MDRMuxIn,
             InPortMuxIn, CMuxIn,
             
             ALUControl,
             
             Mdatain,
             MDRRead,
             
             clk,clr,
             
             Yout
             );
 	clock clock(clk);
  
initial begin
  $dumpfile("out.vcd");
  $dumpvars(0,BUS_TB);
  //Default
  //Encoder
  R0out <= 0; R1out <= 0;
  R2out <= 0; R3out <= 0;
  R4out <= 0; R5out <= 0;
  R6out <= 0; R7out <= 0;
  R8out <= 0; R9out <= 0;
  R10out <= 0; R11out <= 0;
  R12out <= 0; R13out <= 0;
  R14out <= 0; R15out <= 0;
  
  R0in <= 0; R1in <= 0;
  R2in <= 0; R3in <= 0;
  R4in <= 0; R5in <= 0;
  R6in <= 0; R7in <= 0;
  R8in <= 0; R9in <= 0;
  R10in <= 0; R11in <= 0;
  R12in <= 0; R13in <= 0;
  R14in <= 0; R15in <= 0;
  
  HIout <= 0; LOout <= 0;
  HIin <= 0; LOin <=0;
  Zhighout <= 0; Zlowout <= 0;
  PCout <= 0; MDRin <= 0;
  InPortout <= 0; Cout <=0;

  //Others
  clr = 0;
  MARin <= 0; IRin <= 0; Yin <= 0; IncPC <= 0;
  MDRRead <= 0; ALUControl <= 0; Mdatain <= 0;
  MDRin <= 0;
  MDRout <= 0;
  Zin <= 0;
  /////
  
  //Reg_load1a:
  #40;
  Mdatain <= 32'b1100_0100_0000_0000_0000_0000_0000_0000;
  MDRRead = 0; MDRin = 0;
  #15 MDRRead <= 1; MDRin <= 1;
  #15 MDRRead <= 0; MDRin <= 0;
  //reg_load1b:
  #40;
  #10 MDRout <= 1; R2in <= 1;
  #15 MDRout <= 0; R2in <= 0;
  //reg_load2a:
  #40;
  Mdatain <= 32'h6;
  MDRRead = 0; MDRin = 0;
  #15 MDRRead <= 1; MDRin <= 1;
  #15 MDRRead <= 0; MDRin <= 0;
  //reg_load2b:
  #40;
  #15 MDRout <= 1; R4in <= 1;
  #15 MDRout <= 0; R4in <= 0;  
  //reg_load3a:
  #40;
  Mdatain = 32'h0;
  #15 MDRRead <= 1; MDRin <= 1;
  #15 MDRRead <= 0; MDRin <= 0;
  //reg_load3b:
  #40;
  #15 MDRout <= 1; R5in <= 1;
  #15 MDRout <= 0; R5in <= 0;
  //T0: begin
  #40;
  PCout <= 0; MARin <= 1; IncPC <= 1; Zin <= 1;
  //T1: begin
  #40;
  Zlowout <= 0; PCin <= 1; MDRRead <= 0; MDRin <= 0;
  Mdatain <= 32'h4A920000;
  //T2: begin
  #40;
  MDRout <= 1; IRin <= 1;
  MDRout <= 0; IRin <= 0;
  //T3: begin
  #40;
  #15 R2out <= 1; Yin <= 1;
  #15 R2out <= 0; Yin <= 0;
  //T4: begin
  #40;
  #15 R4out <= 1; ALUControl <= 12'b0000_0100_0000; Zin <= 1;
  #15 R4out <= 0; Zin <= 0;
  //T5: begin
  #40;
  Zlowout <= 1; R5in <= 1; 
  #500;
  $finish;
  end
endmodule
