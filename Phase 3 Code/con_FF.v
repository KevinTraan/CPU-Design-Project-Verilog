`timescale 1ns/10ps

module con_FF#(parameter VAL = 0)(
  input [31:0] IR,
  input signed [31:0] bus,
  input CON_in,
  input con_FF_Reset,
  output reg CON_out
);
  wire [3:0] dec_out;
  decoder2to4 decoder(IR[20:19],dec_out);

  wire eq;
  wire not_eq;
  wire pos;
  wire neg;
  wire branch_flag;
  
  assign eq = 		(bus == 32'd0) ? 1'b1 : 1'b0; // if zero
  assign not_eq	= 	(bus != 32'd0) ? 1'b1 : 1'b0; // not zero
  assign pos = 		(bus[31] == 0) ? 1'b1 : 1'b0; // if positive
  assign neg = 		(bus[31] == 1) ? 1'b1 : 1'b0; // if negative
  assign branch_flag = (dec_out[0] & eq |
                        dec_out[1] & not_eq |
                        dec_out[2] & pos |
                        dec_out[3] & neg);
  
  initial CON_out = VAL;
  
  always@(*) 
	begin
      if(CON_in)
		CON_out = branch_flag;
      if(con_FF_Reset)
        CON_out = 0;
  	end
endmodule

module decoder2to4(
  input [1:0] dec_in,
  output reg [3:0] dec_out
  );
  always@(*)
    begin
  		case(dec_in)
      	4'b00 : dec_out <= 4'b0001;
      	4'b01 : dec_out <= 4'b0010;    
      	4'b10 : dec_out <= 4'b0100;
      	4'b11 : dec_out <= 4'b1000;   
   	endcase
    end
endmodule
  