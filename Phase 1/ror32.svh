`timescale 1ns/10ps

module ror32(

  input  [31:0] in,
  input  [31:0] num_rotate,

  output reg [31:0] out
);
  
    wire [4:0] temp;
    assign temp = num_rotate % 32;
  
	always@(*) begin
      case(temp)
				31:
                  out <= {in[30:0], in[31]};
				30:
                  out <= {in[29:0], in[31:30]};
				29:
                  out <= {in[28:0], in[31:29]};
				28: 	
                  out <= {in[27:0], in[31:28]};
				27: 	
                  out <= {in[26:0], in[31:27]};
				26: 	
                  out <= {in[25:0], in[31:26]};
				25: 	
                  out <= {in[24:0], in[31:25]};
				24: 	
                  out <= {in[23:0], in[31:24]};
				23: 	
                  out <= {in[22:0], in[31:23]};
				22: 	
                  out <= {in[21:0], in[31:22]};
				21: 	
                  out <= {in[20:0], in[31:21]};
				20: 	
                  out <= {in[19:0], in[31:20]};
				19: 	
                  out <= {in[18:0], in[31:19]};
				18: 	
                  out <= {in[17:0], in[31:18]};
				17: 	
                  out <= {in[16:0], in[31:17]};
				16:   
                  out <= {in[15:0], in[31:16]};
				15:   
                  out <= {in[14:0], in[31:15]};
				14:   
                  out <= {in[13:0], in[31:14]};
				13:   
                  out <= {in[12:0], in[31:13]};
				12:   
                  out <= {in[11:0], in[31:12]};
				11:   
                  out <= {in[10:0], in[31:11]};
				10:   
                  out <= {in[9:0], in[31:10]};
				9:   
                  out <= {in[8:0], in[31:9]};
				8:   
                  out <= {in[7:0], in[31:8]};
				7:   
                  out <= {in[6:0], in[31:7]};
				6:   
                  out <= {in[5:0], in[31:6]};
				5:   
                  out <= {in[4:0], in[31:5]};
				4:   
                  out <= {in[3:0], in[31:4]};
				3:   
                  out <= {in[2:0], in[31:3]};
				2:	
                  out <= {in[1:0], in[31:2]};
				1:
                  out <= {in[0], in[31:1]};
				default: out <= in;
		endcase
	end   
endmodule
