module OneDigiCounter(
input wire [9:0] hot,
input wire reset,
output wire [6:0] HEX);
	reg [3:0] code;
	SevSegDec4to7 SevSegDec4to7_0(.code(code[3:0]),   .HEX(HEX), .reset(reset));
	always @(*) begin: DigiRotate
		if(reset) begin
			code = 4'b0000;
		end
		else begin
			case(hot)
			   10'b0000000001:  code = 4'd0;//0
				10'b0000000010:  code = 4'd1;//1
				10'b0000000100:  code = 4'd2;//2
				10'b0000001000:  code = 4'd3;//3
				10'b0000010000:  code = 4'd4;//4
				10'b0000100000:  code = 4'd5;//5
				10'b0001000000:  code = 4'd6;//6
				10'b0010000000:  code = 4'd7;//7
				10'b0100000000:  code = 4'd8;//8
				10'b1000000000:  code = 4'd9;//9
				default:         code = 4'd0;//0
			endcase
		end
	end
	
	
endmodule