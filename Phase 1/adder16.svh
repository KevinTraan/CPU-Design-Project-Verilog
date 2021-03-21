`timescale 1ns/10ps
module adder16(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire cin,
	
	output wire [15:0] sum,
	output wire cout
	);
	
	wire cout0,cout1,cout2;

  adder4 CLA0(.a(a[3:0]),.b(b[3:0]),.cin(cin),.sum(sum[3:0]),.cout(cout0));
  adder4 CLA1(.a(a[7:4]),.b(b[7:4]),.cin(cout0),.sum(sum[7:4]),.cout(cout1));
  adder4 CLA2(.a(a[11:8]),.b(b[11:8]),.cin(cout1),.sum(sum[11:8]),.cout(cout2));
  adder4 CLA3(.a(a[15:12]),.b(b[15:12]),.cin(cout2),.sum(sum[15:12]),.cout(cout)); 

endmodule

 