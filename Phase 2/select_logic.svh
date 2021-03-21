

//
`timescale 1ns/10ps

module selectLogic(
  
  input Gra,
  input Grb,
  input Grc,
  input Rin_in,
  input Rout_in,
  input BAout,
  input [31:0] IR,
  
  output reg [31:0] C_sign_extended_num,
  output reg R0out,R1out,
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
   
  reg [15:0] Rin;
  reg [15:0] Rout;
  reg [3:0] gateAND1temp;
  reg [3:0] gateAND2temp;
  reg [3:0] gateAND3temp;
  reg [3:0] gateAND4temp;
  
  reg [15:0] encodeout;
  
  // OP Code info
  // Ra IR[26:23]
  // Rb IR[22:19]
  // Rc IR[18:15]
  
  C_sign_extend csed(
    IR,
    C_sign_extended_num
  );
  
  encoder4to16 encodeer(
    gateAND4temp,
    encodeout
  );
  
  always @ (*) begin
 
      gateAND1temp <= IR[26:23] & {4{Gra}};
      gateAND2temp <= IR[22:19] & {4{Grb}};
      gateAND3temp <= IR[18:15] & {4{Grc}};
      gateAND4temp <= ((gateAND1temp | gateAND2temp) | gateAND3temp);

   Rin = ({16{Rin_in}} & encodeout);
   Rout = (({16{Rout_in}} | {16{BAout}}) & encodeout);
     R0out = Rout[0];
     R1out = Rout[1];
     R2out = Rout[2];
     R3out = Rout[3];
     R4out = Rout[4];
     R5out = Rout[5];
     R6out = Rout[6];
     R7out = Rout[7];
     R8out = Rout[8];
     R9out = Rout[9];
     R10out = Rout[10];
     R11out = Rout[11];
     R12out = Rout[12];
     R13out = Rout[13];
     R14out = Rout[14];
     R15out  = Rout[15];
     R0in = Rin[0];
     R1in = Rin[1];
     R2in = Rin[2];
     R3in = Rin[3];
     R4in = Rin[4];
     R5in = Rin[5];
     R6in = Rin[6];
     R7in = Rin[7];
     R8in = Rin[8];
     R9in = Rin[9];
     R10in = Rin[10];
     R11in = Rin[11];
     R12in = Rin[12];
     R13in = Rin[13];
     R14in = Rin[14];
     R15in = Rin[15];
  end 
    
endmodule

// C sign extend function

module C_sign_extend(
  input [31:0] in,
  output reg [31:0] out
);
 
  always @ (*) begin
    out <= {{13{in[18]}},{in[18:0]}};
  end
endmodule



// Encoder 4 to 16 implementation

 // 4 to 16 encoder used in the select and encode

module encoder4to16(
  input [3:0] dataIn,
  output reg [15:0] dataOut
);
  
  always @( * ) begin
    
    case (dataIn)
      4'b0000: begin dataOut=16'd1; end
      4'b0001: begin dataOut=16'd2; end
      4'b0010: begin dataOut=16'd4; end
      4'b0011: begin dataOut=16'd8; end
      4'b0100: begin dataOut=16'd16; end
      4'b0101: begin dataOut=16'd32; end
      4'b0110: begin dataOut=16'd64; end
      4'b0111: begin dataOut=16'd128; end
      4'b1000: begin dataOut=16'd256; end
      4'b1001: begin dataOut=16'd512; end
      4'b1010: begin dataOut=16'd1024; end
      4'b1011: begin dataOut=16'd2048; end
      4'b1100: begin dataOut=16'd4096; end
      4'b1101: begin dataOut=16'd8192; end
      4'b1110: begin dataOut=16'd16384; end
      4'b1111: begin dataOut=16'd32768; end
    endcase    
  end

endmodule