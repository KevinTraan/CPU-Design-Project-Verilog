`timescale 1ns/10ps
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
