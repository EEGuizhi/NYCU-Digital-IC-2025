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
.param Np  = 1
.param Nn  = 1
.param VDD = 0.8

******************* Circuit description *******************
.subckt INV    vin vout vdd vss
    m1    vout vin vdd vdd  pch_svt_mac nfin=Np l=L
    m2    vout vin vss vss  nch_svt_mac nfin=Nn l=L
.ends

Xinv_1   v1 v2 vdd vss  INV
Xinv_2   v2 v3 vdd vss  INV
Xinv_3   v3 v1 vdd vss  INV

******************* Power declaration *******************
Vgnd    vss  0  0
Vvdd    vdd  0  VDD

******************* Input & Analysis *******************
** Transient
.ic V(v1) = 0
.tran 1p 100p

** Power Analysis
.measure tran avg_power     AVG  POWER  FROM=5ps
.measure tran peak_power    MAX  POWER  FROM=5ps

** Clock Period
.measure tran clk_period1  TRIG V(v1) VAL='0.5*VDD' RISE=2  TARG V(v1) VAL='0.5*VDD' RISE=3
.measure tran clk_period2  TRIG V(v2) VAL='0.5*VDD' RISE=2  TARG V(v2) VAL='0.5*VDD' RISE=3
.measure tran clk_period3  TRIG V(v3) VAL='0.5*VDD' RISE=2  TARG V(v3) VAL='0.5*VDD' RISE=3

.print clk_freq1 = '1 / clk_period1'
.print clk_freq2 = '1 / clk_period2'
.print clk_freq3 = '1 / clk_period3'

.end
