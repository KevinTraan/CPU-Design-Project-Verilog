`timescale 1ns/10ps

module select_logic_TB;
  
  reg Gra;
  reg Grb;
  reg Grc;
  reg Rin_in;
  reg Rout_in;
  reg BAout;
  reg [31:0] IR;
  
  reg [31:0] C_sign_extended_num;
  
  reg [15:0] Rin;
  reg [15:0] Rout;
  
  reg   R0out, R1out,
  		R2out, R3out,
  		R4out, R5out,
      	R6out, R7out,
     	R8out, R9out,
     	R10out, R11out,
    	R12out, R13out,
        R14out, R15out;
  
  reg   R0in, R1in,
      	R2in, R3in,
     	R4in, R5in,
     	R6in, R7in,
     	R8in, R9in,
     	R10in, R11in,
     	R12in, R13in,
     	R14in, R15in;


  selectLogic SL_test(
    Gra,
    Grb,
    Grc,
    Rin_in,
    Rout_in,
    BAout,
    IR,
  
    C_sign_extended_num,
    R0out,R1out,
  		R2out, R3out,
  		R4out, R5out,
      	R6out, R7out,
     	R8out, R9out,
     	R10out, R11out,
    	R12out, R13out,
        R14out, R15out,
    R0in, R1in,
      	R2in, R3in,
     	R4in, R5in,
     	R6in, R7in,
     	R8in, R9in,
     	R10in, R11in,
     	R12in, R13in,
     	R14in, R15in
    
    );

initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, SL_test);
    Gra = 0;
    Grb = 1;
    Grc = 0;
    Rin_in = 0;
    Rout_in = 1;
    BAout = 0;
    // IR{OP-code , Ra  , Rb  , Rc, rest of the binary}
  IR = {5'bXXXXX, 4'b0001, 4'b0000, 4'b0100, 15'b0};
    #40;
	$finish;
end


endmodule