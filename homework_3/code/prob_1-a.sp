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

Xinv   vin vout vdd vss  INV

******************* Power declaration *******************
Vgnd    vss  0  0
Vvdd    vdd  0  VDD

******************* Input & Analysis *******************
Vvin    vin  0  0

.dc  Vvin 0 VDD  0.01
.alter
.param Np = 2

.end
