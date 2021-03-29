`timescale 1ns/10ps

module LAB2_TB;
  
  //Output for bus
  reg [31:0] BusMuxOut;

  //Inputs for Encoder
  wire R0out, R1out,
      R2out, R3out,
      R4out, R5out,
      R6out, R7out,
      R8out, R9out,
      R10out, R11out,
      R12out, R13out,
      R14out, R15out;
  
  //enable for registers
  wire R0in, R1in,
      R2in, R3in,
      R4in, R5in,
      R6in, R7in,
      R8in, R9in,
      R10in, R11in,
      R12in, R13in,
      R14in, R15in;
  reg r15write;
  
  reg Zin, Yin,
  	  LOin, HIin,
  	  MDRin, PCin,
  	  RAMread, RAMwrite,
      MARin, IRin,
      CONin,brIn,
  	  OutPortIn;
  
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
      Cout, InPortout;
  
  wire [31:0] HIMuxIn, LOMuxIn,
  			  ZhighMuxIn, ZlowMuxIn,
  			  PCMuxIn, MDRMuxIn,
              InPortMuxIn, CMuxIn;

  //ALU Simulator (FIX IN Phase3)
  reg [11:0] ALUControl;
  
  //inputs for MDR
  wire [31:0] Mdatain; //input_1
  reg MDRRead; //MDR select 

  //for select_logic
  reg Gra, Grb, Grc, Rin_in, Rout_in, BAout;
  
  //other
  wire clk;
  reg clr = 0;
  reg IncPC;
  reg con_FF_Reset;
  reg[31:0] dummyInputUnit;
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
             r15write,
             Zin, Yin,
             LOin, HIin,
             MDRin, PCin,
             RAMread, RAMwrite,
             MARin,IRin,
             CONin,brIn,
             OutPortIn,
             
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
             Cout, InPortout,
             
             HIMuxIn, LOMuxIn,
             ZhighMuxIn, ZlowMuxIn,
             PCMuxIn, MDRMuxIn,
             InPortMuxIn, CMuxIn,
             
             ALUControl,
             
             Mdatain,
             MDRRead,

             Gra, Grb, Grc, Rin_in, Rout_in, BAout,
             
             clk,clr,
             IncPC,
             con_FF_Reset,
             
             dummyInputUnit,
             
             Yout
          
             );
 	clock clock(clk);
initial begin
  $dumpfile("out.vcd");
  $dumpvars(0,BUS_TB);
  //Default
  //Encoder
  
  HIout <= 0; LOout <= 0;
  HIin <= 0; LOin <=0;
  Zhighout <= 0; Zlowout <= 0;
  PCout <= 0; MDRin <= 0;
  OutPortIn <= 0; Cout <=0;
  
  Gra <= 0; Grb <= 0; Grc <= 0;
  Rin_in <= 0; Rout_in <= 0;
  BAout <= 0;
  //Others
  clr = 0;
  MARin <= 0; IRin <= 0; Yin <= 0; IncPC <= 0;
  MDRRead <= 0; ALUControl <= 0;
  MDRin <= 0;
  MDRout <= 0;
  Zin <= 0;
  RAMread <= 1;
  CONin <= 0;
  con_FF_Reset <= 0;
  
  //preload HI reg
  //T0:
  #40;
  #40 PCout <= 1; MARin <= 1; //put PC into MAR
  #40 IncPC <= 1; Zin <= 1; //Increase PC using ALU Part 1
  #40 PCout <= 0; IncPC <= 0; Zin <= 0; MARin <= 0; //zero
  //T1:
  #40;
  #40 PCin <= 1; Zlowout <= 1; //Increase PC using ALU Part 2
  #40 PCin <= 0; Zlowout <= 0;
  #40 MDRRead <= 1; MDRin <= 1; //put RAM output into MDR reg
  #40 MDRRead <= 0; MDRin <= 0;
  //T2:
  #40;
  #40 MDRout <= 1; IRin <= 1; //put MDR contents into IR
  #40 MDRout <= 0; IRin <= 0;
  //T3:
  #40;
  #40 Cout <=1; HIin <= 1;
  #40 Cout <=0; HIin <= 0;
 
  //mfhi r2
  //T0:
  #40;
  #40 PCout <= 1; MARin <= 1; //put PC into MAR
  #40 IncPC <= 1; Zin <= 1; //Increase PC using ALU Part 1
  #40 PCout <= 0; IncPC <= 0; Zin <= 0; MARin <= 0; //zero
  //T1:
  #40;
  #40 PCin <= 1; Zlowout <= 1; //Increase PC using ALU Part 2
  #40 PCin <= 0; Zlowout <= 0;
  #40 MDRRead <= 1; MDRin <= 1; //put RAM output into MDR reg
  #40 MDRRead <= 0; MDRin <= 0;
  //T2:
  #40;
  #40 MDRout <= 1; IRin <= 1; //put MDR contents into IR
  #40 MDRout <= 0; IRin <= 0;
  //T3:
  #40;
  #40 Gra <= 1; Rin_in <= 1; HIout <= 1;
  
  #500;
  $finish;
  end
endmodule
