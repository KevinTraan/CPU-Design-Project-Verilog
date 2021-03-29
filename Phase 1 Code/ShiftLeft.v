`timescale 1ns/10ps

module ShiftLeft(
	input wire [31:0] dataInput,
    input wire [31:0] shiftNum,
    output wire [31:0] dataOut
    
);
	assign dataOut[31:0] = dataInput << shiftNum;
    
endmodule