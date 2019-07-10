//**Function select of my image processing system**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: 1. instantiate every image processing function
//				2. select output signals based on switch input
//Note: this module is my individual work
//User instruction: activate either one of the switch from sw[9] to sw[0]

module Function_Select(
input clk,
input [9:0] function_select,
input CLOCK_50,
input [7:0] grey_in,
input [7:0] r_in,
input [7:0] g_in,
input [7:0] b_in,
input rst_n,
input en,
input train_en,
input [10:0] vga_x,vga_y,
input [19:0] vga_addr,

output reg [7:0] grey_out
);

//binary image filter instantiation
wire [7:0] binary_out;
Binary_Img Binary_Img_0 (.grey_in(grey_in),.threshold(50),//in
								.grey_out(binary_out));//out
								

//line buffer instantiation, sharing for two filters
wire [7:0] r0,r1,r2;
Line_Buffer_3 Line_Buffer_3_1 (.clock(clk),.clken(en),.shiftin(grey_in),.taps({r2,r1,r0}));

//median filter instantiation
wire en_m;
wire [7:0] median_out;
Median_Filter Median_Filter_0(.clk(clk),.rst_n(rst_n),.en(en),.r0(r0),.r1(r1),.r2(r2),//input
											.en_m(en_m),.median_out(median_out));//output
							
//Gaussian image filter instantiation
wire en_g;
wire [7:0] gaussian_out;
Gaussian_Filter Gaussian_Filter_0(.clk(clk),.rst_n(rst_n),.en(en),.r0(r0),.r1(r1),.r2(r2),//input
											.en_g(en_g),.gaussian_out(gaussian_out));//output

//Sobel image filter instantiation
wire en_s;
wire [7:0] sobel_out;
wire [21:0] edge_x,edge_y,edge_xy;
Sobel_Filter Sobel_Filter_0(.clk(clk),.rst_n(rst_n),.en(en),.r0(r0),.r1(r1),.r2(r2),//input
									.edge_xy(edge_xy),
									.en_s(en_s),.sobel_out(sobel_out),//output
									.edge_x(edge_x),.edge_y(edge_y));

//downsampling frame 1/4
wire en_d;
wire [7:0] downsampling_out;
wire [7:0] integral_out;
Downsampling Downsampling_0 (.clk(clk),.rst_n(rst_n),.en(en_g),.data_in(gaussian_out),.r0(r0),.r1(r1),.r2(r2),
									.vga_x(vga_x),.vga_y(vga_y),
									.vga_addr(vga_addr),//input			
									.en_d(en_d),.downsampling_out(downsampling_out),
									.integral_out(integral_out));//output

//generate histogram for gaussian and original image
wire [7:0] hist_out;								
Histogram Histogram_0 (.vga_x(vga_x),.vga_y(vga_y),.clk(clk),.grey_in(grey_in),.rst_n(rst_n),//input
								.grey_in1(gaussian_out),
								.hist_out(hist_out));//output

//generate corner image on vga
wire en_h;
wire [7:0] harris_out;
Harris_Corner Harris_Corner_0(.clk(clk),.rst_n(rst_n),.en(en_s),.r0(r0),.r1(r1),.r2(r2),
										.edge_x(edge_x),.edge_y(edge_y),
										.en_h(en_h),.harris_out(harris_out));	

//particle color tracker
wire en_p;
wire [7:0] p_out;
Particle_Filter Particle_Filter_0 (.vga_x(vga_x),.vga_y(vga_y),.clk(clk),.r(r_in),.g(g_in),.b(b_in),.rst_n(rst_n),
												.train_en(train_en),
												.p_out(p_out));
												
//function selection based on slide switch	
always @(posedge clk) begin
	case (function_select)//from sw[0] to sw[9]...following the instructions below to switch output
		10'b0000000001: begin
			grey_out <= binary_out;//activate sw[0] only for binary output
		end
		10'b0000000010: begin
			grey_out <= median_out;//activate sw[1] only for median filter output
		end
		10'b0000000100: begin
			grey_out <= gaussian_out;//activate sw[2] only for gaussian output
		end
		10'b0000001000: begin
			grey_out <= sobel_out;//activate sw[3] only for sobel edge detection output
		end
		10'b0000010000: begin
			grey_out <= hist_out;//activate sw[4] only for histogram output (orignial vs. gaussian)
		end
		10'b0000100000: begin
			grey_out <= harris_out;//activate sw[5] only for harris corner output
		end
		10'b0001000000: begin
			grey_out <= downsampling_out;//activate sw[6] only for downsampling output
		end
		10'b0010000000: begin
			grey_out <= integral_out;//activate sw[7] only for integral image output
		end
		10'b0100000000: begin
			grey_out <= p_out;//activate sw[8] only for color tracker output
		end
		default: begin
			grey_out <= grey_in;//default gives grey signal
		end
	endcase
end


endmodule 
			