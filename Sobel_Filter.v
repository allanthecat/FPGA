//**Median Filter**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: use 9 line buffered pixels for gaussian filtering
//Note: this module is my individual work with the reference code online to calculate the output of sobel filter using sqrt module


module Sobel_Filter(
input clk,
input rst_n,
input en,
input [7:0] r0,r1,r2,
output [21:0] edge_x, edge_y,edge_xy,
output reg en_s,
output reg [7:0] sobel_out
);

//Sobel kernal for vertical edges
parameter x1 = -8'h01, x2 = 8'h00, x3 = 8'h01;//negative 2' complement format: "invert the digits, and add one to the result"
parameter x4 = -8'h02, x5 = 8'h00, x6 = 8'h02;
parameter x7 = -8'h01, x8 = 8'h00, x9 = 8'h01;

//Sobel kernal for horizontal edges
parameter y1 = 8'h01, y2 = 8'h02, y3 = 8'h02;
parameter y4 = 8'h00, y5 = 8'h00, y6 = 8'h00;
parameter y7 = -8'h02, y8 = -8'h02, y9 = -8'h01;

//Sobel kernal for diagonal edges
//parameter xy1 = 8'h00, xy2 = 8'h01, xy3 = 8'h02;
//parameter xy4 = -8'h01, xy5 = 8'h00, xy6 = 8'h01;
//parameter xy7 = -8'h02, xy8 = -8'h01, xy9 = 8'h00;

wire [20:0] r0_out_x, r1_out_x, r2_out_x;//bit width = (8+8-1)+2 =17
wire [20:0] r0_out_y, r1_out_y, r2_out_y;
//wire [16:0] r0_out_xy, r1_out_xy, r2_out_xy;
wire [7:0] edges;
	
Multi_Add Multi_Add_s0(
  .aclr3(!rst_n),
  .clock0(clk),
  .dataa_0(r0),
  .datab_0(x9),
  .datab_1(x8),
  .datab_2(x7),//
  .result(r0_out_x)
);
	
Multi_Add Multi_Add_s1(
  .aclr3(!rst_n),
  .clock0(clk),
  .dataa_0(r1),
  .datab_0(x6),
  .datab_1(x5),
  .datab_2(x4),
  .result(r1_out_x)
);

Multi_Add Multi_Add_s2(
  .aclr3(!rst_n),
  .clock0(clk),
  .dataa_0(r2),
  .datab_0(x3),
  .datab_1(x2),
  .datab_2(x1),
  .result(r2_out_x)
);

Prl_Add Par_Add_s0 (
  .clock(clk), //output delay for 2 clk cycle
  .data0x(r0_out_x),
  .data1x(r1_out_x),
  .data2x(r2_out_x),
  .result(edge_x) 
);
//parallel operation, two filters works simultaneously
Multi_Add Multi_Add_0_s3(
  .aclr3(!rst_n),
  .clock0(clk),
  .dataa_0(r0),
  .datab_0(y9),
  .datab_1(y8),
  .datab_2(y7),//
  .result(r0_out_y)
);
	
Multi_Add Multi_Add_1_s4(
  .aclr3(!rst_n),
  .clock0(clk),
  .dataa_0(r1),
  .datab_0(y6),
  .datab_1(y5),
  .datab_2(y4),
  .result(r1_out_y)
);

Multi_Add Multi_Add_2_s5(
  .aclr3(!rst_n),
  .clock0(clk),
  .dataa_0(r2),
  .datab_0(y3),
  .datab_1(y2),
  .datab_2(y1),
  .result(r2_out_y)
);

Prl_Add Par_Add_s1 (
  .clock(clk), //output delay for 2 cycle
  .data0x(r0_out_y),
  .data1x(r1_out_y),
  .data2x(r2_out_y),
  .result(edge_y) 
);

//from flitered x y edges to magnitude of edge
Sqrt Sqrt_0 (
  .clk(clk), //output delay for 3 clk cycles
  .radical(edge_x * edge_x + edge_y * edge_y),
  .q(edges)
);
//
//Multi_Add Multi_Add_0_s6(
//  .aclr3(!rst_n),
//  .clock0(clk),
//  .dataa_0(r0),
//  .datab_0(xy9),
//  .datab_1(xy8),
//  .datab_2(xy7),//
//  .result(r0_out_xy)
//);
//	
//Multi_Add Multi_Add_1_s7(
//  .aclr3(!rst_n),
//  .clock0(clk),
//  .dataa_0(r1),
//  .datab_0(xy6),
//  .datab_1(xy5),
//  .datab_2(xy4),
//  .result(r1_out_xy)
//);
//
//Multi_Add Multi_Add_2_s8(
//  .aclr3(!rst_n),
//  .clock0(clk),
//  .dataa_0(r2),
//  .datab_0(xy3),
//  .datab_1(xy2),
//  .datab_2(xy1),
//  .result(r2_out_xy)
//);
//
//Prl_Add Par_Add_s2 (
//  .clock(clk), //output delay for 2 clk_200 cycle
//  .data0x(r0_out_xy),
//  .data1x(r1_out_xy),
//  .data2x(r2_out_xy),
//  .result(edge_xy) 
//);

//output control, reset and gives enable signals for other modules if they would like to use this signal
always@(posedge clk, negedge rst_n) begin
	
	if (!rst_n)begin
		sobel_out <= 0;
		en_s<=0;
	end
	else begin
		en_s<=en;
		if(en)
			sobel_out <= edges;
		else
			sobel_out<=0;
	end
end

endmodule 