//**Digi rotate using heartbeat generator**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: shows rotating words "HELLO" in seven segment LED
//Note: this module is my individual work

module DigiRotate8(
input wire reset,
input wire clk,
input wire select,
output wire [6:0] HEX0,
output wire [6:0] HEX1,
output wire [6:0] HEX2,
output wire [6:0] HEX3,
output wire [6:0] HEX4,
output wire [6:0] HEX5,
output wire [6:0] HEX6,
output wire [6:0] HEX7
);

wire beat;//output from heartbeat generator module, each beat enable one-hot encoded shift to rotate seven-seg LED
reg [7:0] code = 8'b00000001;//default one-hot code

//heartbeat generator to generate heartbeat signal
HeartBeat #(27) HeartBeat_0 (.reset(reset),.beat(beat),.clk(clk));	
//Digi dislay module, encode the word "HELLO"
EightDigiDisplay EightDigiDisplay_1 (
	.HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), 
	.HEX4(HEX4), .HEX5(HEX5), .HEX6(HEX6), .HEX7(HEX7), 
	.hot(code));

//at each beat, shift the one-hot code	
always @(posedge beat) begin
	if(reset) begin //reset
		code <= 8'b00000001;
	end
	else begin 
		code <= {code[6],code[5],code[4],code[3],
		code[2],code[1],code[0],code[7]};
	end
end
endmodule 