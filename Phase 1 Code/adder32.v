`timescale 1ns / 10ps

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