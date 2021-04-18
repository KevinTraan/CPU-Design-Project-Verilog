`timescale 1ns/10ps

module clock(
	output reg clk
);

	initial clk = 1;
	
	always #5 clk = ~clk;
	
endmodule