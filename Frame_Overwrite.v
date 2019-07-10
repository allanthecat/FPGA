//**Frame overwrite with chessboard frame**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: generate a chessboard frame for debugging, this is a clearer image 
//				compared to camera signal
//Note: this module is my individual work
//Reference: http://www.fpga4fun.com/PongGame.html

module Frame_Overwrite(
input [10:0] vga_x,vga_y,
input clk,
output [7:0] chressboard
);

reg [7:0]  h_dat;
reg [7:0]   v_dat;

assign chressboard = v_dat^h_dat;

always @(posedge clk) //vertical stripes, 640 width
begin
	if(vga_x < 640-620)//spare
		v_dat <= 8'h00;
	else if(vga_x < 640-576)
		v_dat <= 8'h01;
	else if(vga_x < 640-529)
		v_dat <= 8'h04;
	else if(vga_x < 640-484)
		v_dat <= 8'h09;
	else if(vga_x < 640-441)
		v_dat <= 8'h19;
	else if(vga_x < 640-400)
		v_dat <= 8'h24;
	else if(vga_x < 640-361)
		v_dat <= 8'h31;
	else if(vga_x < 640-324)
		v_dat <= 8'h79;
	else if(vga_x < 640-289)
		v_dat <= 8'ha9;
	else if(vga_x < 640-256)
		v_dat <= 8'hff;
	else if(vga_x < 640-225)
		v_dat <= 8'h00;
	else if(vga_x < 640-196)
		v_dat <= 8'hff;
	else if(vga_x < 640-169)
		v_dat <= 8'h00;
	else if(vga_x < 640-144)
		v_dat <= 8'hff;
	else if(vga_x < 640-121)
		v_dat <= 8'h00;
	else if(vga_x < 640-100)
		v_dat <= 8'hff;
	else if(vga_x < 640-81)
		v_dat <= 8'h00;
	else if(vga_x < 640-64)
		v_dat <= 8'hff;
	else if(vga_x < 640-49)
		v_dat <= 8'h00;
	else if(vga_x < 640-36)
		v_dat <= 8'hff;
	else if(vga_x < 640-25)
		v_dat <= 8'h00;
	else if(vga_x < 640-16)
		v_dat <= 8'hff;
	else if(vga_x < 640-9)
		v_dat <= 8'h00;
	else if(vga_x < 640-4)
		v_dat <= 8'hff;
	else if(vga_x < 640-1)
		v_dat <= 8'h00;
	else 
		v_dat <= 8'hff;//dense
end

always @(posedge clk) //horizontal stripes, 480 depth
begin
	if(vga_y < 480-441)		//spare
		h_dat <= 8'h00;
	else if(vga_y < 480-400)
		h_dat <= 8'h01;
	else if(vga_y < 480-361)
		h_dat <= 8'h04;
	else if(vga_y < 480-324)
		h_dat <= 8'h09;
	else if(vga_y < 480-289)
		h_dat <= 8'h19;
	else if(vga_y < 480-256)
		h_dat <= 8'h24;
	else if(vga_y < 480-225)
		h_dat <= 8'h31;
	else if(vga_y < 480-196)
		h_dat <= 8'h79;
	else if(vga_y < 480-169)
		h_dat <= 8'ha9;
	else if(vga_y < 480-144)
		h_dat <= 8'he1;
	else if(vga_y < 480-121)
		h_dat <= 8'hff;
	else if(vga_y < 480-100)
		h_dat <= 8'h00;
	else if(vga_y < 480-81)
		h_dat <= 8'hff;
	else if(vga_y < 480-64)
		h_dat <= 8'h00;
	else if(vga_y < 480-49)
		h_dat <= 8'hff;
	else if(vga_y < 480-36)
		h_dat <= 8'h00;
	else if(vga_y < 480-25)
		h_dat <= 8'hff;
	else if(vga_y < 480-16)
		h_dat <= 8'h00;
	else if(vga_y < 480-9)
		h_dat <= 8'hff;
	else if(vga_y < 480-4)
		h_dat <= 8'h00;
	else if(vga_y < 480-1)
		h_dat <= 8'hff;
	else 						//480 dense
		h_dat <= 8'h00;//black
end

endmodule 
