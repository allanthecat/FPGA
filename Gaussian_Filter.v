//**Median Filter**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: use 9 line buffered pixels for gaussian filtering
//Note: this module is my individual work

module Gaussian_Filter(
input clk,
input rst_n,
input en,
input [7:0] r0,r1,r2,
output reg en_g,
output reg [7:0] gaussian_out
);

parameter normalization  = 16;

// Gaussian kernal - image bluring/for downsampling
parameter g1 = 8'h01, g2 = 8'h02, g3 = 8'h01;
parameter g4 = 8'h02, g5 = 8'h04, g6 = 8'h02;
parameter g7 = 8'h01, g8 = 8'h02, g9 = 8'h01;

wire [16:0] r0_out_g,r1_out_g,r2_out_g;
wire [18:0] temp_g;

//each clock cycle, shift one pixel in, do multiplication with corresponding kernel parameter
//add the multiplication reslut
//totally cache 3 pixels in one line
Multi_Add Multi_Add_g0(
  .aclr3(!rst_n),
  .clock0(clk),
  .dataa_0(r0),
  .datab_0(g9),
  .datab_1(g8),
  .datab_2(g7),//
  .result(r0_out_g)
);
//for another line, parallel with previous block	
Multi_Add Multi_Add_g1(
  .aclr3(!rst_n),
  .clock0(clk),
  .dataa_0(r1),
  .datab_0(g6),
  .datab_1(g5),
  .datab_2(g4),
  .result(r1_out_g)
);
//for another line, parallel with previous block
Multi_Add Multi_Add_g2(
  .aclr3(!rst_n),
  .clock0(clk),
  .dataa_0(r2),
  .datab_0(g3),
  .datab_1(g2),
  .datab_2(g1),
  .result(r2_out_g)
);

//sum previous three blocks multiadd result
Prl_Add Par_Add_g0 (
  .clock(clk), //output delay for 2 clock cycle
  .data0x(r0_out_g),
  .data1x(r1_out_g),
  .data2x(r2_out_g),
  .result(temp_g) 
);

//gaussian normalization
wire [7:0] gaussian_normalized;
assign gaussian_normalized = temp_g/normalization;

//output control, reset and gives enable signals for other modules if they would like to use this signal
always@(posedge clk, negedge rst_n) begin
	
	if (!rst_n)begin
		gaussian_out <= 0;
		en_g<=0;
	end
	else begin
		en_g<=en;
		if(en)
			gaussian_out <= gaussian_normalized;
		else
			gaussian_out<=0;
	end
end


endmodule 