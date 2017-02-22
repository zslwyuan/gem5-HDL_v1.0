// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2016.4
// Copyright (C) 1986-2016 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="encrypt1,hls_ip_2016_4,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xqku115-rlf1924-2-i,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=8.430000,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=6,HLS_SYN_DSP=7,HLS_SYN_FF=2846,HLS_SYN_LUT=6182}" *)

module encrypt1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        buff_address0,
        buff_ce0,
        buff_we0,
        buff_d0,
        buff_q0,
        buff_address1,
        buff_ce1,
        buff_we1,
        buff_d1,
        buff_q1,
        m,
        n,
        ap_return
);

parameter    ap_ST_fsm_state1 = 15'b1;
parameter    ap_ST_fsm_state2 = 15'b10;
parameter    ap_ST_fsm_state3 = 15'b100;
parameter    ap_ST_fsm_state4 = 15'b1000;
parameter    ap_ST_fsm_state5 = 15'b10000;
parameter    ap_ST_fsm_state6 = 15'b100000;
parameter    ap_ST_fsm_state7 = 15'b1000000;
parameter    ap_ST_fsm_state8 = 15'b10000000;
parameter    ap_ST_fsm_state9 = 15'b100000000;
parameter    ap_ST_fsm_state10 = 15'b1000000000;
parameter    ap_ST_fsm_state11 = 15'b10000000000;
parameter    ap_ST_fsm_state12 = 15'b100000000000;
parameter    ap_ST_fsm_state13 = 15'b1000000000000;
parameter    ap_ST_fsm_state14 = 15'b10000000000000;
parameter    ap_ST_fsm_state15 = 15'b100000000000000;
parameter    ap_const_lv32_0 = 32'b00000000000000000000000000000000;
parameter    ap_const_lv32_6 = 32'b110;
parameter    ap_const_lv32_8 = 32'b1000;
parameter    ap_const_lv32_1 = 32'b1;
parameter    ap_const_lv32_3 = 32'b11;
parameter    ap_const_lv32_D = 32'b1101;
parameter    ap_const_lv32_5 = 32'b101;
parameter    ap_const_lv32_9 = 32'b1001;
parameter    ap_const_lv5_0 = 5'b00000;
parameter    ap_const_lv32_C = 32'b1100;
parameter    ap_const_lv32_E = 32'b1110;
parameter    ap_const_lv32_2 = 32'b10;
parameter    ap_const_lv32_7 = 32'b111;
parameter    ap_const_lv32_A = 32'b1010;
parameter    ap_const_lv32_4 = 32'b100;
parameter    ap_const_lv32_B = 32'b1011;
parameter    ap_const_lv64_41 = 64'b1000001;
parameter    ap_const_lv64_40 = 64'b1000000;
parameter    ap_const_lv32_1F500 = 32'b11111010100000000;
parameter    ap_const_lv32_2EF00 = 32'b101110111100000000;
parameter    ap_const_lv32_3E900 = 32'b111110100100000000;
parameter    ap_const_lv32_3E8C0 = 32'b111110100011000000;
parameter    ap_const_lv32_1F4C0 = 32'b11111010011000000;
parameter    ap_const_lv32_2EEC0 = 32'b101110111011000000;
parameter    ap_const_lv32_3E880 = 32'b111110100010000000;
parameter    ap_const_lv32_2EE80 = 32'b101110111010000000;
parameter    ap_const_lv32_1F480 = 32'b11111010010000000;
parameter    ap_const_lv5_10 = 5'b10000;
parameter    ap_const_lv5_1 = 5'b1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [6:0] buff_address0;
output   buff_ce0;
output   buff_we0;
output  [31:0] buff_d0;
input  [31:0] buff_q0;
output  [6:0] buff_address1;
output   buff_ce1;
output   buff_we1;
output  [31:0] buff_d1;
input  [31:0] buff_q1;
input  [31:0] m;
input  [31:0] n;
output  [31:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[6:0] buff_address0;
reg buff_ce0;
reg buff_we0;
reg[31:0] buff_d0;
reg[6:0] buff_address1;
reg buff_ce1;
reg buff_we1;
reg[31:0] buff_d1;

(* fsm_encoding = "none" *) reg   [14:0] ap_CS_fsm;
wire   [0:0] ap_CS_fsm_state1;
reg   [8:0] word_address0;
reg    word_ce0;
reg    word_we0;
wire   [31:0] word_q0;
reg   [8:0] word_address1;
reg    word_ce1;
wire   [31:0] word_q1;
reg   [31:0] round;
reg   [31:0] nb;
wire   [3:0] out_enc_statemt_address0;
reg    out_enc_statemt_ce0;
wire   [7:0] out_enc_statemt_q0;
reg   [31:0] reg_236;
wire   [0:0] ap_CS_fsm_state7;
wire   [0:0] tmp_1_fu_264_p2;
wire   [0:0] ap_CS_fsm_state9;
reg   [31:0] type_reg_324;
wire   [0:0] ap_CS_fsm_state2;
wire   [0:0] ap_CS_fsm_state4;
wire    grp_KeySchedule_fu_161_ap_done;
wire   [31:0] i_2_fu_270_p2;
reg   [31:0] i_2_reg_348;
wire   [4:0] i_3_fu_282_p2;
reg   [4:0] i_3_reg_356;
wire   [0:0] ap_CS_fsm_state14;
wire   [0:0] exitcond_fu_276_p2;
wire    grp_KeySchedule_fu_161_ap_start;
wire    grp_KeySchedule_fu_161_ap_idle;
wire    grp_KeySchedule_fu_161_ap_ready;
wire   [6:0] grp_KeySchedule_fu_161_key_address0;
wire    grp_KeySchedule_fu_161_key_ce0;
wire   [8:0] grp_KeySchedule_fu_161_word_address0;
wire    grp_KeySchedule_fu_161_word_ce0;
wire    grp_KeySchedule_fu_161_word_we0;
wire   [31:0] grp_KeySchedule_fu_161_word_d0;
wire   [8:0] grp_KeySchedule_fu_161_word_address1;
wire    grp_KeySchedule_fu_161_word_ce1;
wire    grp_ByteSub_ShiftRow_fu_174_ap_start;
wire    grp_ByteSub_ShiftRow_fu_174_ap_done;
wire    grp_ByteSub_ShiftRow_fu_174_ap_idle;
wire    grp_ByteSub_ShiftRow_fu_174_ap_ready;
wire   [6:0] grp_ByteSub_ShiftRow_fu_174_statemt_address0;
wire    grp_ByteSub_ShiftRow_fu_174_statemt_ce0;
wire    grp_ByteSub_ShiftRow_fu_174_statemt_we0;
wire   [31:0] grp_ByteSub_ShiftRow_fu_174_statemt_d0;
wire   [6:0] grp_ByteSub_ShiftRow_fu_174_statemt_address1;
wire    grp_ByteSub_ShiftRow_fu_174_statemt_ce1;
wire    grp_ByteSub_ShiftRow_fu_174_statemt_we1;
wire   [31:0] grp_ByteSub_ShiftRow_fu_174_statemt_d1;
wire    grp_MixColumn_AddRoundKe_fu_183_ap_start;
wire    grp_MixColumn_AddRoundKe_fu_183_ap_done;
wire    grp_MixColumn_AddRoundKe_fu_183_ap_idle;
wire    grp_MixColumn_AddRoundKe_fu_183_ap_ready;
wire   [6:0] grp_MixColumn_AddRoundKe_fu_183_statemt_address0;
wire    grp_MixColumn_AddRoundKe_fu_183_statemt_ce0;
wire    grp_MixColumn_AddRoundKe_fu_183_statemt_we0;
wire   [31:0] grp_MixColumn_AddRoundKe_fu_183_statemt_d0;
wire   [6:0] grp_MixColumn_AddRoundKe_fu_183_statemt_address1;
wire    grp_MixColumn_AddRoundKe_fu_183_statemt_ce1;
wire    grp_MixColumn_AddRoundKe_fu_183_statemt_we1;
wire   [31:0] grp_MixColumn_AddRoundKe_fu_183_statemt_d1;
wire   [8:0] grp_MixColumn_AddRoundKe_fu_183_word_address0;
wire    grp_MixColumn_AddRoundKe_fu_183_word_ce0;
wire   [8:0] grp_MixColumn_AddRoundKe_fu_183_word_address1;
wire    grp_MixColumn_AddRoundKe_fu_183_word_ce1;
wire    grp_AddRoundKey_fu_194_ap_start;
wire    grp_AddRoundKey_fu_194_ap_done;
wire    grp_AddRoundKey_fu_194_ap_idle;
wire    grp_AddRoundKey_fu_194_ap_ready;
wire   [6:0] grp_AddRoundKey_fu_194_statemt_address0;
wire    grp_AddRoundKey_fu_194_statemt_ce0;
wire    grp_AddRoundKey_fu_194_statemt_we0;
wire   [31:0] grp_AddRoundKey_fu_194_statemt_d0;
wire   [6:0] grp_AddRoundKey_fu_194_statemt_address1;
wire    grp_AddRoundKey_fu_194_statemt_ce1;
wire    grp_AddRoundKey_fu_194_statemt_we1;
wire   [31:0] grp_AddRoundKey_fu_194_statemt_d1;
reg   [31:0] grp_AddRoundKey_fu_194_n;
wire   [8:0] grp_AddRoundKey_fu_194_word_address0;
wire    grp_AddRoundKey_fu_194_word_ce0;
wire   [8:0] grp_AddRoundKey_fu_194_word_address1;
wire    grp_AddRoundKey_fu_194_word_ce1;
reg   [31:0] i_reg_138;
wire   [0:0] ap_CS_fsm_state6;
wire   [0:0] ap_CS_fsm_state10;
reg   [4:0] i_1_reg_150;
wire   [0:0] ap_CS_fsm_state13;
wire   [0:0] ap_CS_fsm_state15;
reg    ap_reg_grp_KeySchedule_fu_161_ap_start;
wire   [0:0] ap_CS_fsm_state3;
reg    ap_reg_grp_ByteSub_ShiftRow_fu_174_ap_start;
wire   [0:0] ap_CS_fsm_state8;
wire   [0:0] ap_CS_fsm_state11;
reg    ap_reg_grp_MixColumn_AddRoundKe_fu_183_ap_start;
reg    ap_reg_grp_AddRoundKey_fu_194_ap_start;
wire   [0:0] ap_CS_fsm_state5;
wire   [0:0] ap_CS_fsm_state12;
wire   [63:0] tmp_4_fu_288_p1;
wire   [31:0] tmp_7_fu_312_p2;
wire   [31:0] tmp_fu_258_p2;
wire   [31:0] out_enc_statemt_load_1_fu_298_p1;
wire   [0:0] tmp_5_fu_302_p2;
wire   [31:0] tmp_6_fu_308_p1;
reg   [14:0] ap_NS_fsm;

// power-on initialization
initial begin
#0 ap_CS_fsm = 15'b1;
#0 round = 32'b00000000000000000000000000000000;
#0 nb = 32'b00000000000000000000000000000000;
#0 ap_reg_grp_KeySchedule_fu_161_ap_start = 1'b0;
#0 ap_reg_grp_ByteSub_ShiftRow_fu_174_ap_start = 1'b0;
#0 ap_reg_grp_MixColumn_AddRoundKe_fu_183_ap_start = 1'b0;
#0 ap_reg_grp_AddRoundKey_fu_194_ap_start = 1'b0;
end

encrypt1_word #(
    .DataWidth( 32 ),
    .AddressRange( 480 ),
    .AddressWidth( 9 ))
