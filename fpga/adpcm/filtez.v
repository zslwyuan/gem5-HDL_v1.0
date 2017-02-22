/* verilator lint_off UNUSED */
/* verilator lint_off DECLFILENAME */
/* verilator lint_off STMTDLY */
/* verilator lint_off WIDTH */
/* verilator lint_off UNUSED */
/* verilator lint_off WIDTH */
/* verilator lint_off DECLFILENAME */
/* verilator lint_off DECLFILENAME */
// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2016.4
// Copyright (C) 1986-2016 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 
/* verilator lint_off WIDTH */
/* verilator lint_off UNUSED */
module filtez (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        bpl_address0,
        bpl_ce0,
        bpl_q0,
        bpl_address1,
        bpl_ce1,
        bpl_q1,
        bpl_offset,
        dlt_offset,
        ap_return
);

parameter    ap_ST_fsm_state1 = 12'b1;
parameter    ap_ST_fsm_state2 = 12'b10;
parameter    ap_ST_fsm_state3 = 12'b100;
parameter    ap_ST_fsm_state4 = 12'b1000;
parameter    ap_ST_fsm_state5 = 12'b10000;
parameter    ap_ST_fsm_state6 = 12'b100000;
parameter    ap_ST_fsm_state7 = 12'b1000000;
parameter    ap_ST_fsm_state8 = 12'b10000000;
parameter    ap_ST_fsm_state9 = 12'b100000000;
parameter    ap_ST_fsm_state10 = 12'b1000000000;
parameter    ap_ST_fsm_state11 = 12'b10000000000;
parameter    ap_ST_fsm_state12 = 12'b100000000000;
parameter    ap_const_lv32_0 = 32'b00000000000000000000000000000000;
parameter    ap_const_lv32_1 = 32'b1;
parameter    ap_const_lv32_7 = 32'b111;
parameter    ap_const_lv32_2 = 32'b10;
parameter    ap_const_lv32_4 = 32'b100;
parameter    ap_const_lv32_6 = 32'b110;
parameter    ap_const_lv32_8 = 32'b1000;
parameter    ap_const_lv32_A = 32'b1010;
parameter    ap_const_lv32_B = 32'b1011;
parameter    ap_const_lv32_5 = 32'b101;
parameter    ap_const_lv3_0 = 3'b000;
parameter    ap_const_lv3_1 = 3'b1;
parameter    ap_const_lv3_5 = 3'b101;
parameter    ap_const_lv32_E = 32'b1110;
parameter    ap_const_lv32_2D = 32'b101101;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [6:0] bpl_address0;
output   bpl_ce0;
input  [31:0] bpl_q0;
output  [6:0] bpl_address1;
output   bpl_ce1;
input  [31:0] bpl_q1;
input  [6:0] bpl_offset;
input  [6:0] dlt_offset;
output  [31:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[6:0] bpl_address0;
reg bpl_ce0;
reg[6:0] bpl_address1;
reg bpl_ce1;
reg[31:0] ap_return;

(* fsm_encoding = "none" *) reg   [11:0] ap_CS_fsm;
wire   [0:0] ap_CS_fsm_state1;
reg  signed [31:0] reg_102;
wire   [0:0] ap_CS_fsm_state2;
wire   [0:0] ap_CS_fsm_state8;
reg  signed [31:0] reg_106;
wire   [5:0] tmp_12_fu_120_p1;
reg   [5:0] tmp_12_reg_217;
wire   [5:0] tmp_13_fu_124_p1;
reg   [5:0] tmp_13_reg_222;
wire   [0:0] ap_CS_fsm_state3;
wire   [63:0] grp_fu_136_p2;
reg   [63:0] zl_reg_237;
wire   [0:0] ap_CS_fsm_state5;
wire   [2:0] p_01_rec_fu_142_p2;
reg   [2:0] p_01_rec_reg_242;
wire   [0:0] ap_CS_fsm_state7;
wire   [0:0] ap_CS_fsm_state9;
wire   [63:0] grp_fu_196_p2;
reg   [63:0] tmp_4_reg_270;
wire   [0:0] ap_CS_fsm_state11;
wire   [63:0] zl_1_fu_202_p2;
wire   [0:0] ap_CS_fsm_state12;
reg   [63:0] zl1_reg_81;
wire   [0:0] ap_CS_fsm_state6;
reg   [2:0] dlt_pn_rec_reg_91;
wire   [63:0] dlt_offset_cast2_fu_110_p1;
wire   [63:0] bpl_offset_cast1_fu_115_p1;
wire   [63:0] sum3_cast_fu_157_p1;
wire   [63:0] sum_cast_fu_167_p1;
wire   [5:0] p_01_rec_cast_fu_148_p1;
wire   [5:0] sum3_fu_152_p2;
wire   [5:0] sum_fu_162_p2;
wire   [0:0] exitcond_fu_172_p2;
reg   [31:0] ap_return_preg;
reg   [11:0] ap_NS_fsm;

// power-on initialization
initial begin
 ap_CS_fsm = 12'b1;
 ap_return_preg = 32'b00000000000000000000000000000000;
end

encode_mul_32s_32bkb #(
    .ID( 1 ),
    .NUM_STAGE( 3 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 64 ))
encode_mul_32s_32bkb_U1(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(reg_102),
    .din1(reg_106),
    .ce(1'b1),
    .dout(grp_fu_136_p2)
);

encode_mul_32s_32bkb #(
    .ID( 1 ),
    .NUM_STAGE( 3 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 64 ))
