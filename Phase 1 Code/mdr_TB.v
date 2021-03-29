`timescale 1ns/10ps

module mdr_TB;
  reg read;
  reg [31:0] input_0;
  reg [31:0] input_1;
  wire [31:0] output_MUX;
  reg clr;
  reg clk;
  reg enable_MDRin;
  wire [31:0] output_Q;
  
  clock clock(clk);
  mdr mdr(read,input_0,input_1,clr,clk,enable_MDRin,output_Q);
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,mdr);
    
    enable_MDRin <= 1;
    clr <= 0;
    read = 0;
	input_0 <= $random;
	input_1 <= $random;
	#100;
    read = 1;
    #100
    $finish;
  end	
endmodule