word_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(word_address0),
    .ce0(word_ce0),
    .we0(word_we0),
    .d0(grp_KeySchedule_fu_161_word_d0),
    .q0(word_q0),
    .address1(word_address1),
    .ce1(word_ce1),
    .q1(word_q1)
);

encrypt1_out_enc_hbi #(
    .DataWidth( 8 ),
    .AddressRange( 16 ),
    .AddressWidth( 4 ))
out_enc_statemt_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(out_enc_statemt_address0),
    .ce0(out_enc_statemt_ce0),
    .q0(out_enc_statemt_q0)
);

KeySchedule grp_KeySchedule_fu_161(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_KeySchedule_fu_161_ap_start),
    .ap_done(grp_KeySchedule_fu_161_ap_done),
    .ap_idle(grp_KeySchedule_fu_161_ap_idle),
    .ap_ready(grp_KeySchedule_fu_161_ap_ready),
    .type_r(type_reg_324),
    .key_address0(grp_KeySchedule_fu_161_key_address0),
    .key_ce0(grp_KeySchedule_fu_161_key_ce0),
    .key_q0(buff_q0),
    .word_address0(grp_KeySchedule_fu_161_word_address0),
    .word_ce0(grp_KeySchedule_fu_161_word_ce0),
    .word_we0(grp_KeySchedule_fu_161_word_we0),
    .word_d0(grp_KeySchedule_fu_161_word_d0),
    .word_q0(word_q0),
    .word_address1(grp_KeySchedule_fu_161_word_address1),
    .word_ce1(grp_KeySchedule_fu_161_word_ce1),
    .word_q1(word_q1)
);

