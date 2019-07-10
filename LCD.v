//copyright: ESLab2_LCD
//modified by Ruoxiang Wen:
//1. delete some functions, modify modules in one file
//2. add strings and sting selection function for different input
//3. add refreshing function to reset the LCD periodically using heartbeat signal


module	LCD (//Host Side
input	clk,
input rst_n,
input [9:0] function_select,
output [7:0] LCD_DATA,//LCD Side
output LCD_RW,
output reg LCD_EN,
output LCD_RS,
output LCD_BLON,
output LCD_ON);

assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b0;
assign LCD_RW = 1'b0;
assign LCD_DATA = mLCD_DATA;
assign LCD_RS = mLCD_RS;

//	Internal Wires/Registers
reg [5:0] LUT_INDEX;
reg [8:0] LUT_DATA;
reg [5:0] mLCD_ST;
reg [17:0] mDLY;
reg mLCD_Start;
reg [7:0] mLCD_DATA;
reg mLCD_RS;
reg mLCD_Done;
//
reg [4:0] Cont;
reg [1:0] ST;
reg preStart;
reg mStart;

parameter	CLK_Divide	=	16; //CLK
parameter	LCD_INTIAL	=	0;
parameter	LCD_LINE1	=	5;
parameter	LCD_CH_LINE	=	LCD_LINE1+16;
parameter	LCD_LINE2	=	LCD_LINE1+16+1;
parameter	LUT_SIZE	=	LCD_LINE1+32+1;
//parameter for indexing
parameter s_b_l = 9*15-1;
//default string
reg [s_b_l:0] string = {9'h123,9'h157,9'h145,9'h14c,9'h143,9'h14f,9'h14d,9'h145,9'h121,9'h120,9'h149,9'h14d,9'h141,9'h147,9'h145};
reg [s_b_l:0] string1 ={9'h146,9'h149,9'h14c,9'h154,9'h145,9'h152,9'h149,9'h147,9'h120,9'h153,9'h159,9'h153,9'h154,9'h145,9'h4d};
//based on the function select input signal to display different strings on LCD
always @(*) begin
	case(function_select)
		10'b0000000001: begin
			string = {9'h142,9'h149,9'h14e,9'h141,9'h152,9'h159,9'h120,9'h149,9'h14d,9'h141,9'h147,9'h145,9'h120,9'h120,9'h120};
			string1 ={9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120};
			//binary img
		end
		10'b0000000010: begin
			string = {9'h14d,9'h145,9'h144,9'h149,9'h141,9'h14e,9'h120,9'h146,9'h149,9'h14c,9'h154,9'h145,9'h152,9'h120,9'h120};
			string1 ={9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120};
			//Median Filter
		end
		10'b0000000100: begin
			string = {9'h147,9'h141,9'h155,9'h153,9'h153,9'h149,9'h141,9'h14e,9'h120,9'h146,9'h149,9'h14c,9'h154,9'h145,9'h152};
			string1 ={9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120};
			//Gaussian Filter
		end
		10'b0000001000: begin
			string = {9'h153,9'h14f,9'h142,9'h145,9'h14c,9'h120,9'h146,9'h149,9'h14c,9'h154,9'h145,9'h152,9'h120,9'h120,9'h120};
			string1 ={9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120};
			//Sobel Filter
		end
		10'b0000010000: begin
			string = {9'h148,9'h149,9'h153,9'h154,9'h14f,9'h147,9'h152,9'h141,9'h14d,9'h13a,9'h120,9'h120,9'h120,9'h120,9'h120};
			string1 ={9'h147,9'h152,9'h145,9'h159,9'h120,9'h156,9'h153,9'h12e,9'h120, 9'h147,9'h141,9'h155,9'h153,9'h153,9'h120};
			//histogram: grey vs. gaussian	
		end
		10'b0000100000: begin
			string = {9'h148,9'h141,9'h152,9'h152,9'h149,9'h153,9'h120,9'h143,9'h14f,9'h14e,9'h145,9'h152,9'h120,9'h120,9'h120};
			string1 ={9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120};
			//harris corner
		end
		10'b0001000000: begin
			string = {9'h144,9'h14f,9'h157,9'h14e,9'h145,9'h141,9'h14d,9'h150,9'h14c,9'h14e,9'h147,9'h120,9'h120,9'h120,9'h120};
			string1 ={9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120};
			//downsampling	
		end
		10'b0010000000: begin
			string = {9'h149,9'h14e,9'h154,9'h145,9'h147,9'h152,9'h14c,9'h120,9'h149,9'h14d,9'h141,9'h147,9'h145,9'h120,9'h120};
			string1 ={9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120};
			//Integral image
		end
		10'b0100000000: begin
			string = {9'h143,9'h14f,9'h14c,9'h14f,9'h152,9'h120,9'h154,9'h152,9'h141,9'h143,9'h145,9'h152,9'h120,9'h120,9'h120};
			string1 ={9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120,9'h120};
			//Color Tracker
		end	
		default: begin
			string = {9'h123,9'h157,9'h145,9'h14c,9'h143,9'h14f,9'h14d,9'h145,9'h121,9'h120,9'h149,9'h14d,9'h141,9'h147,9'h145};
			string1 ={9'h150,9'h152,9'h143,9'h145,9'h153,9'h153,9'h149,9'h147,9'h120,9'h153,9'h159,9'h153,9'h154,9'h145,9'h4d};
			//#welcome!image processing system 
		end
	endcase

	case(LUT_INDEX)
	//	Initial
	LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
	LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
	LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
	LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
	LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
	//	Line 1
	LCD_LINE1+0:	LUT_DATA	<=	string[s_b_l:s_b_l-8];	//	
	LCD_LINE1+1:	LUT_DATA	<=	string[s_b_l-9:s_b_l-8-9];	//	W
	LCD_LINE1+2:	LUT_DATA	<=	string[s_b_l-9*2:s_b_l-8-9*2];	//	E
	LCD_LINE1+3:	LUT_DATA	<=	string[s_b_l-9*3:s_b_l-8-9*3];	//	L
	LCD_LINE1+4:	LUT_DATA	<=	string[s_b_l-9*4:s_b_l-8-9*4];	//	C
	LCD_LINE1+5:	LUT_DATA	<=	string[s_b_l-9*5:s_b_l-8-9*5];	//	O
	LCD_LINE1+6:	LUT_DATA	<=	string[s_b_l-9*6:s_b_l-8-9*6];	//	M
	LCD_LINE1+7:	LUT_DATA	<=	string[s_b_l-9*7:s_b_l-8-9*7];	//	E
	LCD_LINE1+8:	LUT_DATA	<=	string[s_b_l-9*8:s_b_l-8-9*8];	//	!
	LCD_LINE1+9:	LUT_DATA	<=	string[s_b_l-9*9:s_b_l-8-9*9];	//	I
	LCD_LINE1+10:	LUT_DATA	<=	string[s_b_l-9*10:s_b_l-8-9*10];	//	M
	LCD_LINE1+11:	LUT_DATA	<=	string[s_b_l-9*11:s_b_l-8-9*11];	//	A
	LCD_LINE1+12:	LUT_DATA	<=	string[s_b_l-9*12:s_b_l-8-9*12];	//	G
	LCD_LINE1+13:	LUT_DATA	<=	string[s_b_l-9*12:s_b_l-8-9*12];	//	E
	LCD_LINE1+14:	LUT_DATA	<=	string[s_b_l-9*13:s_b_l-8-9*13];	//
	LCD_LINE1+15:	LUT_DATA	<=	string[s_b_l-9*14:s_b_l-8-9*14];	//
	//	Change Line
	LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
	//	Line 2
	LCD_LINE2+0:	LUT_DATA	<=	string1[s_b_l:s_b_l-8];	//	
	LCD_LINE2+1:	LUT_DATA	<=	string1[s_b_l-9:s_b_l-8-9];	//	W
	LCD_LINE2+2:	LUT_DATA	<=	string1[s_b_l-9*2:s_b_l-8-9*2];	//	E
	LCD_LINE2+3:	LUT_DATA	<=	string1[s_b_l-9*3:s_b_l-8-9*3];	//	L
	LCD_LINE2+4:	LUT_DATA	<=	string1[s_b_l-9*4:s_b_l-8-9*4];	//	C
	LCD_LINE2+5:	LUT_DATA	<=	string1[s_b_l-9*5:s_b_l-8-9*5];	//	O
	LCD_LINE2+6:	LUT_DATA	<=	string1[s_b_l-9*6:s_b_l-8-9*6];	//	M
	LCD_LINE2+7:	LUT_DATA	<=	string1[s_b_l-9*7:s_b_l-8-9*7];	//	E
	LCD_LINE2+8:	LUT_DATA	<=	string1[s_b_l-9*8:s_b_l-8-9*8];	//	!
	LCD_LINE2+9:	LUT_DATA	<=	string1[s_b_l-9*9:s_b_l-8-9*9];	//	I
	LCD_LINE2+10:	LUT_DATA	<=	string1[s_b_l-9*10:s_b_l-8-9*10];	//	M
	LCD_LINE2+11:	LUT_DATA	<=	string1[s_b_l-9*11:s_b_l-8-9*11];	//	A
	LCD_LINE2+12:	LUT_DATA	<=	string1[s_b_l-9*12:s_b_l-8-9*12];	//	G
	LCD_LINE2+13:	LUT_DATA	<=	string1[s_b_l-9*12:s_b_l-8-9*12];	//	E
	LCD_LINE2+14:	LUT_DATA	<=	string1[s_b_l-9*13:s_b_l-8-9*13];	//
	LCD_LINE2+15:	LUT_DATA	<=	string1[s_b_l-9*14:s_b_l-8-9*14];	//
	default:		LUT_DATA	<=	9'h120;
	endcase
end
//periodically update the command to refresh the LCD screen to change contents of display using heartbeat generator
wire refresh;
HeartBeat #(26) HeartBeat_1(.clk(clk),.reset(0),.beat(refresh));
//add refresh signal to orignial LCD control
always@(posedge clk or negedge rst_n or posedge refresh) begin //or negedge reset
	if(!rst_n || refresh) begin //!reset
		LUT_INDEX <= 0;
		mLCD_ST <= 0;
		mDLY <= 0;
		mLCD_Start <= 0;
		mLCD_DATA <= 0;
		mLCD_RS <= 0;
		//
		mLCD_Done	<=	1'b0;
		LCD_EN <= 1'b0;
		preStart<= 1'b0;
		mStart <=	1'b0;
		Cont <= 0;
		ST	 <= 0;
	end
	else begin
		//////	Input Start Detect ///////
		preStart<=	mLCD_Start;
		if({preStart,mLCD_Start}==2'b01) begin
			mStart	<=	1'b1;
			mLCD_Done	<=	1'b0;
		end
		//////////////////////////////////
		if(mStart) begin
			case(ST)
			0:	ST	<=	1;	//	Wait Setup
			1:	begin
					LCD_EN <= 1'b1;
					ST <=	2;
				end
			2:	begin					
					if(Cont<CLK_Divide)
					Cont <=	Cont+1;
					else
					ST <=	3;
				end
			3:	begin
					LCD_EN <= 1'b0;
					mStart <= 1'b0;
					mLCD_Done	<=	1'b1;
					Cont <= 0;
					ST <=	0;
				end
			endcase
		end
		case(mLCD_ST)
		0:	begin
				if (LUT_INDEX<LUT_SIZE) begin
					mLCD_DATA	<=	LUT_DATA[7:0];
					mLCD_RS		<=	LUT_DATA[8];
					mLCD_Start	<=	1;
					mLCD_ST		<=	1;
				end else
					mLCD_ST	<= 5;
			end
		1:	begin
				if(mLCD_Done) begin
					mLCD_Start	<=	0;
					mLCD_ST		<=	2;					
				end
			end
		2:	begin
				if(mDLY<18'h3FFFE)
				mDLY	<=	mDLY+1;
				else begin
					mDLY	<=	0;
					mLCD_ST	<=	3;
				end
			end
		3:	begin
				if(LUT_INDEX<LUT_SIZE) begin
					LUT_INDEX	<=	LUT_INDEX+1;
					mLCD_ST	<=	0;
				end
			end
		endcase
	end
end

endmodule
