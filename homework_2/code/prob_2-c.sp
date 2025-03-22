* NYCU IEE DIC 1132 homework 2
* BSChen

******************* Simulator setting *******************
.option accurate
.option post           
.op
.TEMP 25.0

******************* Library setting *******************
.protect
.lib '../bulk_32nm.l' TT
.unprotect

******************* Parameter setting *******************
.param L    = 32n
.param Wp   = 106n
.param Wn   = 64n
.param Wp_4 = 580n
.param Wn_1 = 190n
.param VDD  = 1.0

******************* Three-Stage Ring Oscillator *******************
.subckt STB    vin vout vdd gnd
    mp4    vp   vin  vdd vdd  pmos_svt W=Wp_4 L=L
    mp6    gnd  vout vp  vdd  pmos_svt W=Wp   L=L
    mp5    vout vin  vp  vdd  pmos_svt W=Wp   L=L
    mn2    vout vin  vn  gnd  nmos_svt W=Wn   L=L
    mn3    vdd  vout vn  gnd  nmos_svt W=Wn   L=L
    mn1    vn   vin  gnd gnd  nmos_svt W=Wn_1 L=L
.ends

Xstb1   v1 v2 vdd gnd  STB
Xstb2   v2 v3 vdd gnd  STB
Xstb3   v3 v1 vdd gnd  STB
Cload   v1 gnd         5f
Cload   v2 gnd         5f
Cload   v3 gnd         5f

******************* Power declaration *******************
Vgnd    gnd  0  0
Vvdd    vdd  0  VDD

******************* Transient analysis setting *******************
.ic V(v1) = 0
.tran 5p 4n

******************* Measurement *******************
.measure tran tdf  TRIG V(v1)  VAL='0.5*VDD' FALL=1 TARG V(v2) VAL='0.5*VDD' FALL=1
.measure tran tdr  TRIG V(v1)  VAL='0.5*VDD' RISE=1 TARG V(v2) VAL='0.5*VDD' RISE=1
.measure tran tr   TRIG V(v1)  VAL='0.1*VDD' RISE=1 TARG V(v1) VAL='0.9*VDD' RISE=1
.measure tran tf   TRIG V(v1)  VAL='0.9*VDD' FALL=1 TARG V(v1) VAL='0.1*VDD' FALL=1

.measure tran clk_period  TRIG V(v1) VAL='0.5*VDD' RISE=1 TARG V(v1) VAL='0.5*VDD' RISE=2

******************* Power Analysis *******************
.measure tran avg_power     AVG  POWER
.measure tran peak_power    MAX  POWER
.measure tran leakage_power FIND POWER AT=4n

.end