ByteSub_ShiftRow grp_ByteSub_ShiftRow_fu_174(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_ByteSub_ShiftRow_fu_174_ap_start),
    .ap_done(grp_ByteSub_ShiftRow_fu_174_ap_done),
    .ap_idle(grp_ByteSub_ShiftRow_fu_174_ap_idle),
    .ap_ready(grp_ByteSub_ShiftRow_fu_174_ap_ready),
    .statemt_address0(grp_ByteSub_ShiftRow_fu_174_statemt_address0),
    .statemt_ce0(grp_ByteSub_ShiftRow_fu_174_statemt_ce0),
    .statemt_we0(grp_ByteSub_ShiftRow_fu_174_statemt_we0),
    .statemt_d0(grp_ByteSub_ShiftRow_fu_174_statemt_d0),
    .statemt_q0(buff_q0),
    .statemt_address1(grp_ByteSub_ShiftRow_fu_174_statemt_address1),
    .statemt_ce1(grp_ByteSub_ShiftRow_fu_174_statemt_ce1),
    .statemt_we1(grp_ByteSub_ShiftRow_fu_174_statemt_we1),
    .statemt_d1(grp_ByteSub_ShiftRow_fu_174_statemt_d1),
    .statemt_q1(buff_q1),
    .nb(reg_236)
);

