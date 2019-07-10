////RS232
//output UART_CTS, UART_TXD,
//input	UART_RTS, UART_RXD,
//input	SMA_CLKIN,
//output SMA_CLKOUT,
//PS2
//inout	PS2_CLK, PS2_DAT, PS2_CLK2, PS2_DAT2,
//SDCARD
//output SD_CLK,
//inout	SD_CMD,
//inout	[3:0] SD_DAT,
//input	SD_WP_N,
//Audio
//input	AUD_ADCDAT,
//inout	AUD_ADCLRCK, AUD_BCLK, AUD_DACLRCK,
//output AUD_DACDAT, AUD_XCK,
//I2C for EEPROM
//output EEP_I2C_SCLK,
//inout	EEP_I2C_SDAT,
////Ethernet 0
//output		          		ENET0_GTX_CLK,
//input		          		ENET0_INT_N,
//output		          		ENET0_MDC,
//inout		          		ENET0_MDIO,
//output		          		ENET0_RST_N,
//input		          		ENET0_RX_CLK,
//input		          		ENET0_RX_COL,
//input		          		ENET0_RX_CRS,
//input		     [3:0]		ENET0_RX_DATA,
//input		          		ENET0_RX_DV,
//input		          		ENET0_RX_ER,
//input		          		ENET0_TX_CLK,
//output		     [3:0]		ENET0_TX_DATA,
//output		          		ENET0_TX_EN,
//output		          		ENET0_TX_ER,
//input		          		ENET0_LINK100,
//////////// Ethernet 1 //////////
//output		          		ENET1_GTX_CLK,
//input		          		ENET1_INT_N,
//output		          		ENET1_MDC,
//inout		          		ENET1_MDIO,
//output		          		ENET1_RST_N,
//input		          		ENET1_RX_CLK,
//input		          		ENET1_RX_COL,
//input		          		ENET1_RX_CRS,
//input		     [3:0]		ENET1_RX_DATA,
//input		          		ENET1_RX_DV,
//input		          		ENET1_RX_ER,
//input		          		ENET1_TX_CLK,
//output		     [3:0]		ENET1_TX_DATA,
//output		          		ENET1_TX_EN,
//output		          		ENET1_TX_ER,
//input		          		ENET1_LINK100,
////////////// USB OTG controller //////////
//inout            [15:0]     OTG_DATA,
//output           [1:0]      OTG_ADDR,
//output                      OTG_CS_N,
//output                      OTG_WR_N,
//output                      OTG_RD_N,
//input            [1:0]      OTG_INT,
//output                      OTG_RST_N,
//input            [1:0]      OTG_DREQ,
//output           [1:0]      OTG_DACK_N,
//inout                       OTG_FSPEED,
//inout                       OTG_LSPEED,
//
////////////// IR Receiver //////////
//input		          		IRDA_RXD,
//////////// SRAM //////////
//output		    [19:0]		SRAM_ADDR,
//output		          		SRAM_CE_N,
//inout		    [15:0]		SRAM_DQ,
//output		          		SRAM_LB_N,
//output		          		SRAM_OE_N,
//output		          		SRAM_UB_N,
//output		          		SRAM_WE_N,
//////////// Flash //////////
//output		    [22:0]		FL_ADDR,
//output		          		FL_CE_N,
//inout		     [7:0]		FL_DQ,
//output		          		FL_OE_N,
//output		          		FL_RST_N,
//input		          		FL_RY,
//output		          		FL_WE_N,
//output		          		FL_WP_N,

////////////// GPIO //////////
//inout		    [35:0]		GPIO,
//
////////// EXTEND IO //////////
//inout		    [6:0]		EX_IO



//wire	CPU_CLK;
//wire	CPU_RESET;
//wire	CLK_18_4;
//wire	CLK_25;
//	For Audio CODEC
//wire		AUD_CTRL_CLK;	//	For Audio Controller
//=============================================================================
// Structural coding
//=============================================================================
//	Flash
//assign	FL_RST_N	=	1'b1;
//	All inout port turn to tri-state 
//assign	SD_DAT		=	4'b1zzz;  //Set SD Card to SD Mode
//assign	AUD_ADCLRCK	=	AUD_DACLRCK;
//assign	GPIO	=	36'hzzzzzzzzz;
//assign	HSMC_D   	=	4'hz;
//assign	EX_IO   	=	7'bzzzzzzz;

//	Disable USB speed select
//assign	OTG_FSPEED	=	1'bz;
//assign	OTG_LSPEED	=	1'bz;

//
//AUDIO_DAC 	u12	(	//	Audio Side
//								.oAUD_BCK(AUD_BCLK),
//								.oAUD_DATA(AUD_DACDAT),
//								.oAUD_LRCK(AUD_DACLRCK),
//								//	Control Signals
//								.iSrc_Select(2'b01),
//								.iCLK_18_4(AUD_CTRL_CLK),
//								.iRST_N(DLY1)	);



//
//			addr_a 	<= (x_en && y_en) 							? (addr_a + 1 ) 		: addr_a;
//			wren_a 	<= (x_en && y_en);
//			addr_l 	<= (x_en && y_en) 							? (addr_l + 1 ) 		: addr_l;
//			sum_row 	<= (x_en && y_en) 							? (data_in + sum_row) 	: sum_row;
//			sum 		<=  (x_en && y_en && (addr_a<160))		? sum_row				: sum_row;// ram_vec[addr_l] +
//			ram_vec[addr_l] <= (x_en && y_en) 					? sum 					: ram_vec[addr_l];
//			//*****integral image calculation according to the address and write enable generated above*****//
//			//if reach end of row, set sum of row to 0, address for line RAM to 0
//			//if reach end of colum, set also sum, sum of row, and line RAM address to 0;
//			sum_row 	<= (row_start || col_end)	? 0 : sum_row;
//			addr_l 	<= (row_start)					? 0 : addr_l;
//			sum 		<= (col_end)					? 0 : sum;