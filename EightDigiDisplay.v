//**Eight digi display**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: encode the word "HELLO"
//Note: this module is my individual work

module EightDigiDisplay(
input wire [9:0] hot,
input wire reset,
output wire [6:0] HEX0,
output wire [6:0] HEX1,
output wire [6:0] HEX2,
output wire [6:0] HEX3,
output wire [6:0] HEX4,
output wire [6:0] HEX5,
output wire [6:0] HEX6,
output wire [6:0] HEX7
);
	reg [31:0] code;
	SevSegDec4to7 SevSegDec4to7_0(.code(code[3:0]),   .HEX(HEX0), .reset(reset));
	SevSegDec4to7 SevSegDec4to7_1(.code(code[7:4]),   .HEX(HEX1), .reset(reset));
	SevSegDec4to7 SevSegDec4to7_2(.code(code[11:8]),  .HEX(HEX2), .reset(reset));
	SevSegDec4to7 SevSegDec4to7_3(.code(code[15:12]), .HEX(HEX3), .reset(reset));
	SevSegDec4to7 SevSegDec4to7_4(.code(code[19:16]), .HEX(HEX4), .reset(reset));
	SevSegDec4to7 SevSegDec4to7_5(.code(code[23:20]), .HEX(HEX5), .reset(reset));
	SevSegDec4to7 SevSegDec4to7_6(.code(code[27:24]), .HEX(HEX6), .reset(reset));
	SevSegDec4to7 SevSegDec4to7_7(.code(code[31:28]), .HEX(HEX7), .reset(reset));
	always @(*) begin: DigiRotate
		if(reset) begin
			code = 31'b00000000000000000000000000000000;
		end
		else begin
			case(hot)
			   10'b0000000001:  code = 32'b10101011110011001101111011101110;//HELLO_ _ _
				10'b0000000010:  code = 32'b11101010101111001100110111101110;//1
				10'b0000000100:  code = 32'b11101110101010111100110011011110;//2
				10'b0000001000:  code = 32'b11101110111010101011110011001101;//3
				10'b0000010000:  code = 32'b11011110111011101010101111001100;//4
				10'b0000100000:  code = 32'b11001101111011101110101010111100;//5
				10'b0001000000:  code = 32'b11001100110111101110111010101011;//6
				10'b0010000000:  code = 32'b10111100110011011110111011101010;//7
				10'b0100000000:  code = 32'b10101011110011001101111011101110;//8
				10'b1000000000:  code = 32'b11101010101111001100110111101110;//9
				default:         code = 32'b11111111111111111111111111111111;//blank
			endcase
		end
	end
	
	
endmodule