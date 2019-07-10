//**Harris Corner Detector**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: use Gaussian, and sobel result to calculated corner
//Note: this module is my individual work
//Uncompleted module
module Harris_Corner(
input clk,
input rst_n,
input en,
input [7:0] r0,r1,r2,
input [21:0] edge_x, edge_y,edge_xy,
output reg en_h,
output reg [7:0] harris_out
);

wire [7:0] R;
wire [7:0] r0_edge_x,r1_edge_x,r2_edge_x;
wire [7:0] r0_edge_y,r1_edge_y,r2_edge_y;

Line_Buffer_3 Line_Buffer_3_2 (.clock(clk),.clken(en),.shiftin(edge_x),.taps({r2_edge_x,r1_edge_x,r0_edge_x}));
Line_Buffer_3 Line_Buffer_3_3 (.clock(clk),.clken(en),.shiftin(edge_y),.taps({r2_edge_y,r1_edge_y,r0_edge_y}));

wire[21:0] edge_x_g;
wire[21:0] edge_y_g;
wire[21:0] edge_xy_g; 

wire en_edge_x;
wire en_edge_y;
wire en_edge_xy;

assign en_R = (en_edge_x && en_edge_y && en_edge_xy);
//use sobels edges as input....
//gaussian filter for x edges
Gaussian_Filter Gaussian_Filter_edge_x(.clk(clk),.rst_n(rst_n),.en(en),
											.r0((r0_edge_x)*(r0_edge_x)),.r1((r1_edge_x)*(r1_edge_x)),.r2((r2_edge_x)*(r2_edge_x)),//input
											.en_g(en_g_edge_x),.gaussian_out(edge_x_g));//output
//gaussian filter for y edges											
Gaussian_Filter Gaussian_Filter_edge_y(.clk(clk),.rst_n(rst_n),.en(en),
											.r0((r0_edge_y)*(r0_edge_y)),.r1((r1_edge_y)*(r1_edge_y)),.r2((r2_edge_y)*(r2_edge_y)),//input
											.en_g(en_g_edge_y),.gaussian_out(edge_y_g));//output
//gaussian filter for xy edges											
Gaussian_Filter Gaussian_Filter_edge_xy(.clk(clk),.rst_n(rst_n),.en(en),
											.r0((r0_edge_y)*(r0_edge_x)),.r1((r1_edge_y)*(r1_edge_x)),.r2((r2_edge_y)*(r2_edge_x)),//input
											.en_g(en_g_edge_xy),.gaussian_out(edge_xy_g));//output
											
//assign R = edge_x*edge_y*edge_x*edge_y -edge_xy*edge_xy*edge_xy*edge_xy - (5*((edge_x*edge_y)+(edge_x*edge_y))>>8);//*0.02 approx
//assign R = 10000*edge_x_g * edge_y_g //corner term +1000*
//				-10000*edge_xy_g * edge_xy_g //edge term -1
//				- (10000*((edge_x_g+edge_y_g) * (edge_x_g+edge_y_g))>>5);//edge term

//the cornerness calculation is different from the c program, there may be overflow issues so I have to manually try some devision to show the corners
assign R = ((edge_x_g * edge_y_g - edge_xy_g * edge_xy_g - (((edge_x_g+edge_y_g) * (edge_x_g+edge_y_g)))));

//output control, reset and gives enable signals for other modules if they would like to use this signal
always@(posedge clk, negedge rst_n) begin
	
	if (!rst_n)begin
		harris_out <= 0;
		en_h<=0;
	end
	else begin
		en_h<=en;
		if(en)	
			harris_out <= R;
		else
			harris_out<=0;
	end
end 

endmodule 