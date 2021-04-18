`timescale 1ns/10ps

module control_unit_TB;
  
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
  
  //inputs for MDR
  wire [31:0] Mdatain; //input_1
  reg MDRRead; //MDR select 
  
  //other
  wire clk;
  reg clr = 0;
  reg IncPC;
  reg con_FF_Reset;
  reg[31:0] dummyInputUnit;
  reg control_reset;
  wire [31:0] Yout;
  
  //instantiate bus
  bus BUS_TB(BusMuxOut,
             
             R0MuxIn, R1MuxIn,
             R2MuxIn, R3MuxIn,
             R4MuxIn, R5MuxIn,
             R6MuxIn, R7MuxIn,
             R8MuxIn, R9MuxIn,
             R10MuxIn, R11MuxIn,
             R12MuxIn, R13MuxIn,
             R14MuxIn, R15MuxIn,
             
             HIMuxIn, LOMuxIn,
             ZhighMuxIn, ZlowMuxIn,
             PCMuxIn, MDRMuxIn,
             InPortMuxIn, CMuxIn,

             
             Mdatain,
             
             clk,clr,
             
             dummyInputUnit, 
             control_reset,
             
             Yout
          
             );
  clock clock(clk);
  
  initial begin
  $dumpfile("out.vcd");
  $dumpvars(0,BUS_TB);
  control_reset <= 1;
  #40 control_reset <= 0;
  #15000;
  $finish;
  end
endmodule