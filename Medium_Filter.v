//**Median Filter**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: use 9 line buffered pixels to find the mean value and display
//Note: this module is my individual work

module Median_Filter(
input clk,
input rst_n,
input en,
input [7:0] r0,r1,r2,
output reg en_m,
output reg [7:0] median_out
);

reg [7:0] r00,r000,r11,r111,r22,r222;

always@(posedge clk, negedge rst_n) begin

	//output control, reset and gives enable signals for other modules if they would like to use this signal
	if (!rst_n)begin//if reset, clear all the registers
		median_out <= 0;
		en_m<=0;
		r00 <= 0;
		r000 <= 0;
		r11 <= 0;
		r111 <= 0;
		r22 <= 0;
		r222 <= 0;
	end
	else begin
		en_m<=en;
		if(en) begin//register 9 pixels
			r00 <= r0;
			r000<= r00;
			r11 <= r1;
			r111<= r11;
			r22 <= r2;
			r222<= r22;
			median_out <= (r0+r00+r000+r1+r11+r111+r2+r22+r222)/9;//calculate the mean of 9 pixels
		end
		else
			median_out<=0;
	end
end

endmodule
	
		



