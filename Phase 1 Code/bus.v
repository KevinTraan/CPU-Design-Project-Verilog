`timescale 1ns/10ps

module bus(
  
  output [31:0] BusMuxOut,
  
  input R0out,R1out,
  		R2out, R3out,
  		R4out, R5out,
      	R6out, R7out,
     	R8out, R9out,
     	R10out, R11out,
    	R12out, R13out,
        R14out, R15out, 
  
  input R0in, R1in,
      	R2in, R3in,
     	R4in, R5in,
     	R6in, R7in,
     	R8in, R9in,
     	R10in, R11in,
     	R12in, R13in,
     	R14in, R15in,
    	Zin, Yin,
  		LOin, HIin,
  		MDRin,

  input [31:0] R0MuxIn, R1MuxIn,
               R2MuxIn, R3MuxIn,
               R4MuxIn, R5MuxIn,
               R6MuxIn, R7MuxIn,
               R8MuxIn, R9MuxIn,
               R10MuxIn, R11MuxIn,
               R12MuxIn, R13MuxIn,
               R14MuxIn, R15MuxIn,
  
  input HIout, LOout,
        Zhighout, Zlowout,
        PCout, MDRout,
        InPortout, Cout,
  
  input [31:0] HIMuxIn, LOMuxIn,
               ZhighMuxIn, ZlowMuxIn,
               PCMuxIn, MDRMuxIn,
               InPortMuxIn, CMuxIn,
  
  input [11:0] ALUControl,
  
  input [31:0] Mdatain,
  input MDRRead,
  
  input clk,clr,
  
  input [31:0] Yout
  );

  wire [4:0] Sout;
  wire [31:0] ALU_zhigh, ALU_zlow;
  
  gen_reg32 r0(clk,clr,R0in,BusMuxOut,R0MuxIn);
  gen_reg32 r1(clk,clr,R1in,BusMuxOut,R1MuxIn);
  gen_reg32 r2(clk,clr,R2in,BusMuxOut,R2MuxIn);
  gen_reg32 r3(clk,clr,R3in,BusMuxOut,R3MuxIn);
  gen_reg32 r4(clk,clr,R4in,BusMuxOut,R4MuxIn);
  gen_reg32 r5(clk,clr,R5in,BusMuxOut,R5MuxIn);
  gen_reg32 r6(clk,clr,R6in,BusMuxOut,R6MuxIn);
  gen_reg32 r7(clk,clr,R7in,BusMuxOut,R7MuxIn);
  gen_reg32 r8(clk,clr,R8in,BusMuxOut,R8MuxIn);
  gen_reg32 r9(clk,clr,R9in,BusMuxOut,R9MuxIn);
  gen_reg32 r10(clk,clr,R10in,BusMuxOut,R10MuxIn);
  gen_reg32 r11(clk,clr,R11in,BusMuxOut,R11MuxIn);
  gen_reg32 r12(clk,clr,R12in,BusMuxOut,R12MuxIn);
  gen_reg32 r13(clk,clr,R13in,BusMuxOut,R13MuxIn);
  gen_reg32 r14(clk,clr,R14in,BusMuxOut,R14MuxIn);
  gen_reg32 r15(clk,clr,R15in,BusMuxOut,R15MuxIn);
  
  gen_reg32 Y(.clk(clk),
              .clr(clr),
              .enable(Yin),
              .input_D(BusMuxOut),
              .output_Q(Yout));
  
  gen_reg32 Zlow(.clk(clk),
                 .clr(clr),
                 .enable(Zin),
                 .input_D(ALU_zlow),
                 .output_Q(ZlowMuxIn));
  
  gen_reg32 Zhi(.clk(clk),
                .clr(clr),
                .enable(Zin),
                .input_D(ALU_zhigh),
                .output_Q(ZhighMuxIn));
  
  gen_reg32 LO(.clk(clk),
                .clr(clr),
                .enable(LOin),
                .input_D(BusMuxOut),
                .output_Q(LOMuxIn));
  
  gen_reg32 HI(.clk(clk),
                .clr(clr),
                .enable(HIin),
                .input_D(BusMuxOut),
                .output_Q(HIMuxIn));
  
  ALU alu(.ALUControl(ALUControl),
          .A(Yout),
          .B(BusMuxOut),
          .zlow(ALU_zlow),
          .zhigh(ALU_zhigh));

  mdr MDR(.select(MDRRead),
          .input_0(BusMuxOut),
          .input_1(Mdatain),
          .clr(clr),
          .clk(clk),
          .enable_MDRin(MDRin),
          .output_Q(MDRMuxIn));

  Encoder_32_to_5 encoder32to5(R0out,R1out,
                               R2out, R3out,
                               R4out, R5out,
                               R6out, R7out,
                               R8out, R9out,
                               R10out, R11out,
                               R12out, R13out,
                               R14out, R15out,
                               
                  			   HIout, LOout,
                               Zhighout, Zlowout,
                               PCout, MDRout,
                               InPortout, Cout,
                               
                               Sout);
  
  Mux32to1 mux32to1(R0MuxIn, R1MuxIn,
                    R2MuxIn, R3MuxIn,
                    R4MuxIn, R5MuxIn,
                    R6MuxIn, R7MuxIn,
                    R8MuxIn, R9MuxIn,
                    R10MuxIn, R11MuxIn,
                    R12MuxIn, R13MuxIn,
                    R14MuxIn, R15MuxIn,
                    
                    HIMuxIn, LOMuxIn,
                    ZhighMuxIn, ZlowMuxIn,
                    PCMuxIn, MDRMuxIn,
                    InPortMuxIn, CMuxIn,
                    
                    Sout, BusMuxOut);
endmodule