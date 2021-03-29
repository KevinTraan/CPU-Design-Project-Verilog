`timescale 1ns/10ps

module ShiftRight_TB;

  reg [31:0] dataInput = 31'h0;
  reg [31:0] shiftNum;
  wire [31:0] dataOut;


  
  ShiftRight shr_test(
	dataInput,
	shiftNum,
	dataOut
    );

initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,shr_test);
    #5;
    shiftNum <= 31'h00000003;
    #5;  
    dataInput <= 31'h10;
    #5
	$finish;
end


endmodule