MixColumn_AddRoundKe grp_MixColumn_AddRoundKe_fu_183(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_MixColumn_AddRoundKe_fu_183_ap_start),
    .ap_done(grp_MixColumn_AddRoundKe_fu_183_ap_done),
    .ap_idle(grp_MixColumn_AddRoundKe_fu_183_ap_idle),
    .ap_ready(grp_MixColumn_AddRoundKe_fu_183_ap_ready),
    .statemt_address0(grp_MixColumn_AddRoundKe_fu_183_statemt_address0),
    .statemt_ce0(grp_MixColumn_AddRoundKe_fu_183_statemt_ce0),
    .statemt_we0(grp_MixColumn_AddRoundKe_fu_183_statemt_we0),
    .statemt_d0(grp_MixColumn_AddRoundKe_fu_183_statemt_d0),
    .statemt_q0(buff_q0),
    .statemt_address1(grp_MixColumn_AddRoundKe_fu_183_statemt_address1),
    .statemt_ce1(grp_MixColumn_AddRoundKe_fu_183_statemt_ce1),
    .statemt_we1(grp_MixColumn_AddRoundKe_fu_183_statemt_we1),
    .statemt_d1(grp_MixColumn_AddRoundKe_fu_183_statemt_d1),
    .statemt_q1(buff_q1),
    .nb(reg_236),
    .n(i_reg_138),
    .word_address0(grp_MixColumn_AddRoundKe_fu_183_word_address0),
    .word_ce0(grp_MixColumn_AddRoundKe_fu_183_word_ce0),
    .word_q0(word_q0),
    .word_address1(grp_MixColumn_AddRoundKe_fu_183_word_address1),
    .word_ce1(grp_MixColumn_AddRoundKe_fu_183_word_ce1),
    .word_q1(word_q1)
);

