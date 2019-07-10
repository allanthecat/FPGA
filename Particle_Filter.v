//**Color Tracker**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: 1. track color according to pre-set color baseline
//				2. train the tracker using camera signal in certain area, and update baseline,
//					use new baseline for color tracking
//Note: this module is my individual work

//User instruction: turn on sw[16] to track new color based on training window

module Particle_Filter (
input [10:0] vga_x,vga_y,
input rst_n,
input clk,
input train_en,
input [7:0] r, g, b,//change to r, g, b for camera RGB input, instead of debugging frame
output reg [7:0] p_out
);

wire rgb_select;
wire inBox;
wire  inBox1;
wire [7:0] box_r,box_g,box_b;

//reg [7:0] r,g,b;
reg [5:0] counter;
reg [7:0] r_base = 245;
reg [7:0] g_base = 205;
reg [7:0] b_base = 148;
reg [600:0] r_sum,g_sum,b_sum;
reg [10:0] rx,ry,gx,gy,bx,by;
reg [7:0] r_diff,g_diff,b_diff;

//if training enable, reset baselines to track newly trained color
always@(posedge clk) begin
	if (train_en) begin
		r_sum <= (trainBox)? (r+r_sum):r_sum;
		g_sum <= (trainBox)? (g+g_sum):g_sum;
		b_sum <= (trainBox)? (b+b_sum):b_sum;
		counter <= counter + 1; 
		if (vga_y >= 19) begin
			r_base <= r_sum/64;
			g_base <= g_sum/64;
			b_base <= b_sum/64;
		end
		if(vga_y ==0 && vga_x ==0) begin
			r_sum <=0;g_sum<=0;b_sum<=0;
		end
	end
	else begin
		r_sum <= 0;
		g_sum <= 0;
		b_sum <= 0;
		r_base <= r_base;
		g_base <= g_base;
		b_base <= b_base;
	end
end



assign inBox1 = vga_x > 300 && vga_x <= 310 && vga_y > 200 && vga_y < 450;//mid bar, original color, should be shown originally
assign inBox2 = vga_x >= 40 && vga_x <= 60 && vga_y >= 40 && vga_y <= 60;//wrong color, never show
assign inBox3 = vga_x > 10 && vga_x <= 20 && vga_y > 200 && vga_y < 450;//left bar, should be shown if trained

assign inBox = vga_x > 10 && vga_x <= 18 && vga_y > 10 && vga_y <= 18;//fake input for debugging, same size as training box
assign trainBox = vga_x > 10 && vga_x <= 18 && vga_y > 10 && vga_y <= 18;//top left, training box

assign col_start = 	(vga_y <= 0)		? 1:0;//vertical scan of vga begin
assign row_start = 	(vga_x <= 0)		? 1:0;//vertical scan of vga begin
assign row_end = 		(vga_x >= 629)		? 1:0;//end of row of vga scan flag
assign col_end = 		(vga_y >= 479)		? 1:0;
assign frame_end = (row_end && col_end);

//debugging frame: overwrite the input camera RGB signal	
//always@(*) begin
//	if (inBox) begin
//		r = 150;g=250;b=150;//top left, same as training box
//	end
//	else if (inBox1) begin//mid bar,//shows originally
//		r=250;g=215;b=150;
//	end
//	else if (inBox2) begin// never show
//		r=10;g=10;b=10;
//	end
//	else if (inBox3) begin
//		r=150;g=250;b=150;//left bar, should be shown if trained
//	end
//	else begin
//		r=0;g=0;b=0;
//	end
//end
//wire [10:0] box_base_x ;
//wire [10:0] box_base_y ;
//assign box_base_x = vga_x_sum/(y_count);
//assign box_base_y = vga_y_sum/(x_count);
assign box_base_x = 320;
assign box_base_y = 240;
assign inBox0 =   (vga_x > (box_base_x-52) && vga_x <= (box_base_x-50)) 
					|| (vga_x > (box_base_x+50) && vga_x <= (box_base_x+52))
					|| (vga_y > (box_base_y-52) && vga_y <= (box_base_y-50))
					|| (vga_y > (box_base_y+50) && vga_y <= (box_base_y+52));
					
//wire color_bound;					
assign color_bound = (r_diff<7 && g_diff<5 && b_diff<5);

//reg [30:0] vga_x_sum ;
//reg [30:0] vga_y_sum ;
//reg [18:0] x_count ;
//reg [18:0] y_count ;	
							
always @(posedge clk) begin
	r_diff <= (r > r_base)?(r-r_base) : (r_base-r);
	g_diff <= (g > g_base)?(g-g_base) : (g_base-g);
	b_diff <= (b > b_base)?(b-b_base) : (b_base-b);
	p_out <= (color_bound || inBox0)? 255 : 0; 
	//draw a box
//	if (frame_end) begin
//		vga_x_sum <= 0;
//		vga_y_sum <= 0;
//		x_count <= 0;
//		y_count <= 0;
//	end
//	else begin
//		if (color_bound) begin
//			vga_x_sum <= vga_x_sum+vga_x;
//			vga_y_sum <= vga_y_sum+vga_y;
//			x_count <= x_count+1;
//			y_count <= y_count+1;
//		end
//		else begin
//			vga_x_sum <= vga_x_sum;
//			vga_y_sum <= vga_y_sum;
//			x_count <= x_count;
//			y_count <= y_count;
//		end
//	end
end

endmodule
