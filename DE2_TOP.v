// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2 TOP LEVEL
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 05/08/19  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 05/11/16  :|      Added FLASH Address FL_ADDR[21:20]
//   V1.2 :| Johnny Chen       :| 05/11/16  :|		Fixed ISP1362 INT/DREQ Pin Direction.   
//   V1.3 :| Johnny Chen       :| 06/11/16  :|		Added the Dedicated TV Decoder Line-Locked-Clock Input
//													            for DE2 v2.X PCB.
//   V1.5 :| Eko    Yan        :| 12/01/30  :|      Update to version 11.1 sp1.
// ============================================================================

module DE2_TOP
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		UART_TXD,						//	UART Transmitter
		UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		IRDA_TXD,						//	IRDA Transmitter
		IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		SD_DAT,							//	SD Card Data
		SD_WP_N,						   //	SD Write protect 
		SD_CMD,							//	SD Card Command Signal
		SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	   TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK27,                  //	TV Decoder 27MHz CLK
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input		   	CLOCK_27;				//	27 MHz
input		   	CLOCK_50;				//	50 MHz
input			   EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	   [3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	  [17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output  [17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			UART_TXD;				//	UART Transmitter
input			   UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
output			IRDA_TXD;				//	IRDA Transmitter
input			   IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	  [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output  [11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	  [7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	 [15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output [17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	 [15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output  [1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			   OTG_INT0;				//	ISP1362 Interrupt 0
input			   OTG_INT1;				//	ISP1362 Interrupt 1
input			   OTG_DREQ0;				//	ISP1362 DMA Request 0
input			   OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	  [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
inout	 [3:0]	SD_DAT;					//	SD Card Data
input			   SD_WP_N;				   //	SD write protect
inout			   SD_CMD;					//	SD Card Command Signal
output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			   I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	   PS2_DAT;				//	PS2 Data
input			   PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			   ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			   AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			   AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			   AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			   AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	 [7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			   TD_HS;					//	TV Decoder H_SYNC
input			   TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
input          TD_CLK27;            //	TV Decoder 27MHz CLK
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire CLOCK_20;

pll_clock (
		CLOCK_50,       //      clk.clk
		1'b1, //    reset.reset_n
		CLOCK_20   // clock_20.clk
	);

parameter depth=17;

parameter x_width=9;
parameter y_width=x_width;

//=======================================================
//  Structural coding
//=======================================================

//reg [1:0] state;


wire reset;
assign reset = SW[17];
assign LEDG[8] = isWhite;


//=======================================================
//  Serial Reciver And Transmitter
//=======================================================
//	interface
wire reciveOrderEnd;
wire [5:0] count;
//wire sendStart;
wire isWhite;

//inside
wire txdBusy;
wire serialArrayBusy;
wire txdWrite;
wire [7:0] txdData;
wire [8*10 - 1:0] data;
wire rxdReady;
wire [7:0] rxdData;
wire [x_width:0] rel_x_recive, rel_y_recive;
wire [7:0] rel_type_recive;
async_receiver RX(.clk(CLOCK_20), .RxD(UART_RXD), .RxD_data_ready(rxdReady), .RxD_data(rxdData));
async_transmitter TX(.clk(CLOCK_20), .TxD(UART_TXD), .TxD_start(txdWrite), .TxD_busy(txdBusy), .TxD_data(txdData));
serialArraySend(CLOCK_20, reset, data, count, tile_select_ready, txdBusy, txdWrite, txdData, serialArrayBusy);
recieveOrder(rxdData, rxdReady, isWhite, CLOCK_20, reset, rel_x_recive, rel_y_recive, rel_type_recive, reciveOrderEnd);
//*******************************************************************************************


//=======================================================
//  Placer
//=======================================================
wire [x_width:0] last_x, last_y;
wire [x_width:0] offset_y, offset_x;
wire [x_width:0] max_offset_y, max_offset_x;
wire [3:0] last_type;
wire placer_end;
wire [depth+2:0] addr_placer;
wire [3:0] data_in_placer;
wire write_en_placer;
wire placer_error;
wire [x_width:0] rel_x, rel_y;
wire [1:0] rel_type;

defparam pl.depth=depth;
defparam pl.x_width = x_width;
defparam pl.y_width = y_width;
placer pl(CLOCK_20, reset, rel_x, rel_y, rel_type, placer_start, data_out, addr_placer,
					write_en_placer, data_in_placer, ram_ready, placer_error, placer_end, last_x,
					last_y, last_type, offset_x, offset_y, max_offset_x, max_offset_y);
				
assign rel_x = (placer_sel==1) ? rel_x_select_tile :rel_x_recive;
assign rel_y = (placer_sel==1) ? rel_y_select_tile :rel_y_recive;
assign rel_type = (placer_sel==1)? rel_type_select_tile : rel_type_recive;
//*******************************************************************************************
	
//=======================================================
//  Tile Read/Write
//=======================================================	
	wire [3:0] data_out;
	wire [depth+2:0] sram_main_addr;
	wire sram_w_en;
	wire [3:0] sram_data_in;
	wire ram_ready;
	wire clean_mark;
	
	defparam rwt.depth=depth;
	
	read_write_tile rwt(
		CLOCK_20,
		reset,
		clean_mark,
		sram_w_en,
		sram_main_addr,
		sram_data_in,
		data_out,
		ram_ready,
		SRAM_ADDR,
		SRAM_WE_N,
		SRAM_CE_N,
		SRAM_OE_N,
		SRAM_UB_N,
		SRAM_LB_N,
		SRAM_DQ
	);
	assign sram_main_addr = (sram_sel==1)?addr_force_move:(sram_sel==2)?ram_addr_select_tile:addr_placer;
	assign sram_data_in	= (sram_sel==1)?data_out_force_move:(sram_sel==2)?data_out_select_tile:data_in_placer;
	assign sram_w_en = (sram_sel==1)?write_en_force_move:(sram_sel==2)?write_en_select_tile:write_en_placer;
//*******************************************************************************************
	
//=======================================================
//  Force Move
//=======================================================	
	wire write_en_force_move;
	wire [depth+2:0] addr_force_move;
	wire [3:0] data_out_force_move;
	wire force_error;
	
	defparam fm.depth = depth + 2;
	defparam fm.x_width = x_width;
	force_move fm(
		CLOCK_20,
		reset,
		force_start,
		last_x, last_y,
		ram_ready,
		data_out,
		data_out_force_move,
		addr_force_move,
		write_en_force_move,
		force_end,
		force_error
	);
//*******************************************************************************************


//=======================================================
//  Controller
//=======================================================		
	wire placer_start;
	wire force_start;
	wire [1:0] sram_sel;
	wire placer_sel;
	wire tile_select_ready;
	wire tile_select_start;
	controller(
		CLOCK_20,
		reset,
		isWhite, // recive order color 
		reciveOrderEnd, // recive order input
		tile_select_ready, // writer
		placer_end,
		force_end,
		placer_start, 
		tile_select_start,
		force_start,
		sram_sel,
		placer_sel,
		LEDG[3:0]
	);
	
	//assign LEDR = {max_offset_x, max_offset_y};
//*******************************************************************************************

//=======================================================
//  Select Tile
//=======================================================		
wire write_en_select_tile;
wire [3:0] data_out_select_tile;
wire [depth+2:0] ram_addr_select_tile;
wire [x_width:0] select_x, select_y;
wire [3:0] select_t;
wire [x_width:0] offset_x_stable, offset_y_stable;
wire [15:0] ascii_out_x, ascii_out_y;
wire [7:0] ascii_out_type;



defparam ts.depth = depth + 2;
defparam ts.x_width = x_width;

wire [1:0] cont;
assign cont = ~(SW[1:0]);
tile_select ts(serialArrayBusy, cont, isWhite, CLOCK_20, reset, tile_select_start, data_out, ram_ready ,offset_x, offset_y, max_offset_x, max_offset_y,
	last_x, last_y, offset_x_stable, offset_y_stable, write_en_select_tile, data_out_select_tile, ram_addr_select_tile , select_x, select_y, 
	select_t, tile_select_ready, clean_mark, LEDR[17:0], LEDG[7:4]); //fix
	
wire [x_width:0] rel_x_select_tile, rel_y_select_tile;
wire [1:0] rel_type_select_tile;

assign rel_x_select_tile = select_x - offset_x;
assign rel_y_select_tile = select_y - offset_y;
assign rel_type_select_tile = ((select_t == 4'b001) || (select_t == 4'b010)) ? 2'd2 : 
										((select_t == 4'b0011) || (select_t == 4'b0100)) ? 2'd0 : 2'd1; 
	
wire x_num, y_num;
out_adderss(
	select_x,select_y,
	offset_x_stable, offset_y_stable,
	select_t,
	ascii_out_x, ascii_out_y,
	ascii_out_type, x_num, y_num
);
assign data[47:0] = (x_num==0 && y_num==0)?{16'b0,8'd10,ascii_out_type[7:0], ascii_out_y[7:0] ,ascii_out_x[7:0]}:
							(x_num==1 && y_num==0)?{8'b0,8'd10,ascii_out_type[7:0], ascii_out_y[7:0] ,ascii_out_x[7:0],ascii_out_x[15:8]}:
							(x_num==0 && y_num==1)?{8'b0,8'd10,ascii_out_type[7:0], ascii_out_y[7:0] , ascii_out_y[15:8] ,ascii_out_x[7:0]}:
							{8'd10,ascii_out_type[7:0], ascii_out_y[7:0] , ascii_out_y[15:8] ,ascii_out_x[7:0],ascii_out_x[15:8]};
assign count=4+x_num+y_num;
//*******************************************************************************************


/*
//	Turn on all display
assign	HEX0		=	7'h00;
assign	HEX1		=	7'h00;
assign	HEX2		=	7'h00;
assign	HEX3		=	7'h00;
assign	HEX4		=	7'h00;
assign	HEX5		=	7'h00;
assign	HEX6		=	7'h00;
assign	HEX7		=	7'h00;
assign	LEDG		=	9'h1FF;
assign	LEDR		=	18'h3FFFF;
assign	LCD_ON		=	1'b1;
assign	LCD_BLON	=	1'b1;

//	All inout port turn to tri-state
assign	DRAM_DQ		=	16'hzzzz;
assign	FL_DQ		=	8'hzz;
assign	SRAM_DQ		=	16'hzzzz;
assign	OTG_DATA	=	16'hzzzz;
assign	LCD_DATA	=	8'hzz;
assign	SD_DAT		=	4'bzzzz;
assign	I2C_SDAT	=	1'bz;
assign	ENET_DATA	=	16'hzzzz;
assign	AUD_ADCLRCK	=	1'bz;
assign	AUD_DACLRCK	=	1'bz;
assign	AUD_BCLK	=	1'bz;
assign	GPIO_0		=	36'hzzzzzzzzz;
assign	GPIO_1		=	36'hzzzzzzzzz;
*/
endmodule
