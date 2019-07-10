//**Doonsampling**
//Author: Ruoxiang Wen student ID u5752771 ANU
//Function: 1. using vga_x vga_y and interanl addressing to downsample and cache pixels in RAM
//          2. calculate integral image

//Note: this module is my individual work
//The integral image part of this module uncompleted

module Downsampling(
input clk,
input rst_n,
input [10:0] vga_x,vga_y,
input [19:0] vga_addr,
input en,
input [7:0] r0,r1,r2,
input [7:0] data_in,
output reg en_d,
output reg [7:0] integral_out,
output reg [7:0] downsampling_out
);

reg  wren_a;
reg [15:0] addr_a;
reg [7:0] addr_l;
reg [9:0] sum;
reg [9:0] sum_row;
wire [9:0] sum_ram_out;

wire [7:0] r0_out;
wire [7:0] r1_out;
wire x_en;
wire y_en;
wire col_start;
wire row_start;
wire row_end;
wire col_end;
wire frame_end;
						
assign x_en = 			((vga_x)%4 == 0)	? 1:0;//change the demorninator to change the downsampling rate
assign y_en = 			((vga_y)%4 == 0)	? 1:0;//change the demorninator to change the downsampling rate
assign col_start = 	(vga_y <= 0)		? 1:0;//vertical scan of vga begin
assign row_start = 	(vga_x <= 0)		? 1:0;//vertical scan of vga begin
assign row_end = 		(vga_x >= 629)		? 1:0;//end of row of vga scan flag
assign col_end = 		(vga_y >= 479)		? 1:0;
assign frame_end = (row_end && col_end);

//RAM of cumulative sum
//RAM_Line_1 RAM_Line_1_0 (.address(addr_l),.clock(clk),.data(sum),.wren(wren_a),.q(sum_ram_out));
reg [9:0] ram_vec [320:0];

//wire [7:0] r2_ram,r1_ram,r0_ram;
//Line_Buffer_3 Line_Buffer_3_1 (.clock(clk),.clken(en),.shiftin(sum),.taps({r2_ram,r1_ram,r0_ram}));		
							
always@(posedge clk or negedge rst_n) begin

//output control, reset and gives enable signals for other modules if they would like to use this signal
	if (!rst_n) begin  //if reset, set every signal to zero
		downsampling_out <= 0;
		en_d<=0;
		addr_a <= 0;
		wren_a <= 0;
		sum <= 0;
		sum_row<=0;
		addr_l <=0;
	end
	else begin		//*****address and write enable control*****//
		en_d<=en;
		//if in first line, or at the end of ram address, set write enable and address to frame RAM to 0
		if ((col_start && row_start) || addr_a >= 19199 ) begin	
			wren_a <=0;
			addr_a <=0;
			addr_l <=0;
		end
		//else address can be incremented and write enable is 1
		else begin
			addr_a <= (x_en && y_en)? (addr_a + 1 ) : addr_a;
			wren_a <= (x_en && y_en);
			
			addr_l <= (row_start)? 0: ((x_en && y_en)? (addr_l + 1 ) : addr_l);
			
			sum_row 	<= (row_start || col_end)? 0 : ((x_en && y_en) ? (data_in + sum_row) : sum_row);
			
			sum 		<= (col_end)? 0 : ((x_en && y_en)? (ram_vec[addr_l] + sum_row):sum);
			
			ram_vec[addr_l] <= (col_end)? 0: ((x_en && y_en) 	? sum : ram_vec[addr_l]);
			//*****integral image calculation according to the address and write enable generated above*****//
		end	
			//****due to signal overflow, use this medhod to visualize data****//
			//data overflow, bus width too large to be complied, set overflowed signals to 255 to visualize data
			
		if (sum>255 || sum_row> 255) begin 
			sum<=255;
			sum_row<=255;
				//downsampling_out <= (x_en && y_en)? 255:0;
		end
		else begin
			downsampling_out <= (x_en && y_en)? (r1_out):0;//display every sampled pix in the frame ram to check addressing problem
			integral_out <= (x_en && y_en)? (r0_out):0;
		end
			
	end
end



//frame storage
//downsampled image
Frame_Ram Frame_Ram_1 (
							.address_a(addr_a),
							.address_b(),
							.clock(clk),
							.data_a(data_in),
							.data_b(),
							.wren_a(wren_a),
							.wren_b(0), 
							.q_a(r1_out),//out put the old data to check the addressing
							.q_b());
						
//downsampled integral image
Frame_Ram Frame_Ram_0 (
							.address_a(addr_a),
							.address_b(),
							.clock(clk),
							.data_a(sum),
							.data_b(),
							.wren_a(wren_a),
							.wren_b(0), 
							.q_a(r0_out),//out put the old data to check the addressing
							.q_b());



							
endmodule 