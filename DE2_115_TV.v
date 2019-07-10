//FPGA image processing system module**
//Modified by: Ruoxiang Wen student ID u5752771 ANU
//Function: 1. Instantiate lower level module
//				2. Specify input output in coordination with the pin assignment

module DE2_115_TV(
input					CLOCK_50,CLOCK2_50,CLOCK3_50,ENETCLK_25,
output	[8:0] 	LEDG,
output 	[17:0] 	LEDR,
input 	[3:0] 	KEY,
input 	[17:0] 	SW,
output 	[6:0] 	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
//LCD
inout 	[7:0] 	LCD_DATA,
output 				LCD_BLON, LCD_EN, LCD_ON, LCD_RS, LCD_RW,
//VGA
output 	[7:0] 	VGA_B, VGA_G, VGA_R,
output 				VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS,
//I2C for Audio and Tv-Decode
output 				I2C_SCLK,
inout 				I2C_SDAT,
//TV Decoder 1
input					TD_CLK27,
input		[7:0]		TD_DATA,
input		       	TD_HS,
output		     	TD_RESET_N,
input		       	TD_VS,
//SDRAM
output	[12:0]	DRAM_ADDR,
output	[1:0]		DRAM_BA,
output		     	DRAM_CAS_N,
output		    	DRAM_CKE,
output		     	DRAM_CLK,
output		    	DRAM_CS_N,
inout		[31:0]	DRAM_DQ,
output	[3:0]		DRAM_DQM,
output		    	DRAM_RAS_N,
output		   	DRAM_WE_N);


// REG/WIRE declarations
//	For ITU-R 656 Decoder
wire	[15:0]	YCbCr;
wire	[9:0]		TV_X;
wire				TV_DVAL;
//	For YUV 4:2:2 to YUV 4:4:4
wire	[7:0]		mY;
wire	[7:0]		mCb;
wire	[7:0]		mCr;
//	For field select
wire	[15:0]	mYCbCr;
wire	[15:0]	mYCbCr_d;
wire	[15:0]	m1YCbCr;
wire	[15:0]	m2YCbCr;
wire	[15:0]	m3YCbCr;
//	For Delay Timer
wire				TD_Stable;
wire				DLY0;
wire				DLY1;
wire				DLY2;
//	For Down Sample
wire	[3:0]		Remain;
wire	[9:0]		Quotient;
wire	[15:0]	m4YCbCr;
wire	[15:0]	m5YCbCr;
wire	[8:0]		Tmp1,Tmp2;
wire	[7:0]		Tmp3,Tmp4;
wire           NTSC;
wire           PAL;
//VGA Controller
wire	[10:0]	VGA_X; //VGA port
wire	[10:0]	VGA_Y; //VGA port
wire				VGA_Read;	//	VGA data request
wire				m1VGA_Read;	//	Read odd field
wire				m2VGA_Read;	//	Read even field
wire 	[19:0] 	VGA_Addr;
//YCbCr2Grey
wire 	[7:0]		mGrey;
wire				mDVAL;
wire	[7:0]		mRed;
wire	[7:0]		mGreen;
wire	[7:0]		mBlue;
//function_select
wire [7:0] grey_out;

//Structural coding
//	Turn On TV Decoder
assign	TD_RESET_N	=	1'b1;

//assign	AUD_XCK	=	AUD_CTRL_CLK;

assign	LEDG	=	VGA_Y;
assign	LEDR	=	VGA_X;

assign	m1VGA_Read	=	VGA_Y[0]		?	1'b0		:	VGA_Read	;
assign	m2VGA_Read	=	VGA_Y[0]		?	VGA_Read	:	1'b0		;
assign	mYCbCr_d	=	!VGA_Y[0]		?	m1YCbCr		:
											      m2YCbCr		;
assign	mYCbCr		=	m5YCbCr;

assign	Tmp1	=	m4YCbCr[7:0]+mYCbCr_d[7:0];
assign	Tmp2	=	m4YCbCr[15:8]+mYCbCr_d[15:8];
assign	Tmp3	=	Tmp1[8:2]+m3YCbCr[7:1];
assign	Tmp4	=	Tmp2[8:2]+m3YCbCr[15:9];
assign	m5YCbCr	=	{Tmp4,Tmp3};

