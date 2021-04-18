`timescale 1ns/10ps

module bus(
  
  output [31:0] BusMuxOut,

  input [31:0] R0MuxIn, R1MuxIn,
               R2MuxIn, R3MuxIn,
               R4MuxIn, R5MuxIn,
               R6MuxIn, R7MuxIn,
               R8MuxIn, R9MuxIn,
               R10MuxIn, R11MuxIn,
               R12MuxIn, R13MuxIn,
               R14MuxIn, R15MuxIn,
  
  input [31:0] HIMuxIn, LOMuxIn,
               ZhighMuxIn, ZlowMuxIn,
               PCMuxIn, MDRMuxIn,
               InPortMuxIn, CMuxIn,
  
  input [31:0] Mdatain,
  
  input clk,clr,
  
  input [31:0] dummyInputUnit,
  input control_reset,
  
  input [31:0] Yout
  
  );

  wire [4:0] Sout;
  wire [31:0] ALU_zhigh, ALU_zlow;
  wire [31:0] IRout;
  wire PCSelect;
  wire [31:0] dummyOutputUnit;
  reg Gra, Grb, Grc, Rin_in, Rout_in, BAout;
  reg   R0out,R1out,
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
  
    reg r14write,
    	Zin, Yin,
  		LOin, HIin,
  		MDRin, PCin,
 		RAMread, RAMwrite,
  		MARin, IRin,
  		CONin,brIn,
  		OutPortIn;
  
    reg HIout, LOout,
        Zhighout, Zlowout,
        PCout, MDRout,
        Cout, InPortout;
  reg [11:0] ALUControl;
    reg MDRRead;
    reg IncPC;
  
    reg con_FF_Reset;
  
  reg0 r0(clk,clr,R0in,BusMuxOut,BAout,R0MuxIn);
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
  ra r14(clk,clr,R14in,BusMuxOut,R14MuxIn,r14write);
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
  
  pc_reg PC(.clk(clk),
            .clr(clr),
            .enable(PCin),
            .select(PCSelect),
            .brIn(brIn),
            .input_D(BusMuxOut),
            .output_Q(PCMuxIn));
  
  gen_reg32 IR(.clk(clk),
                .clr(clr),
            	.enable(IRin),
                .input_D(BusMuxOut),
           	    .output_Q(IRout));
  
  In_Port InPort(.clk(clk),
                 .clr(clr),
                 .input_D(dummyInputUnit),
                 .output_Q(InPortMuxIn));
  
  gen_reg32 OutPort(.clk(clk),
                .clr(clr),
                .enable(OutPortIn),
                .input_D(BusMuxOut),
                .output_Q(dummyOutputUnit));
  
  ALU alu(.ALUControl(ALUControl),
          .A(Yout),
          .B(BusMuxOut),
          .IncPC(IncPC),
          .zlow(ALU_zlow),
          .zhigh(ALU_zhigh));

  mdr MDR(.select(MDRRead),
          .input_0(BusMuxOut),
          .input_1(Mdatain),
          .clr(clr),
          .clk(clk),
          .enable_MDRin(MDRin),
          .output_Q(MDRMuxIn));

  MAR_RAM mar_ram(RAMread, RAMwrite,
                 MDRMuxIn, Mdatain,
                 BusMuxOut,clr,
                 clk, MARin);
  
  con_FF FF(.IR(IRout),
            .bus(BusMuxOut),
            .CON_in(CONin),
            .con_FF_Reset(con_FF_Reset),
            .CON_out(PCSelect));
  
  selectLogic selectLogic(Gra, Grb, Grc,
  						  Rin_in, Rout_in,
                          BAout,IRout, CMuxIn,
                          R0out, R1out,
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
  
  control_unit control_unit(BusMuxOut,
                          
                            r14write,
                            Zin, Yin,
                            LOin, HIin,
                            MDRin, PCin,
                            RAMread, RAMwrite,
                            MARin, IRin,
                            CONin,brIn,
                            OutPortIn,
  
                            HIout, LOout,
                            Zhighout, Zlowout,
                            PCout, MDRout,
                            Cout, InPortout,
  
                            HIMuxIn, LOMuxIn,
                            ZhighMuxIn, ZlowMuxIn,
                            PCMuxIn, MDRMuxIn,
                            InPortMuxIn, CMuxIn,
  
                            ALUControl,

                            Mdatain,
                            MDRRead,

                            Gra, Grb, Grc, Rin_in, Rout_in, BAout,

                            clk,clr,
                            IncPC,
                            con_FF_Reset,

                            dummyInputUnit,

                            IRout,
                            control_reset,

                            Yout);

endmodule