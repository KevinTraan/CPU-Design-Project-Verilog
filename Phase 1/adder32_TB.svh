`timescale 1ns/10ps

module adder_TB;
  reg [31:0] a;
  reg [31:0] b;
  reg cin;
  wire[31:0] sum;
  wire cout;
  
  adder32 adder32(a,b,cin,sum,cout);
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,adder32);
    //10+1 = B
    a<=10;
    b<=1;
    cin<=0;
    #5;
    //15+1 = 10
    a<=15;
    b<=1;
    cin<=0;
    //15+1+carryin=11
    #5;
    a <= 15;
    b <= 1;
    cin<=1;
    #5;
    //4294967295+1=0 (and carry out)
    a <= 4294967295;
    b <= 1;
    cin<=0;
    #5;
    $finish;
  end	
endmodule
		 