AddRoundKey grp_AddRoundKey_fu_194(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_AddRoundKey_fu_194_ap_start),
    .ap_done(grp_AddRoundKey_fu_194_ap_done),
    .ap_idle(grp_AddRoundKey_fu_194_ap_idle),
    .ap_ready(grp_AddRoundKey_fu_194_ap_ready),
    .statemt_address0(grp_AddRoundKey_fu_194_statemt_address0),
    .statemt_ce0(grp_AddRoundKey_fu_194_statemt_ce0),
    .statemt_we0(grp_AddRoundKey_fu_194_statemt_we0),
    .statemt_d0(grp_AddRoundKey_fu_194_statemt_d0),
    .statemt_q0(buff_q0),
    .statemt_address1(grp_AddRoundKey_fu_194_statemt_address1),
    .statemt_ce1(grp_AddRoundKey_fu_194_statemt_ce1),
    .statemt_we1(grp_AddRoundKey_fu_194_statemt_we1),
    .statemt_d1(grp_AddRoundKey_fu_194_statemt_d1),
    .statemt_q1(buff_q1),
    .type_r(type_reg_324),
    .n(grp_AddRoundKey_fu_194_n),
    .word_address0(grp_AddRoundKey_fu_194_word_address0),
    .word_ce0(grp_AddRoundKey_fu_194_word_ce0),
    .word_q0(word_q0),
    .word_address1(grp_AddRoundKey_fu_194_word_address1),
    .word_ce1(grp_AddRoundKey_fu_194_word_ce1),
    .word_q1(word_q1)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_reg_grp_AddRoundKey_fu_194_ap_start <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state12))) begin
            ap_reg_grp_AddRoundKey_fu_194_ap_start <= 1'b1;
        end else if ((1'b1 == grp_AddRoundKey_fu_194_ap_ready)) begin
            ap_reg_grp_AddRoundKey_fu_194_ap_start <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_reg_grp_ByteSub_ShiftRow_fu_174_ap_start <= 1'b0;
    end else begin
        if ((((1'b1 == ap_CS_fsm_state7) & (tmp_1_fu_264_p2 == 1'b0)) | ((1'b1 == ap_CS_fsm_state7) & ~(tmp_1_fu_264_p2 == 1'b0)))) begin
            ap_reg_grp_ByteSub_ShiftRow_fu_174_ap_start <= 1'b1;
        end else if ((1'b1 == grp_ByteSub_ShiftRow_fu_174_ap_ready)) begin
            ap_reg_grp_ByteSub_ShiftRow_fu_174_ap_start <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_reg_grp_KeySchedule_fu_161_ap_start <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state3)) begin
            ap_reg_grp_KeySchedule_fu_161_ap_start <= 1'b1;
        end else if ((1'b1 == grp_KeySchedule_fu_161_ap_ready)) begin
            ap_reg_grp_KeySchedule_fu_161_ap_start <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_reg_grp_MixColumn_AddRoundKe_fu_183_ap_start <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state9)) begin
            ap_reg_grp_MixColumn_AddRoundKe_fu_183_ap_start <= 1'b1;
        end else if ((1'b1 == grp_MixColumn_AddRoundKe_fu_183_ap_ready)) begin
            ap_reg_grp_MixColumn_AddRoundKe_fu_183_ap_start <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state15)) begin
        i_1_reg_150 <= i_3_reg_356;
    end else if ((~(1'b0 == grp_AddRoundKey_fu_194_ap_done) & (1'b1 == ap_CS_fsm_state13))) begin
        i_1_reg_150 <= ap_const_lv5_0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state10) & ~(1'b0 == grp_MixColumn_AddRoundKe_fu_183_ap_done))) begin
        i_reg_138 <= i_2_reg_348;
    end else if (((1'b1 == ap_CS_fsm_state6) & ~(1'b0 == grp_AddRoundKey_fu_194_ap_done))) begin
        i_reg_138 <= ap_const_lv32_1;
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & (type_reg_324 == ap_const_lv32_3E880)) | ((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & (type_reg_324 == ap_const_lv32_2EE80)) | ((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & (type_reg_324 == ap_const_lv32_1F480)))) begin
                nb[1] <= 1'b0;
        nb[2] <= 1'b1;
        nb[3] <= 1'b0;
    end else if ((((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & (type_reg_324 == ap_const_lv32_3E8C0)) | ((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & ((type_reg_324 == ap_const_lv32_1F4C0) | (type_reg_324 == ap_const_lv32_2EEC0))))) begin
                nb[1] <= 1'b1;
        nb[2] <= 1'b1;
        nb[3] <= 1'b0;
    end else if (((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & ((type_reg_324 == ap_const_lv32_1F500) | (type_reg_324 == ap_const_lv32_2EF00) | (type_reg_324 == ap_const_lv32_3E900)))) begin
                nb[1] <= 1'b0;
        nb[2] <= 1'b0;
        nb[3] <= 1'b1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & (type_reg_324 == ap_const_lv32_1F480))) begin
                round[1] <= 1'b0;
        round[2] <= 1'b0;
    end else if ((((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & ((type_reg_324 == ap_const_lv32_1F4C0) | (type_reg_324 == ap_const_lv32_2EEC0))) | ((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & (type_reg_324 == ap_const_lv32_2EE80)))) begin
                round[1] <= 1'b1;
        round[2] <= 1'b0;
    end else if ((((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & ((type_reg_324 == ap_const_lv32_1F500) | (type_reg_324 == ap_const_lv32_2EF00) | (type_reg_324 == ap_const_lv32_3E900))) | ((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & (type_reg_324 == ap_const_lv32_3E8C0)) | ((1'b1 == ap_CS_fsm_state4) & ~(1'b0 == grp_KeySchedule_fu_161_ap_done) & (type_reg_324 == ap_const_lv32_3E880)))) begin
                round[1] <= 1'b0;
        round[2] <= 1'b1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        i_2_reg_348 <= i_2_fu_270_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state14)) begin
        i_3_reg_356 <= i_3_fu_282_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_state7) & (tmp_1_fu_264_p2 == 1'b0)) | ((1'b1 == ap_CS_fsm_state7) & ~(tmp_1_fu_264_p2 == 1'b0)) | (1'b1 == ap_CS_fsm_state9))) begin
        reg_236[3 : 1] <= nb[3 : 1];
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        type_reg_324 <= buff_q0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state14) & ~(1'b0 == exitcond_fu_276_p2))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_start) & (ap_CS_fsm_state1 == 1'b1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state14) & ~(1'b0 == exitcond_fu_276_p2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state14)) begin
        buff_address0 = tmp_4_fu_288_p1;
    end else if ((ap_CS_fsm_state1 == 1'b1)) begin
        buff_address0 = ap_const_lv64_41;
    end else if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        buff_address0 = grp_AddRoundKey_fu_194_statemt_address0;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        buff_address0 = grp_MixColumn_AddRoundKe_fu_183_statemt_address0;
    end else if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state11))) begin
        buff_address0 = grp_ByteSub_ShiftRow_fu_174_statemt_address0;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buff_address0 = grp_KeySchedule_fu_161_key_address0;
    end else begin
        buff_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state14) | (1'b1 == ap_CS_fsm_state15))) begin
        buff_address1 = ap_const_lv64_40;
    end else if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        buff_address1 = grp_AddRoundKey_fu_194_statemt_address1;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        buff_address1 = grp_MixColumn_AddRoundKe_fu_183_statemt_address1;
    end else if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state11))) begin
        buff_address1 = grp_ByteSub_ShiftRow_fu_174_statemt_address1;
    end else begin
        buff_address1 = 'bx;
    end
end

always @ (*) begin
    if ((((ap_CS_fsm_state1 == 1'b1) & ~(ap_start == 1'b0)) | (1'b1 == ap_CS_fsm_state14))) begin
        buff_ce0 = 1'b1;
    end else if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        buff_ce0 = grp_AddRoundKey_fu_194_statemt_ce0;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        buff_ce0 = grp_MixColumn_AddRoundKe_fu_183_statemt_ce0;
    end else if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state11))) begin
        buff_ce0 = grp_ByteSub_ShiftRow_fu_174_statemt_ce0;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buff_ce0 = grp_KeySchedule_fu_161_key_ce0;
    end else begin
        buff_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state14) | (1'b1 == ap_CS_fsm_state15))) begin
        buff_ce1 = 1'b1;
    end else if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        buff_ce1 = grp_AddRoundKey_fu_194_statemt_ce1;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        buff_ce1 = grp_MixColumn_AddRoundKe_fu_183_statemt_ce1;
    end else if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state11))) begin
        buff_ce1 = grp_ByteSub_ShiftRow_fu_174_statemt_ce1;
    end else begin
        buff_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        buff_d0 = grp_AddRoundKey_fu_194_statemt_d0;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        buff_d0 = grp_MixColumn_AddRoundKe_fu_183_statemt_d0;
    end else if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state11))) begin
        buff_d0 = grp_ByteSub_ShiftRow_fu_174_statemt_d0;
    end else begin
        buff_d0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state15)) begin
        buff_d1 = tmp_7_fu_312_p2;
    end else if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        buff_d1 = grp_AddRoundKey_fu_194_statemt_d1;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        buff_d1 = grp_MixColumn_AddRoundKe_fu_183_statemt_d1;
    end else if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state11))) begin
        buff_d1 = grp_ByteSub_ShiftRow_fu_174_statemt_d1;
    end else begin
        buff_d1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        buff_we0 = grp_AddRoundKey_fu_194_statemt_we0;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        buff_we0 = grp_MixColumn_AddRoundKe_fu_183_statemt_we0;
    end else if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state11))) begin
        buff_we0 = grp_ByteSub_ShiftRow_fu_174_statemt_we0;
    end else begin
        buff_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state15)) begin
        buff_we1 = 1'b1;
    end else if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        buff_we1 = grp_AddRoundKey_fu_194_statemt_we1;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        buff_we1 = grp_MixColumn_AddRoundKe_fu_183_statemt_we1;
    end else if (((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state11))) begin
        buff_we1 = grp_ByteSub_ShiftRow_fu_174_statemt_we1;
    end else begin
        buff_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state13)) begin
        grp_AddRoundKey_fu_194_n = i_reg_138;
    end else if ((1'b1 == ap_CS_fsm_state6)) begin
        grp_AddRoundKey_fu_194_n = ap_const_lv32_0;
    end else begin
        grp_AddRoundKey_fu_194_n = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state14)) begin
        out_enc_statemt_ce0 = 1'b1;
    end else begin
        out_enc_statemt_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        word_address0 = grp_AddRoundKey_fu_194_word_address0;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        word_address0 = grp_MixColumn_AddRoundKe_fu_183_word_address0;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        word_address0 = grp_KeySchedule_fu_161_word_address0;
    end else begin
        word_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        word_address1 = grp_AddRoundKey_fu_194_word_address1;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        word_address1 = grp_MixColumn_AddRoundKe_fu_183_word_address1;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        word_address1 = grp_KeySchedule_fu_161_word_address1;
    end else begin
        word_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        word_ce0 = grp_AddRoundKey_fu_194_word_ce0;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        word_ce0 = grp_MixColumn_AddRoundKe_fu_183_word_ce0;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        word_ce0 = grp_KeySchedule_fu_161_word_ce0;
    end else begin
        word_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state13))) begin
        word_ce1 = grp_AddRoundKey_fu_194_word_ce1;
    end else if ((1'b1 == ap_CS_fsm_state10)) begin
        word_ce1 = grp_MixColumn_AddRoundKe_fu_183_word_ce1;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        word_ce1 = grp_KeySchedule_fu_161_word_ce1;
    end else begin
        word_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        word_we0 = grp_KeySchedule_fu_161_word_we0;
    end else begin
        word_we0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (~(ap_start == 1'b0)) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            if (~(1'b0 == grp_KeySchedule_fu_161_ap_done)) begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            if (~(1'b0 == grp_AddRoundKey_fu_194_ap_done)) begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end
        end
        ap_ST_fsm_state7 : begin
            if (~(tmp_1_fu_264_p2 == 1'b0)) begin
                ap_NS_fsm = ap_ST_fsm_state11;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state8;
            end
        end
        ap_ST_fsm_state8 : begin
            if (~(1'b0 == grp_ByteSub_ShiftRow_fu_174_ap_done)) begin
                ap_NS_fsm = ap_ST_fsm_state9;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state8;
            end
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            if (~(1'b0 == grp_MixColumn_AddRoundKe_fu_183_ap_done)) begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state10;
            end
        end
        ap_ST_fsm_state11 : begin
            if (~(1'b0 == grp_ByteSub_ShiftRow_fu_174_ap_done)) begin
                ap_NS_fsm = ap_ST_fsm_state12;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state11;
            end
        end
        ap_ST_fsm_state12 : begin
            ap_NS_fsm = ap_ST_fsm_state13;
        end
        ap_ST_fsm_state13 : begin
            if (~(1'b0 == grp_AddRoundKey_fu_194_ap_done)) begin
                ap_NS_fsm = ap_ST_fsm_state14;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state13;
            end
        end
        ap_ST_fsm_state14 : begin
            if (~(1'b0 == exitcond_fu_276_p2)) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state15;
            end
        end
        ap_ST_fsm_state15 : begin
            ap_NS_fsm = ap_ST_fsm_state14;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[ap_const_lv32_0];

assign ap_CS_fsm_state10 = ap_CS_fsm[ap_const_lv32_9];

assign ap_CS_fsm_state11 = ap_CS_fsm[ap_const_lv32_A];

assign ap_CS_fsm_state12 = ap_CS_fsm[ap_const_lv32_B];

assign ap_CS_fsm_state13 = ap_CS_fsm[ap_const_lv32_C];

assign ap_CS_fsm_state14 = ap_CS_fsm[ap_const_lv32_D];

assign ap_CS_fsm_state15 = ap_CS_fsm[ap_const_lv32_E];

assign ap_CS_fsm_state2 = ap_CS_fsm[ap_const_lv32_1];

assign ap_CS_fsm_state3 = ap_CS_fsm[ap_const_lv32_2];

assign ap_CS_fsm_state4 = ap_CS_fsm[ap_const_lv32_3];

assign ap_CS_fsm_state5 = ap_CS_fsm[ap_const_lv32_4];

assign ap_CS_fsm_state6 = ap_CS_fsm[ap_const_lv32_5];

assign ap_CS_fsm_state7 = ap_CS_fsm[ap_const_lv32_6];

assign ap_CS_fsm_state8 = ap_CS_fsm[ap_const_lv32_7];

assign ap_CS_fsm_state9 = ap_CS_fsm[ap_const_lv32_8];

assign ap_return = (n + m);

assign exitcond_fu_276_p2 = ((i_1_reg_150 == ap_const_lv5_10) ? 1'b1 : 1'b0);

assign grp_AddRoundKey_fu_194_ap_start = ap_reg_grp_AddRoundKey_fu_194_ap_start;

assign grp_ByteSub_ShiftRow_fu_174_ap_start = ap_reg_grp_ByteSub_ShiftRow_fu_174_ap_start;

assign grp_KeySchedule_fu_161_ap_start = ap_reg_grp_KeySchedule_fu_161_ap_start;

assign grp_MixColumn_AddRoundKe_fu_183_ap_start = ap_reg_grp_MixColumn_AddRoundKe_fu_183_ap_start;

assign i_2_fu_270_p2 = (i_reg_138 + ap_const_lv32_1);

assign i_3_fu_282_p2 = (i_1_reg_150 + ap_const_lv5_1);

assign out_enc_statemt_address0 = tmp_4_fu_288_p1;

assign out_enc_statemt_load_1_fu_298_p1 = out_enc_statemt_q0;

assign tmp_1_fu_264_p2 = (($signed(i_reg_138) > $signed(tmp_fu_258_p2)) ? 1'b1 : 1'b0);

assign tmp_4_fu_288_p1 = i_1_reg_150;

assign tmp_5_fu_302_p2 = ((buff_q0 != out_enc_statemt_load_1_fu_298_p1) ? 1'b1 : 1'b0);

assign tmp_6_fu_308_p1 = tmp_5_fu_302_p2;

assign tmp_7_fu_312_p2 = (buff_q1 + tmp_6_fu_308_p1);

assign tmp_fu_258_p2 = (round + ap_const_lv32_9);

always @ (posedge ap_clk) begin
    round[0] <= 1'b0;
    round[31:3] <= 29'b00000000000000000000000000000;
    nb[0] <= 1'b0;
    nb[31:4] <= 28'b0000000000000000000000000000;
    reg_236[0] <= 1'b0;
    reg_236[31:4] <= 28'b0000000000000000000000000000;
end

endmodule //encrypt1