encode_mul_32s_32bkb_U2(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(reg_106),
    .din1(reg_102),
    .ce(1'b1),
    .dout(grp_fu_196_p2)
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
        ap_return_preg <= ap_const_lv32_0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state7) & ~(exitcond_fu_172_p2 == 1'b0))) begin
            ap_return_preg <= {{zl1_reg_81[ap_const_lv32_2D : ap_const_lv32_E]}};
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state12)) begin
        dlt_pn_rec_reg_91 <= p_01_rec_reg_242;
    end else if ((1'b1 == ap_CS_fsm_state6)) begin
        dlt_pn_rec_reg_91 <= ap_const_lv3_0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state12)) begin
        zl1_reg_81 <= zl_1_fu_202_p2;
    end else if ((1'b1 == ap_CS_fsm_state6)) begin
        zl1_reg_81 <= zl_reg_237;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        p_01_rec_reg_242 <= p_01_rec_fu_142_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state8))) begin
        reg_102 <= bpl_q0;
        reg_106 <= bpl_q1;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_CS_fsm_state1 == 1'b1) & ~(ap_start == 1'b0))) begin
        tmp_12_reg_217 <= tmp_12_fu_120_p1;
        tmp_13_reg_222 <= tmp_13_fu_124_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state11)) begin
        tmp_4_reg_270 <= grp_fu_196_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        zl_reg_237 <= grp_fu_136_p2;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_start) & (ap_CS_fsm_state1 == 1'b1)) | ((1'b1 == ap_CS_fsm_state7) & ~(exitcond_fu_172_p2 == 1'b0)))) begin
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
    if (((1'b1 == ap_CS_fsm_state7) & ~(exitcond_fu_172_p2 == 1'b0))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state7) & ~(exitcond_fu_172_p2 == 1'b0))) begin
        ap_return = {{zl1_reg_81[ap_const_lv32_2D : ap_const_lv32_E]}};
    end else begin
        ap_return = ap_return_preg;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        bpl_address0 = sum_cast_fu_167_p1;
    end else if ((ap_CS_fsm_state1 == 1'b1)) begin
        bpl_address0 = bpl_offset_cast1_fu_115_p1;
    end else begin
        bpl_address0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        bpl_address1 = sum3_cast_fu_157_p1;
    end else if ((ap_CS_fsm_state1 == 1'b1)) begin
        bpl_address1 = dlt_offset_cast2_fu_110_p1;
    end else begin
        bpl_address1 = 'bx;
    end
end

always @ (*) begin
    if ((((ap_CS_fsm_state1 == 1'b1) & ~(ap_start == 1'b0)) | (1'b1 == ap_CS_fsm_state7))) begin
        bpl_ce0 = 1'b1;
    end else begin
        bpl_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_CS_fsm_state1 == 1'b1) & ~(ap_start == 1'b0)) | (1'b1 == ap_CS_fsm_state7))) begin
        bpl_ce1 = 1'b1;
    end else begin
        bpl_ce1 = 1'b0;
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
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            if (~(exitcond_fu_172_p2 == 1'b0)) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state8;
            end
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            ap_NS_fsm = ap_ST_fsm_state11;
        end
        ap_ST_fsm_state11 : begin
            ap_NS_fsm = ap_ST_fsm_state12;
        end
        ap_ST_fsm_state12 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[ap_const_lv32_0];

assign ap_CS_fsm_state11 = ap_CS_fsm[ap_const_lv32_A];

assign ap_CS_fsm_state12 = ap_CS_fsm[ap_const_lv32_B];

assign ap_CS_fsm_state2 = ap_CS_fsm[ap_const_lv32_1];

assign ap_CS_fsm_state3 = ap_CS_fsm[ap_const_lv32_2];

assign ap_CS_fsm_state5 = ap_CS_fsm[ap_const_lv32_4];

assign ap_CS_fsm_state6 = ap_CS_fsm[ap_const_lv32_5];

assign ap_CS_fsm_state7 = ap_CS_fsm[ap_const_lv32_6];

assign ap_CS_fsm_state8 = ap_CS_fsm[ap_const_lv32_7];

assign ap_CS_fsm_state9 = ap_CS_fsm[ap_const_lv32_8];

assign bpl_offset_cast1_fu_115_p1 = bpl_offset;

assign dlt_offset_cast2_fu_110_p1 = dlt_offset;

assign exitcond_fu_172_p2 = ((dlt_pn_rec_reg_91 == ap_const_lv3_5) ? 1'b1 : 1'b0);

assign p_01_rec_cast_fu_148_p1 = p_01_rec_fu_142_p2;

assign p_01_rec_fu_142_p2 = (dlt_pn_rec_reg_91 + ap_const_lv3_1);

assign sum3_cast_fu_157_p1 = sum3_fu_152_p2;

assign sum3_fu_152_p2 = (p_01_rec_cast_fu_148_p1 + tmp_12_reg_217);

assign sum_cast_fu_167_p1 = sum_fu_162_p2;

assign sum_fu_162_p2 = (p_01_rec_cast_fu_148_p1 + tmp_13_reg_222);

assign tmp_12_fu_120_p1 = dlt_offset[5:0];

assign tmp_13_fu_124_p1 = bpl_offset[5:0];

assign zl_1_fu_202_p2 = (tmp_4_reg_270 + zl1_reg_81);

endmodule //filtez
