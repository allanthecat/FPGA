module Histogram(
input [10:0] vga_x,vga_y,
input clk,
input [7:0] grey_in,
input [7:0] grey_in1,
input rst_n,
output [7:0] hist_out);

reg [19:0] count0,count1,count2,count3,count4,count5,count6,count7,count8,count9;
reg [19:0] count01,count11,count21,count31,count41,count51,count61,count71,count81,count91;
always @(posedge clk)begin
	if ((vga_y >= 479 && vga_x>= 639) || (~rst_n)) begin
		count0 <= 0;count1 <= 0;count2 <= 0;count3 <= 0;count4 <= 0;count5 <= 0;count6 <= 0;count7 <= 0;count8 <= 0;count9 <= 0;
		count01 <= 0;count11 <= 0;count21 <= 0;count31 <= 0;count41 <= 0;count51 <= 0;count61 <= 0;count71 <= 0;count81 <= 0;count91 <= 0;
	end
	else begin
		if (grey_in>=0 && grey_in<5)
			count0 <= count0 + 1;
		else if (grey_in>=5 && grey_in<10)
			count1 <= count1 + 1;
		else if (grey_in>=10 && grey_in<15)
			count2 <= count2 + 1;
		else if (grey_in>=15 && grey_in<20)
			count3 <= count3 + 1;
		else if (grey_in>=20 && grey_in<25)
			count4 <= count4 + 1;
		else if (grey_in>=25 && grey_in<30)
			count5 <= count5 + 1;
		else if (grey_in>=30 && grey_in<75)
			count6 <= count6 + 1;
		else if (grey_in>=75 && grey_in<200)
			count7 <= count7 + 1;
		else if (grey_in>=200 && grey_in<225)
			count8 <= count8 + 1;
		else
			count9 <= count9 + 1;
//
		if (grey_in1>=0 && grey_in1<5)
			count01 <= count01 + 1;
		else if (grey_in1>=5 && grey_in1<10)
			count11 <= count11 + 1;
		else if (grey_in1>=10 && grey_in1<15)
			count21 <= count21 + 1;
		else if (grey_in1>=15 && grey_in1<20)
			count31 <= count3 + 1;
		else if (grey_in>=20 && grey_in<25)
			count41 <= count41 + 1;
		else if (grey_in1>=25 && grey_in1<30)
			count51 <= count51 + 1;
		else if (grey_in>=30 && grey_in<75)
			count61 <= count61 + 1;
		else if (grey_in1>=75 && grey_in1<200)
			count71 <= count71 + 1;
		else if (grey_in1>=200 && grey_in1<225)
			count81 <= count81 + 1;
		else
			count91 <= count91 + 1;
	end

end

wire inBox0,inBox1,inBox2,inBox3,inBox4,inBox5,inBox6,inBox7,inBox8,inBox9;
wire inBox01,inBox11,inBox21,inBox31,inBox41,inBox51,inBox61,inBox71,inBox81,inBox91;
// scale by 8/3072 approximation
//count0
assign inBox0 = vga_x > 10 && vga_x <= 20 && vga_y > (480-((count0>>9) + (count0>>12))) && vga_y < 480;				
//count1
assign inBox1 = vga_x > 20 && vga_x <= 30 && vga_y > (480-((count1>>9) + (count1>>12))) && vga_y < 480;
//count2
assign inBox2 = vga_x > 30 && vga_x <= 40 && vga_y > (480-((count2>>9) + (count2>>12))) && vga_y < 480;			
//count3
assign inBox3 = vga_x > 40 && vga_x <= 50 && vga_y > (480-((count3>>9) + (count3>>12))) && vga_y < 480;					
//count4
assign inBox4 = vga_x > 50 && vga_x <= 60 && vga_y > (480-((count4>>9) + (count4>>12))) && vga_y < 480;
//count5
assign inBox5 = vga_x > 60 && vga_x <= 70 && vga_y > (480-((count5>>9) + (count5>>12))) && vga_y < 480;
//count6
assign inBox6 = vga_x > 70 && vga_x <= 80 && vga_y > (480-((count6>>9) + (count6>>12))) && vga_y < 480;
//count7
assign inBox7 = vga_x > 80 && vga_x <= 90 && vga_y > (480-((count7>>9) + (count7>>12))) && vga_y < 480;
//count8
assign inBox8 = vga_x > 90 && vga_x <= 100 && vga_y > (480-((count8>>9) + (count8>>12))) && vga_y < 480;
//count9
assign inBox9 = vga_x > 100 && vga_x <= 110 && vga_y > (480-((count9>>9) + (count9>>12))) && vga_y < 480;	

//
//count0
assign inBox01 = vga_x > 210 && vga_x <= 220 && vga_y > (480-((count01>>9) + (count01>>12))) && vga_y < 480;				
//count1
assign inBox11 = vga_x > 220 && vga_x <= 230 && vga_y > (480-((count11>>9) + (count11>>12))) && vga_y < 480;
//count2
assign inBox21 = vga_x > 230 && vga_x <= 240 && vga_y > (480-((count21>>9) + (count21>>12))) && vga_y < 480;			
//count3
assign inBox31 = vga_x > 240 && vga_x <= 250 && vga_y > (480-((count31>>9) + (count31>>12))) && vga_y < 480;					
//count4
assign inBox41 = vga_x > 250 && vga_x <= 260 && vga_y > (480-((count41>>9) + (count41>>12))) && vga_y < 480;
//count5
assign inBox51 = vga_x > 260 && vga_x <= 270 && vga_y > (480-((count51>>9) + (count51>>12))) && vga_y < 480;
//count6
assign inBox61 = vga_x > 270 && vga_x <= 280 && vga_y > (480-((count61>>9) + (count61>>12))) && vga_y < 480;
//count7
assign inBox71 = vga_x > 280 && vga_x <= 290 && vga_y > (480-((count71>>9) + (count71>>12))) && vga_y < 480;
//count8
assign inBox81 = vga_x > 290 && vga_x <= 300 && vga_y > (480-((count81>>9) + (count81>>12))) && vga_y < 480;
//count9
assign inBox91 = vga_x > 300 && vga_x <= 310 && vga_y > (480-((count91>>9) + (count91>>12))) && vga_y < 480;	
					
assign hist_out = (inBox9 ||inBox8 || inBox7 || inBox6 || inBox5 || inBox4 || inBox3 || inBox2 || inBox1 || inBox0 ||
						inBox91 ||inBox81 || inBox71 || inBox61 || inBox51 || inBox41 || inBox31 || inBox21 || inBox11 || inBox01
						) ? 8'hff : 0;

endmodule 