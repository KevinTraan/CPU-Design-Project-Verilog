`timescale 1ns/10ps

module control_unit(
  
  output [31:0] BusMuxOut,
  
  output reg  r14write,
              Zin, Yin,
              LOin, HIin,
              MDRin, PCin,
              RAMread, RAMwrite,
              MARin, IRin,
              CONin,brIn,
              OutPortIn,
  
  output reg  HIout, LOout,
              Zhighout, Zlowout,
              PCout, MDRout,
              Cout, InPortout,
  
  input [31:0] HIMuxIn, LOMuxIn,
               ZhighMuxIn, ZlowMuxIn,
               PCMuxIn, MDRMuxIn,
               InPortMuxIn, CMuxIn,
  
  output reg [11:0] ALUControl,
  
  input [31:0] Mdatain,
  output reg MDRRead,
  
  output reg Gra, Grb, Grc, Rin_in, Rout_in, BAout,
  
  input clk,clr,
  output reg IncPC,
  output reg con_FF_Reset,
  
  input [31:0] dummyInputUnit,
  
  input [31:0] IR,
  input control_reset,
  
  input [31:0] Yout
  
  );
  integer i = 1;
  always @(posedge control_reset) begin
    //initialize signals
    Gra = 0; Gra = 0; Grb = 0; Grc = 0;
    Rin_in = 0; Rout_in = 0; BAout = 0;
    r14write = 0;
    Zin = 0; Yin = 0;
    LOin = 0; HIin = 0;
    MDRin = 0; PCin = 0;
    RAMread = 0; RAMwrite = 0;
  	MARin = 0; IRin = 0;
  	CONin = 0; brIn = 0;
  	OutPortIn = 0;
    con_FF_Reset = 0;
    HIout = 0; LOout = 0;
    Zhighout = 0; Zlowout = 0;
    PCout = 0; MDRout = 0;
    Cout = 0; InPortout = 0;
    MDRRead = 0; IncPC = 0;
    RAMread = 1;
    i = 1;
    while(i) begin
    #20 PCout <= 1; MARin <= 1;
    #20 IncPC <= 1; Zin <= 1;
    #20 PCout <= 0; IncPC <= 0; Zin <= 0; MARin <= 0;
    //T1:
    #20 PCin <= 1; Zlowout <= 1;
    #20 PCin <= 0; Zlowout <= 0;
    #20 MDRRead <= 1; MDRin <= 1;
    #20 MDRRead <= 0; MDRin <= 0;
    //T2:
    #20 MDRout <= 1; IRin <= 1;
    #20 MDRout <= 0; IRin <= 0;
      case(IR[31:27])
        'b00000: begin //ld
          //T3
          #20 Grb <= 1; BAout <= 1; Yin <= 1;
          #20 Grb <= 0; BAout <= 0;Yin <= 0;
          //T4
          #20 Cout <= 1; ALUControl <= 12'b0000_0000_0001; Zin <= 1;
          #20 Cout <= 0; Zin <= 0;
          //T5
          #20 Zlowout <= 1; MARin <= 1;
          #20 Zlowout <= 0; MARin <= 0;
          //T6
          #20 MDRRead <= 1; MDRin <= 1;
          #20 MDRRead <= 0; MDRin <= 0;
          //T7
          #20 MDRout <= 1; Gra <= 1; Rin_in <= 1;
          #20;Gra <= 0; Rin_in <= 0;
          #20;MDRout <= 0;
          end
        'b00001: begin //ldi
          //T3:
          #20 Grb <= 1; BAout <= 1; Yin <= 1;
          #20 Yin <= 0;
          #20 Grb <= 0; BAout <= 0;
          //T4
          #20 Cout <= 1; ALUControl <= 12'b0000_0000_0001; Zin <= 1;
          #20 Cout <= 0; Zin <= 0;
          //T5
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
     	  end
        'b00010: begin //store
          //T3:
          #20 Grb <= 1; BAout <= 1; Yin <= 1;
          #20 Yin <= 0;
          #20 Grb <= 0; BAout <= 0;
          //T4
          #20 Cout <= 1; ALUControl <= 12'b0000_0000_0001; Zin <= 1;
          #20 Cout <= 0; Zin <= 0;
          //T5
          #20; 
          #20 Zlowout <= 1; MARin <= 1;
          #20 Zlowout <= 0; MARin <= 0;
          //T6
          #20 Gra <= 1; Rout_in <= 1; MDRin <=1; MDRRead <= 0; RAMread <= 0; RAMwrite <=1;
          #20 Gra <= 0; Rout_in <= 0; MDRin <=0; MDRRead <= 0; RAMread <= 1; RAMwrite <=0;
        end
        'b10010: begin //br
          //T3:
          #40 Gra <= 1; Rout_in <= 1; CONin <= 1;
          #40 Gra <= 0; Rout_in <= 0; CONin <= 0;
          //T4:
          #40 PCout <= 1; Yin <= 1;
          #40 PCout <= 0; Yin <= 0;
          //T5:
          #40 Cout <= 1; ALUControl <= 12'b0000_0000_0001; Zin <= 1;
          #40 Cout <= 0; Zin <= 0;
          //T6:
          #40 Zlowout <= 1; PCin <= 1; brIn <= 1;
          #40 Zlowout <= 0; PCin <= 0; brIn <= 0; con_FF_Reset <= 1;
  		  #40 con_FF_Reset <= 0;
          end
        'b11001: begin //nop
        ;  
        end
        'b00011: begin //ADD
          //T3:
          #20 Grc <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grc <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20 Grb <= 1; Rout_in <= 1; ALUControl <= 12'b0000_0000_0001; Zin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Zin <= 0;
          //T5:
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
          end
        'b00100: begin //SUB
          //T3:
          #20 Grb <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20 Grc <= 1; Rout_in <= 1; ALUControl <= 12'b0000_0000_0010; Zin <= 1;
          #20 Grc <= 0; Rout_in <= 0; Zin <= 0;
          //T5:
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
          end
        'b00101: begin //SHR
          //T3:
          #20 Grb <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20 Grc <= 1; Rout_in <= 1; ALUControl <= 12'b0000_0001_0000; Zin <= 1;
          #20 Grc <= 0; Rout_in <= 0; Zin <= 0;
          //T5:
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
          end
        'b00110: begin //SHL
          //T3:
          #20 Grb <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20 Grc <= 1; Rout_in <= 1; ALUControl <= 12'b0000_0010_0000; Zin <= 1;
          #20 Grc <= 0; Rout_in <= 0; Zin <= 0;
          //T5:
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
          end
        'b00111: begin //ROR
          //T3:
          #20 Grb <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20 Grc <= 1; Rout_in <= 1; ALUControl <= 12'b0000_0100_0000; Zin <= 1;
          #20 Grc <= 0; Rout_in <= 0; Zin <= 0;
          //T5:
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
          end
        'b01000: begin //ROL
          //T3:
          #20 Grb <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20 Grc <= 1; Rout_in <= 1; ALUControl <= 12'b0000_1000_0000; Zin <= 1;
          #20 Grc <= 0; Rout_in <= 0; Zin <= 0;
          //T5:
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
          end
        'b01001: begin //AND
          //T3:
          #20 Grc <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grc <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20 Grb <= 1; Rout_in <= 1; ALUControl <= 12'b0001_0000_0000; Zin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Zin <= 0;
          //T5:
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
          end
        'b01010: begin //OR
          //T3:
          #20 Grc <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grc <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20 Grb <= 1; Rout_in <= 1; ALUControl <= 12'b0010_0000_0000; Zin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Zin <= 0;
          //T5:
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
          end
        'b01011: begin //ADDI
          //T3: 
          #20;
          #20 Grb <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20;
          #20 Cout <= 1; ALUControl <= 12'b0000_0000_0001; Zin <= 1;
          #20 Cout <= 0; Zin <= 0;
          //T5:
          #20;
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
        end
        'b01100: begin //ANDI
          //T3: 
          #20;
          #20 Grb <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20;
          #20 Cout <= 1; ALUControl <= 12'b0001_0000_0000; Zin <= 1;
          #20 Cout <= 0; Zin <= 0;
          //T5:
          #20;
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
        end
        'b01101: begin //ORI
          //T3: 
          #20;
          #20 Grb <= 1; Rout_in <= 1; Yin <= 1;
          #20 Grb <= 0; Rout_in <= 0; Yin <= 0;
          //T4:
          #20;
          #20 Cout <= 1; ALUControl <= 12'b0010_0000_0000; Zin <= 1;
          #20 Cout <= 0; Zin <= 0;
          //T5:
          #20;
          #20 Zlowout <= 1; Gra <= 1; Rin_in <= 1;
          #20 Zlowout <= 0; Gra <= 0; Rin_in <= 0;
        end
        'b01110: begin //MUL
          #20 Gra <= 1; Rout_in <= 1; Yin <= 1;
          #20 Gra <= 0; Yin <= 0;
          #20 Grb <= 1; ALUControl <= 12'b0000_0000_0100; Zin <= 1;
          #20 Grb <= 0; Zin <=0; Rout_in <= 0;
          #20 Zlowout <= 1; LOin <= 1;
          #20 Zlowout <= 0; LOin <= 0;
          #20 Zhighout <= 1; HIin <= 1;
          #20 Zhighout <= 0; HIin <= 0;
        end
        'b01111: begin //DIV
          #20 Gra <= 1; Rout_in <= 1; Yin <= 1;
          #20 Gra <= 0; Yin <= 0;
          #20 Grb <= 1; ALUControl <= 12'b0000_0000_1000; Zin <= 1;
          #20 Grb <= 0; Zin <=0; Rout_in <= 0;
          #20 Zlowout <= 1; LOin <= 1;
          #20 Zlowout <= 0; LOin <= 0;
          #20 Zhighout <= 1; HIin <= 1;
          #20 Zhighout <= 0; HIin <= 0;
        end
        'b10000: begin //NEG
          #20 Grb <= 1; Rout_in <= 1; ALUControl <= 12'b0100_0000_0000; Zin <= 1;
          #20 Zin <= 0;
          #20 Grb <= 0; Rout_in <= 0; Zlowout <= 1;
          #20 Gra <= 1; Rin_in <= 1;
          #20 Gra <= 0; Rin_in <= 0; Zlowout <= 0;
        end
        'b10001: begin //NOT
          #20 Grb <= 1; Rout_in <= 1; ALUControl <= 12'b1000_0000_0000; Zin <= 1;
          #20 Zin <= 0;
          #20 Grb <= 0; Rout_in <= 0; Zlowout <= 1;
          #20 Gra <= 1; Rin_in <= 1;
          #20 Gra <= 0; Rin_in <= 0; Zlowout <= 0;
        end
        'b10111: begin //mfHI
          #20 Gra <= 1; Rin_in <= 1; HIout <= 1;
          #20 Gra <= 0; Rin_in <= 0; HIout <= 0;
        end
        'b11000: begin //mfLO
          #20 Gra <= 1; Rin_in <= 1; LOout <= 1;
          #20 Gra <= 0; Rin_in <= 0; LOout <= 0;
        end
        'b10011: begin //jr
          //T0:
          #20 Gra <= 1; Rout_in <= 1; PCin <= 1;
          #20 Gra <= 0; Rout_in <= 0; PCin <= 0;
          end
        'b10100: begin //jal
          //T2 //PC is now in Rb
          #20 Grb <= 1; Rin_in <= 1; PCout <= 1;
    	  #20 Grb <= 0; Rin_in <= 0; PCout <= 0;
          //T3:
          #20 Gra <= 1; Rout_in <= 1; PCin <= 1;
          #20 Gra <= 0; Rout_in <= 0; PCin <= 0;
        end
       'b11010: begin
         i <= 0;
         break;
       end
        default: begin
          $monitor("OP CODE NOT VALID");
        end
      endcase //case
      end //while
  end //always
endmodule