// Testing Booth

module booth_mult_TB;

  reg [31:0] mult = 31'h0;
  reg [31:0] multr;
  wire [31:0] ZhighOut;
  wire [31:0] ZlowOut;

  booth_mult mult_test(
	mult,
	multr,
	ZhighOut,
    ZlowOut
  );



initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, mult_test);
    mult <= 31'hFFFFFFFF;
    multr <= 31'd4;
    #40
	$finish;
end
  


endmodule