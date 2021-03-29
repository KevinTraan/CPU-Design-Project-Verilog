`timescale 1ns/10ps
module adder4(
	input wire [3:0] a,
	input wire [3:0] b,
	input wire cin,
	
	output wire[3:0] sum,
	output wire cout
	);

	wire [3:0] P,G,c;
 
	assign P=a^b;	//propagate signal
	assign G=a&b; 	//generate signal
	 
	assign c[0]= cin;
	assign c[1]= G[0] | (P[0]&c[0]);
	assign c[2]= G[1] | (P[1]&G[0]) | P[1]&P[0]&c[0];
	assign c[3]= G[2] | (P[2]&G[1]) | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&c[0];
	assign cout = G[3] | (P[3]&G[2]) | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&c[0];
	assign sum[3:0] =P^c;

endmodule