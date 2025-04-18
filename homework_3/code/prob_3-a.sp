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
.subckt INV    vin vout vdd vss
    m1    vout vin vdd vdd  pch_svt_mac l=L nfin=1
    m2    vout vin vss vss  nch_svt_mac l=L nfin=1
.ends

.subckt TG    vin vout en_p en_n
    mp    vin en_p out vdd  pch_svt_mac l=L nfin=4
    mn    vin en_n out vss  nch_svt_mac l=L nfin=4
.ends

.subckt NAND    vin1 vin2 vout vdd vss
    mp1    vout vin1 vdd vdd  pch_svt_mac l=L nfin=1
    mp2    vout vin2 vdd vdd  pch_svt_mac l=L nfin=1
    mn1    vout vin1 v1  vss  nch_svt_mac l=L nfin=2
    mn2    v1   vin2 vss vss  nch_svt_mac l=L nfin=2
.ends

.subckt DFF    rst d clk clk_b q q_b vdd vss
    
    Xinv_1    d   v1    vdd vss    INV
    Xtg_1     v1  v2    clk clk_b  TG
    Xinv_2    v2  v3    vdd vss    INV   
    Xinv_3    v3  v2    vdd vss    INV
    Xtg_2     v3  v4    clk clk_b  TG
    Xinv_4    v4  v5    vdd vss    INV
    Xinv_5    v5  v4    vdd vss    INV
    Xinv_Q    v5  q     vdd vss    INV
    Xinv_Qb   v4  q_b   vdd vss    INV
.ends

Xdff  d clk q q_b vdd vss  DFF

******************* Power declaration *******************
Vgnd    vss  0  0
Vvdd    vdd  0  VDD

******************* Input & Analysis *******************


.end
