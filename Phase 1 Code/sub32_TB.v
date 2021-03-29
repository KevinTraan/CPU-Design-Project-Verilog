`timescale 1ns/10ps

module sub32_TB;
  reg [31:0] a;
  reg [31:0] b;
  reg cin;
  wire[31:0] sum;
  wire cout;
  
  sub32 sub32(a,b,cin,sum,cout);
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,sub32);
    //10-1 = 9
    a<=10;
    b<=1;
    cin<=0;
    #5;
    //15-1 = E
    a<=15;
    b<=1;
    cin<=0;
    #5;
    $finish;
  end	
endmodule
		 
