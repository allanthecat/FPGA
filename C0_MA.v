// megafunction wizard: %ALTMULT_ADD%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTMULT_ADD 

// ============================================================
// File Name: C0_MA.v
// Megafunction Name(s):
// 			ALTMULT_ADD
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 11.0 Build 157 04/27/2011 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2011 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module C0_MA (
	clock0,
	dataa_0,
	datab_0,
	datab_1,
	datab_2,
	result);

	input	  clock0;
	input	[7:0]  dataa_0;
	input	[7:0]  datab_0;
	input	[7:0]  datab_1;
	input	[7:0]  datab_2;
	output	[17:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clock0;
	tri0	[7:0]  dataa_0;
	tri0	[7:0]  datab_0;
	tri0	[7:0]  datab_1;
	tri0	[7:0]  datab_2;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [17:0] sub_wire0;
	wire [7:0] sub_wire3 = 8'h0;
	wire [7:0] sub_wire7 = datab_2[7:0];
	wire [7:0] sub_wire6 = datab_1[7:0];
	wire [17:0] result = sub_wire0[17:0];
	wire [7:0] sub_wire1 = dataa_0[7:0];
	wire [23:0] sub_wire2 = {sub_wire3, sub_wire3, sub_wire1};
	wire [7:0] sub_wire4 = datab_0[7:0];
	wire [23:0] sub_wire5 = {sub_wire7, sub_wire6, sub_wire4};

	altmult_add	ALTMULT_ADD_component (
				.clock0 (clock0),
				.dataa (sub_wire2),
				.datab (sub_wire5),
				.result (sub_wire0),
				.accum_sload (1'b0),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.aclr2 (1'b0),
				.aclr3 (1'b0),
				.addnsub1 (1'b1),
				.addnsub1_round (1'b0),
				.addnsub3 (1'b1),
				.addnsub3_round (1'b0),
				.chainin (1'b0),
				.chainout_round (1'b0),
				.chainout_sat_overflow (),
				.chainout_saturate (1'b0),
				.clock1 (1'b1),
				.clock2 (1'b1),
				.clock3 (1'b1),
				.coefsel0 ({3{1'b0}}),
				.coefsel1 ({3{1'b0}}),
				.coefsel2 ({3{1'b0}}),
				.coefsel3 ({3{1'b0}}),
				.datac ({22{1'b0}}),
				.ena0 (1'b1),
				.ena1 (1'b1),
				.ena2 (1'b1),
				.ena3 (1'b1),
				.mult01_round (1'b0),
				.mult01_saturation (1'b0),
				.mult0_is_saturated (),
				.mult1_is_saturated (),
				.mult23_round (1'b0),
				.mult23_saturation (1'b0),
				.mult2_is_saturated (),
				.mult3_is_saturated (),
				.output_round (1'b0),
				.output_saturate (1'b0),
				.overflow (),
				.rotate (1'b0),
				.scanina ({8{1'b0}}),
				.scaninb ({8{1'b0}}),
				.scanouta (),
				.scanoutb (),
				.shift_right (1'b0),
				.signa (1'b0),
				.signb (1'b0),
				.sourcea ({3{1'b0}}),
				.sourceb ({3{1'b0}}),
				.zero_chainout (1'b0),
				.zero_loopback (1'b0));
	defparam
		ALTMULT_ADD_component.addnsub_multiplier_aclr1 = "UNUSED",
		ALTMULT_ADD_component.addnsub_multiplier_pipeline_aclr1 = "UNUSED",
		ALTMULT_ADD_component.addnsub_multiplier_pipeline_register1 = "CLOCK0",
		ALTMULT_ADD_component.addnsub_multiplier_register1 = "CLOCK0",
		ALTMULT_ADD_component.dedicated_multiplier_circuitry = "AUTO",
		ALTMULT_ADD_component.input_aclr_a0 = "UNUSED",
		ALTMULT_ADD_component.input_aclr_a1 = "UNUSED",
		ALTMULT_ADD_component.input_aclr_a2 = "UNUSED",
		ALTMULT_ADD_component.input_aclr_b0 = "UNUSED",
		ALTMULT_ADD_component.input_aclr_b1 = "UNUSED",
		ALTMULT_ADD_component.input_aclr_b2 = "UNUSED",
		ALTMULT_ADD_component.input_register_a0 = "CLOCK0",
		ALTMULT_ADD_component.input_register_a1 = "CLOCK0",
		ALTMULT_ADD_component.input_register_a2 = "CLOCK0",
		ALTMULT_ADD_component.input_register_b0 = "CLOCK0",
		ALTMULT_ADD_component.input_register_b1 = "CLOCK0",
		ALTMULT_ADD_component.input_register_b2 = "CLOCK0",
		ALTMULT_ADD_component.input_source_a0 = "DATAA",
		ALTMULT_ADD_component.input_source_a1 = "SCANA",
		ALTMULT_ADD_component.input_source_a2 = "SCANA",
		ALTMULT_ADD_component.input_source_b0 = "DATAB",
		ALTMULT_ADD_component.input_source_b1 = "DATAB",
		ALTMULT_ADD_component.input_source_b2 = "DATAB",
		ALTMULT_ADD_component.intended_device_family = "Cyclone IV E",
		ALTMULT_ADD_component.lpm_type = "altmult_add",
		ALTMULT_ADD_component.multiplier1_direction = "ADD",
		ALTMULT_ADD_component.multiplier_aclr0 = "UNUSED",
		ALTMULT_ADD_component.multiplier_aclr1 = "UNUSED",
		ALTMULT_ADD_component.multiplier_aclr2 = "UNUSED",
		ALTMULT_ADD_component.multiplier_register0 = "CLOCK0",
		ALTMULT_ADD_component.multiplier_register1 = "CLOCK0",
		ALTMULT_ADD_component.multiplier_register2 = "CLOCK0",
		ALTMULT_ADD_component.number_of_multipliers = 3,
		ALTMULT_ADD_component.output_aclr = "UNUSED",
		ALTMULT_ADD_component.output_register = "CLOCK0",
		ALTMULT_ADD_component.port_addnsub1 = "PORT_UNUSED",
		ALTMULT_ADD_component.port_signa = "PORT_UNUSED",
		ALTMULT_ADD_component.port_signb = "PORT_UNUSED",
		ALTMULT_ADD_component.representation_a = "UNSIGNED",
		ALTMULT_ADD_component.representation_b = "SIGNED",
		ALTMULT_ADD_component.signed_aclr_a = "UNUSED",
		ALTMULT_ADD_component.signed_aclr_b = "UNUSED",
		ALTMULT_ADD_component.signed_pipeline_aclr_a = "UNUSED",
		ALTMULT_ADD_component.signed_pipeline_aclr_b = "UNUSED",
		ALTMULT_ADD_component.signed_pipeline_register_a = "CLOCK0",
		ALTMULT_ADD_component.signed_pipeline_register_b = "CLOCK0",
		ALTMULT_ADD_component.signed_register_a = "CLOCK0",
		ALTMULT_ADD_component.signed_register_b = "CLOCK0",
		ALTMULT_ADD_component.width_a = 8,
		ALTMULT_ADD_component.width_b = 8,
		ALTMULT_ADD_component.width_result = 18;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ADDNSUB1_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: ADDNSUB1_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: ADDNSUB1_PIPE_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: ADDNSUB1_PIPE_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: ADDNSUB1_PIPE_REG STRING "1"
// Retrieval info: PRIVATE: ADDNSUB1_REG STRING "1"
// Retrieval info: PRIVATE: ADDNSUB3_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: ADDNSUB3_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: ADDNSUB3_PIPE_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: ADDNSUB3_PIPE_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: ADDNSUB3_PIPE_REG STRING "1"
// Retrieval info: PRIVATE: ADDNSUB3_REG STRING "1"
// Retrieval info: PRIVATE: ADD_ENABLE NUMERIC "0"
// Retrieval info: PRIVATE: ALL_REG_ACLR NUMERIC "0"
// Retrieval info: PRIVATE: A_ACLR_SRC_MULT0 NUMERIC "3"
// Retrieval info: PRIVATE: A_CLK_SRC_MULT0 NUMERIC "0"
// Retrieval info: PRIVATE: B_ACLR_SRC_MULT0 NUMERIC "3"
// Retrieval info: PRIVATE: B_CLK_SRC_MULT0 NUMERIC "0"
// Retrieval info: PRIVATE: HAS_MAC STRING "0"
// Retrieval info: PRIVATE: HAS_SAT_ROUND STRING "0"
// Retrieval info: PRIVATE: IMPL_STYLE_DEDICATED NUMERIC "0"
// Retrieval info: PRIVATE: IMPL_STYLE_DEFAULT NUMERIC "1"
// Retrieval info: PRIVATE: IMPL_STYLE_LCELL NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: PRIVATE: MULT_REGA0 NUMERIC "1"
// Retrieval info: PRIVATE: MULT_REGB0 NUMERIC "1"
// Retrieval info: PRIVATE: MULT_REGOUT0 NUMERIC "1"
// Retrieval info: PRIVATE: NUM_MULT STRING "3"
// Retrieval info: PRIVATE: OP1 STRING "Add"
// Retrieval info: PRIVATE: OP3 STRING "Add"
// Retrieval info: PRIVATE: OUTPUT_EXTRA_LAT NUMERIC "0"
// Retrieval info: PRIVATE: OUTPUT_REG_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: OUTPUT_REG_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: Q_ACLR_SRC_MULT0 NUMERIC "3"
// Retrieval info: PRIVATE: Q_CLK_SRC_MULT0 NUMERIC "0"
// Retrieval info: PRIVATE: REG_OUT NUMERIC "1"
// Retrieval info: PRIVATE: RNFORMAT STRING "18"
// Retrieval info: PRIVATE: RQFORMAT STRING "Q1.15"
// Retrieval info: PRIVATE: RTS_WIDTH STRING "18"
// Retrieval info: PRIVATE: SAME_CONFIG NUMERIC "1"
// Retrieval info: PRIVATE: SAME_CONTROL_SRC_A0 NUMERIC "1"
// Retrieval info: PRIVATE: SAME_CONTROL_SRC_B0 NUMERIC "1"
// Retrieval info: PRIVATE: SCANOUTA NUMERIC "0"
// Retrieval info: PRIVATE: SCANOUTB NUMERIC "0"
// Retrieval info: PRIVATE: SHIFTOUTA_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SHIFTOUTA_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SHIFTOUTA_REG STRING "0"
// Retrieval info: PRIVATE: SIGNA STRING "UNSIGNED"
// Retrieval info: PRIVATE: SIGNA_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SIGNA_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SIGNA_PIPE_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SIGNA_PIPE_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SIGNA_PIPE_REG STRING "1"
// Retrieval info: PRIVATE: SIGNA_REG STRING "1"
// Retrieval info: PRIVATE: SIGNB STRING "SIGNED"
// Retrieval info: PRIVATE: SIGNB_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SIGNB_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SIGNB_PIPE_ACLR_SRC NUMERIC "3"
// Retrieval info: PRIVATE: SIGNB_PIPE_CLK_SRC NUMERIC "0"
// Retrieval info: PRIVATE: SIGNB_PIPE_REG STRING "1"
// Retrieval info: PRIVATE: SIGNB_REG STRING "1"
// Retrieval info: PRIVATE: SRCA0 STRING "Shiftin input"
// Retrieval info: PRIVATE: SRCB0 STRING "Multiplier input"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: WIDTHA STRING "8"
// Retrieval info: PRIVATE: WIDTHB STRING "8"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: ADDNSUB_MULTIPLIER_ACLR1 STRING "UNUSED"
// Retrieval info: CONSTANT: ADDNSUB_MULTIPLIER_PIPELINE_ACLR1 STRING "UNUSED"
// Retrieval info: CONSTANT: ADDNSUB_MULTIPLIER_PIPELINE_REGISTER1 STRING "CLOCK0"
// Retrieval info: CONSTANT: ADDNSUB_MULTIPLIER_REGISTER1 STRING "CLOCK0"
// Retrieval info: CONSTANT: DEDICATED_MULTIPLIER_CIRCUITRY STRING "AUTO"
// Retrieval info: CONSTANT: INPUT_ACLR_A0 STRING "UNUSED"
// Retrieval info: CONSTANT: INPUT_ACLR_A1 STRING "UNUSED"
// Retrieval info: CONSTANT: INPUT_ACLR_A2 STRING "UNUSED"
// Retrieval info: CONSTANT: INPUT_ACLR_B0 STRING "UNUSED"
// Retrieval info: CONSTANT: INPUT_ACLR_B1 STRING "UNUSED"
// Retrieval info: CONSTANT: INPUT_ACLR_B2 STRING "UNUSED"
// Retrieval info: CONSTANT: INPUT_REGISTER_A0 STRING "CLOCK0"
// Retrieval info: CONSTANT: INPUT_REGISTER_A1 STRING "CLOCK0"
// Retrieval info: CONSTANT: INPUT_REGISTER_A2 STRING "CLOCK0"
// Retrieval info: CONSTANT: INPUT_REGISTER_B0 STRING "CLOCK0"
// Retrieval info: CONSTANT: INPUT_REGISTER_B1 STRING "CLOCK0"
// Retrieval info: CONSTANT: INPUT_REGISTER_B2 STRING "CLOCK0"
// Retrieval info: CONSTANT: INPUT_SOURCE_A0 STRING "DATAA"
// Retrieval info: CONSTANT: INPUT_SOURCE_A1 STRING "SCANA"
// Retrieval info: CONSTANT: INPUT_SOURCE_A2 STRING "SCANA"
// Retrieval info: CONSTANT: INPUT_SOURCE_B0 STRING "DATAB"
// Retrieval info: CONSTANT: INPUT_SOURCE_B1 STRING "DATAB"
// Retrieval info: CONSTANT: INPUT_SOURCE_B2 STRING "DATAB"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altmult_add"
// Retrieval info: CONSTANT: MULTIPLIER1_DIRECTION STRING "ADD"
// Retrieval info: CONSTANT: MULTIPLIER_ACLR0 STRING "UNUSED"
// Retrieval info: CONSTANT: MULTIPLIER_ACLR1 STRING "UNUSED"
// Retrieval info: CONSTANT: MULTIPLIER_ACLR2 STRING "UNUSED"
// Retrieval info: CONSTANT: MULTIPLIER_REGISTER0 STRING "CLOCK0"
// Retrieval info: CONSTANT: MULTIPLIER_REGISTER1 STRING "CLOCK0"
// Retrieval info: CONSTANT: MULTIPLIER_REGISTER2 STRING "CLOCK0"
// Retrieval info: CONSTANT: NUMBER_OF_MULTIPLIERS NUMERIC "3"
// Retrieval info: CONSTANT: OUTPUT_ACLR STRING "UNUSED"
// Retrieval info: CONSTANT: OUTPUT_REGISTER STRING "CLOCK0"
// Retrieval info: CONSTANT: PORT_ADDNSUB1 STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SIGNA STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: PORT_SIGNB STRING "PORT_UNUSED"
// Retrieval info: CONSTANT: REPRESENTATION_A STRING "UNSIGNED"
// Retrieval info: CONSTANT: REPRESENTATION_B STRING "SIGNED"
// Retrieval info: CONSTANT: SIGNED_ACLR_A STRING "UNUSED"
// Retrieval info: CONSTANT: SIGNED_ACLR_B STRING "UNUSED"
// Retrieval info: CONSTANT: SIGNED_PIPELINE_ACLR_A STRING "UNUSED"
// Retrieval info: CONSTANT: SIGNED_PIPELINE_ACLR_B STRING "UNUSED"
// Retrieval info: CONSTANT: SIGNED_PIPELINE_REGISTER_A STRING "CLOCK0"
// Retrieval info: CONSTANT: SIGNED_PIPELINE_REGISTER_B STRING "CLOCK0"
// Retrieval info: CONSTANT: SIGNED_REGISTER_A STRING "CLOCK0"
// Retrieval info: CONSTANT: SIGNED_REGISTER_B STRING "CLOCK0"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_B NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_RESULT NUMERIC "18"
// Retrieval info: USED_PORT: clock0 0 0 0 0 INPUT VCC "clock0"
// Retrieval info: USED_PORT: dataa_0 0 0 8 0 INPUT GND "dataa_0[7..0]"
// Retrieval info: USED_PORT: datab_0 0 0 8 0 INPUT GND "datab_0[7..0]"
// Retrieval info: USED_PORT: datab_1 0 0 8 0 INPUT GND "datab_1[7..0]"
// Retrieval info: USED_PORT: datab_2 0 0 8 0 INPUT GND "datab_2[7..0]"
// Retrieval info: USED_PORT: result 0 0 18 0 OUTPUT GND "result[17..0]"
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock0 0 0 0 0
// Retrieval info: CONNECT: @dataa 0 0 8 16 GND 0 0 8 0
// Retrieval info: CONNECT: @dataa 0 0 8 8 GND 0 0 8 0
// Retrieval info: CONNECT: @dataa 0 0 8 0 dataa_0 0 0 8 0
// Retrieval info: CONNECT: @datab 0 0 8 0 datab_0 0 0 8 0
// Retrieval info: CONNECT: @datab 0 0 8 8 datab_1 0 0 8 0
// Retrieval info: CONNECT: @datab 0 0 8 16 datab_2 0 0 8 0
// Retrieval info: CONNECT: result 0 0 18 0 @result 0 0 18 0
// Retrieval info: GEN_FILE: TYPE_NORMAL C0_MA.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL C0_MA.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL C0_MA.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL C0_MA.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL C0_MA_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL C0_MA_bb.v TRUE
// Retrieval info: LIB_FILE: altera_mf
