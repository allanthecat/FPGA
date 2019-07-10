//**Seven segment decoder 4 to 7**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: low level control to light up specific LED
//Note: this module is my individual work

module SevSegDec4to7(
input wire [3:0] code,
input wire reset,
output reg [6:0] HEX);
	always @(*) begin: SevSegDec4to7_case
		if(reset) begin
			HEX=7'b0000000;//0
		end
		else begin
			case(code)
				4'b0000: HEX=7'b1000000;//0
				4'b0001: HEX=7'b1111001;//1
				4'b0010: HEX=7'b0100100;//2
				4'b0011: HEX=7'b0110000;//3
				4'b0100: HEX=7'b0011001;//4
				4'b0101: HEX=7'b0010010;//5
				4'b0110: HEX=7'b0000010;//6
				4'b0111: HEX=7'b1111000;//7
				4'b1000: HEX=7'b0000000;//8
				4'b1001: HEX=7'b0010000;//9
				4'b1010: HEX=7'b0001001;//H
				4'b1011: HEX=7'b0000110;//E
				4'b1100: HEX=7'b1000111;//L
				4'b1101: HEX=7'b1000000;//O
				4'b1110: HEX=7'b1111111;//C or U,S or nothing
				4'b1111: HEX=7'b0001110;//F
				default: HEX=7'b1111111;
			endcase
		end
	end
endmodule
