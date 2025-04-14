* NYCU IEE DIC 1132 homework 3
* BSChen

******************* Simulator setting *******************
.option accurate
.option post           
.op
.TEMP 25.0

******************* Library setting *******************
.protect
.lib '../7nm_TT_160803.pm'
.unprotect

******************* Parameter setting *******************
.param Np  = 2
.param Nn  = 1
.param VDD = 0.8

******************* Circuit description *******************
.subckt INV    vin vout vdd gnd
    m1    vout vin vdd vdd  pmos_rvt nfin=Np
    m2    vout vin gnd gnd  nmos_rvt nfin=Nn
.ends

Xinv_1   v1 v2 vdd gnd  INV
Xinv_2   v2 v3 vdd gnd  INV
Xinv_3   v3 v1 vdd gnd  INV

******************* Power declaration *******************
Vgnd    gnd  0  0
Vvdd    vdd  0  VDD

******************* Input & Analysis *******************
** Transient
.ic V(v1) = 0
.tran 1p 100p

** Power Analysis
.measure tran avg_power     AVG  POWER  *FROM=100ps
.measure tran peak_power    MAX  POWER  *FROM=100ps

** Clock Period
.measure tran clk_period  TRIG V(v1) VAL='0.5*VDD' RISE=2  TARG V(v1) VAL='0.5*VDD' RISE=3
.print clk_freq =  1 / clk_period

.end
