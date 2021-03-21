`timescale 1ns/10ps

module ShiftLeft_TB;

  reg [31:0] dataInput = 31'h0;
  reg [31:0] shiftNum;
  wire [31:0] dataOut;


  
  ShiftLeft shl_test(
	dataInput,
	shiftNum,
	dataOut
    );

initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,shl_test);
    #5;
    shiftNum <= 31'h00000003;
    #5;  
    dataInput <= 31'h10;
    #5
	$finish;
end


endmodule