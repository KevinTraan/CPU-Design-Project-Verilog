`include "LAB_Load_TB.svh" //expec R1 = f, R0 = ffff_fff0
//`include "LAB_Load_Immediate_TB.svh" //expect R1 = h85, r0 = ba
//`include "LAB_Store_TB.svh" //case 1-expect MDRMuxIn = h85 @ location h90
                                   //case 2-expect MDRMuxIn = h85 @ location h115
//`include "LAB_ADDI_TB.svh" //expect r2 =  ffff_fffd
//`include "LAB_ANDI_TB.svh" //expect r2 = $6
//`include "LAB_ORI_TB.svh" //expect r2 = $2f
//`include "LAB_BR_TB.svh" //Look at PCMuxIn to see if it jumps/no doesn't jump
//`include "LAB_JR_TB.svh" //Check to see if it jumps to 1e
//`include "LAB_JAL_TB.svh" //R15 = 1f
//`include "LAB_MFLO_TB.svh" // expect r2 = $f
//`include "LAB_MFHI_TB.svh"  //expect r2 = $f
//`include "LAB_Out_TB.svh" //dummyoutputunit = f
//`include "LAB_In_TB.svh" //busmuxout = f