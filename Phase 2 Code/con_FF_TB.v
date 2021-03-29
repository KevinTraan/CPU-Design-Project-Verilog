`timescale 1ns/10ps

module con_FF_TB;
  reg [31:0] IR;
  reg signed [31:0] bus;
  reg CON_in;
  reg con_FF_Reset;
  wire CON_out;
  
  con_FF FF(IR, bus, CON_in, con_FF_Reset, CON_out);
  
  initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, FF);
    //[20:19]0000_0000_000X_X000_0000_0000_0000_0000;
    IR = 32'b0000_0000_0001_1000_0000_0000_0000_0000;
    bus= 32'b1000_0000_0000_0000_0000_0000_0000_0000;
    CON_in = 0;
    con_FF_Reset = 0;
    #10;
    CON_in = 1;
    #10;
    CON_in = 0;
    #10;
    con_FF_Reset = 1;
    #10;
    $finish;
  end	
endmodule