//	TV Decoder Stable Check

//	Audio CODEC and video decoder setting
I2C_AV_Config 	u1	(	//	Host Side
									.iCLK(CLOCK_50),
									.iRST_N(KEY[0]),
									//	I2C Side
									.I2C_SCLK(I2C_SCLK),
									.I2C_SDAT(I2C_SDAT)	);	

									
TD_Detect			u2	(		.oTD_Stable(TD_Stable),
									.oNTSC(NTSC),
									.oPAL(PAL),
									.iTD_VS(TD_VS),
									.iTD_HS(TD_HS),
									.iRST_N(KEY[0])	);

//	Reset Delay Timer
Reset_Delay			u3	(		.iCLK(CLOCK_50),
									.iRST(TD_Stable),
									.oRST_0(DLY0),
									.oRST_1(DLY1),
									.oRST_2(DLY2));

//	ITU-R 656 to YUV 4:2:2
ITU_656_Decoder		u4	(	//	TV Decoder Input
									.iTD_DATA(TD_DATA),
									//	Position Output
									.oTV_X(TV_X),
									//	YUV 4:2:2 Output
									.oYCbCr(YCbCr),
									.oDVAL(TV_DVAL),
									//	Control Signals
									.iSwap_CbCr(Quotient[0]),
									.iSkip(Remain==4'h0),
									.iRST_N(DLY1),
									.iCLK_27(TD_CLK27)	);

//	For Down Sample 720 to 640
DIV 				u5	(			.aclr(!DLY0),	
									.clock(TD_CLK27),
									.denom(4'h9),
									.numer(TV_X),
									.quotient(Quotient),
									.remain(Remain));

//	SDRAM frame buffer
Sdram_Control_4Port	u6	(	//	HOST Side
									.REF_CLK(TD_CLK27),
									.CLK_18(AUD_CTRL_CLK),
									.RESET_N(DLY0),
									//	FIFO Write Side 1
									.WR1_DATA(YCbCr),
									.WR1(TV_DVAL),
									.WR1_FULL(WR1_FULL),
									.WR1_ADDR(0),
									.WR1_MAX_ADDR(NTSC ? 640*507 : 640*576),		//	525-18
									.WR1_LENGTH(9'h80),
									.WR1_LOAD(!DLY0),
									.WR1_CLK(TD_CLK27),
									//	FIFO Read Side 1
									.RD1_DATA(m1YCbCr),
									.RD1(m1VGA_Read),
									.RD1_ADDR(NTSC ? 640*13 : 640*42),			//	Read odd field and bypess blanking
									.RD1_MAX_ADDR(NTSC ? 640*253 : 640*282),
									.RD1_LENGTH(9'h80),
									.RD1_LOAD(!DLY0),
									.RD1_CLK(TD_CLK27),
									//	FIFO Read Side 2
									.RD2_DATA(m2YCbCr),
									.RD2(m2VGA_Read),
									.RD2_ADDR(NTSC ? 640*267 : 640*330),			//	Read even field and bypess blanking
									.RD2_MAX_ADDR(NTSC ? 640*507 : 640*570),
									.RD2_LENGTH(9'h80),
									.RD2_LOAD(!DLY0),
									.RD2_CLK(TD_CLK27),
									//	SDRAM Side
									.SA(DRAM_ADDR),
									.BA(DRAM_BA),
									.CS_N(DRAM_CS_N),
									.CKE(DRAM_CKE),
									.RAS_N(DRAM_RAS_N),
									.CAS_N(DRAM_CAS_N),
									.WE_N(DRAM_WE_N),
									.DQ(DRAM_DQ),
									.DQM({DRAM_DQM[1],DRAM_DQM[0]}),
									.SDR_CLK(DRAM_CLK)	);

//	YUV 4:2:2 to YUV 4:4:4
YUV422_to_444		u7	(		//	YUV 4:2:2 Input
									.iYCbCr(mYCbCr),
									//	YUV	4:4:4 Output
									.oY(mY),
									.oCb(mCb),
									.oCr(mCr),
									//	Control Signals
									.iX(VGA_X-160),
									.iCLK(TD_CLK27),
									.iRST_N(DLY0));
									
//Author: Ruoxiang Wen student ID u5752771 ANU
//	YCbCr 8-bit to RGB-10 bit, optional frame overwrite with pre-programmed chessboard for debugging
//**Modified module
//Control Module 1: display control
//User Instruction: if sw[17] on, camera display; if sw[17] off, chessboard display 

YCbCr2Grey 			u8	(	//	Output Side
									.Grey(mGrey),
									.Red(mRed),
									.Green(mGreen),
									.Blue(mBlue),
									.oDVAL(mDVAL),//if proceeed, set to 1
									//	Input Side
									.vga_x(VGA_X),.vga_y(VGA_Y),//from vga, for frame overwrite
									.frame_select(SW[17]),
									//.rgb_select(SW[16]),
									.iY(mY),
									.iCb(mCb),
									.iCr(mCr),
									.iDVAL(VGA_Read),//when vga read request, set iDVAL to 1
									//	Control Signal
									.iRESET(!DLY2),
									.iCLK(TD_CLK27));
									
//Author: Ruoxiang Wen student ID u5752771 ANU
//function select
//Control Module 2: function control
//User instruction: activate either one of the switch from sw[9] to sw[0]				
//Note: this module is my individual work

Function_Select FS_0 (
									.function_select(SW[9:0]),
									.en(mDVAL),
									.clk(TD_CLK27),
									.CLOCK_50(CLOCK_50),
									.rst_n(DLY2),
									.grey_in(mGrey),//input
									.vga_x(VGA_X),
									.vga_y(VGA_Y),
									.r_in(mRed),
									.g_in(mGreen),
									.b_in(mBlue),
									.vga_addr(VGA_Addr),
									.train_en(SW[16]),
									.grey_out(grey_out));//output

//VGA driver unit									
VGA_Ctrl			u9	(	//	Host Side
									.iRed(grey_out),
									.iGreen(grey_out),
									.iBlue(grey_out),
									.oCurrent_X(VGA_X),
									.oCurrent_Y(VGA_Y),
									.oRequest(VGA_Read),
									.oAddress(VGA_Addr),
									//	VGA Side
									.oVGA_R(VGA_R),
									.oVGA_G(VGA_G),
									.oVGA_B(VGA_B),
									.oVGA_HS(VGA_HS),
									.oVGA_VS(VGA_VS),
									.oVGA_SYNC(VGA_SYNC_N),
									.oVGA_BLANK(VGA_BLANK_N),
									.oVGA_CLOCK(VGA_CLK),
									//	Control Signal
									.iCLK(TD_CLK27),
									.iRST_N(DLY2)	);

//	Line buffer, delay one line
Line_Buffer u10	(			.aclr(!DLY0),
									.clken(VGA_Read),
									.clock(TD_CLK27),
									.shiftin(mYCbCr_d),
									.shiftout(m3YCbCr));

Line_Buffer u11	(			.aclr(!DLY0),
									.clken(VGA_Read),
									.clock(TD_CLK27),
									.shiftin(m3YCbCr),
									.shiftout(m4YCbCr));


								
//	16*2 LCD Module
LCD LCD_0(
								.clk(CLOCK_50),
								.rst_n(KEY[0]),
								.function_select(SW[9:0]),
								.LCD_DATA(LCD_DATA),
								.LCD_RW(LCD_RW),
								.LCD_EN(LCD_EN),
								.LCD_RS(LCD_RS),
								.LCD_BLON(LCD_BLON),
								.LCD_ON(LCD_ON));
								
								//seven segment led
DigiRotate8 Digi_0(
								.reset(0),
								.clk(CLOCK_50),//input
								.HEX0(HEX0),
								.HEX1(HEX1),
								.HEX2(HEX2),
								.HEX3(HEX3),
								.HEX4(HEX4),
								.HEX5(HEX5),
								.HEX6(HEX6),
								.HEX7(HEX7));//output
endmodule

