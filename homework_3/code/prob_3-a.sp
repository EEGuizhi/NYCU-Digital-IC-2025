* NYCU IEE DIC 1132 homework 3
* BSChen

******************* Simulator setting *******************
.option accurate
.option post           
.op
.TEMP 25.0

******************* Library setting *******************
.protect
.lib '../N16ADFP_SPICE_MODEL/n16adfp_spice_model_v1d0_usage.l' FFMacro_MOS_MOSCAP
.unprotect

******************* Parameter setting *******************
.param L   = 16n
.param VDD = 0.8

******************* Circuit description *******************
.subckt INV    vin vout vdd gnd
    m1    vout vin vdd vdd  pch_svt_mac nfin=1 l=L
    m2    vout vin gnd gnd  nch_svt_mac nfin=1 l=L
.ends

.subckt TG    vin vout en_p en_n
    mp    in en_p out vdd  pch_svt_mac nfin=4 l=L
    mn    in en_n out vss  nch_svt_mac nfin=4 l=L
.ends

.subckt DFF    d clk q q_b vdd gnd
    Xinv_C    clk clk_b vdd gnd    INV
    Xinv_1    d   v1    vdd gnd    INV
    Xtg_1     v1  v2    clk clk_b  TG
    Xinv_2    v2  v3    vdd gnd    INV   
    Xinv_3    v3  v2    vdd gnd    INV
    Xtg_2     v3  v4    clk clk_b  TG
    Xinv_4    v4  v5    vdd gnd    INV
    Xinv_5    v5  v4    vdd gnd    INV
    Xinv_Q    v5  q     vdd gnd    INV
    Xinv_Qb   v4  q_b   vdd gnd    INV
.ends

Xdff  d clk q q_b vdd gnd  DFF

******************* Power declaration *******************
Vgnd    gnd  0  0
Vvdd    vdd  0  VDD

******************* Input & Analysis *******************


.end
