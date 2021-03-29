`timescale 1ns/10ps

module rol32(

  input  [31:0] in,
  input  [31:0] num_rotate,

  output reg [31:0] out
);
  
   wire [4:0] temp;
    assign temp = num_rotate % 32;
  
	always@(*) begin
      case(temp)
				31:
                  out <= {in[0], in[31:1]};
				30:
                  out <= {in[1:0], in[31:2]};
				29:
                  out <= {in[2:0], in[31:3]};
				28: 	
                  out <= {in[3:0], in[31:4]};
				27: 	
                  out <= {in[4:0], in[31:5]};
				26: 	
                  out <= {in[5:0], in[31:6]};
				25: 	
                  out <= {in[6:0], in[31:7]};
				24: 	
                  out <= {in[7:0], in[31:8]};
				23: 	
                  out <= {in[8:0], in[31:9]};
				22: 	
                  out <= {in[9:0], in[31:10]};
				21: 	
                  out <= {in[10:0], in[31:11]};
				20: 	
                  out <= {in[11:0], in[31:12]};
				19: 	
                  out <= {in[12:0], in[31:13]};
				18: 	
                  out <= {in[13:0], in[31:14]};
				17: 	
                  out <= {in[14:0], in[31:15]};
				16:   
                  out <= {in[15:0], in[31:16]};
				15:   
                  out <= {in[16:0], in[31:17]};
				14:   
                  out <= {in[17:0], in[31:18]};
				13:   
                  out <= {in[18:0], in[31:19]};
				12:   
                  out <= {in[19:0], in[31:20]};
				11:   
                  out <= {in[20:0], in[31:21]};
				10:   
                  out <= {in[21:0], in[31:22]};
				9:   
                  out <= {in[22:0], in[31:23]};
				8:   
                  out <= {in[23:0], in[31:24]};
				7:   
                  out <= {in[24:0], in[31:25]};
				6:   
                  out <= {in[25:0], in[31:26]};
				5:   
                  out <= {in[26:0], in[31:27]};
				4:   
                  out <= {in[27:0], in[31:28]};
				3:   
                  out <= {in[28:0], in[31:29]};
				2:	
                  out <= {in[29:0], in[31:30]};
				1:
                  out <= {in[30:0], in[31]};
				default: out <= in;
		endcase
	end
endmodule
