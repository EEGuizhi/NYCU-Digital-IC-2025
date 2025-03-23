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

******************* Circuit description *******************
.subckt STB    vin vout vdd gnd
    mp4    vp   vin  vdd vdd  pmos_svt W=Wp_4 L=L
    mp6    gnd  vout vp  vdd  pmos_svt W=Wp   L=L
    mp5    vout vin  vp  vdd  pmos_svt W=Wp   L=L
    mn2    vout vin  vn  gnd  nmos_svt W=Wn   L=L
    mn3    vdd  vout vn  gnd  nmos_svt W=Wn   L=L
    mn1    vn   vin  gnd gnd  nmos_svt W=Wn_1 L=L
.ends

Xstb    vin vout vdd gnd  STB

******************* Power declaration *******************
Vgnd    gnd  0  0
Vvdd    vdd  0  VDD

******************* Input & Analysis *******************
Vvin    vin  0  PULSE(0 VDD 0 0.1n 0.1n 3n 6n)
.tran   10p  6n

******************* Measurement commands *******************
.measure tran tpdf  TRIG V(vin)  VAL='0.5*VDD' RISE=1  TARG V(vout) VAL='0.5*VDD' FALL=1
.measure tran tpdr  TRIG V(vin)  VAL='0.5*VDD' FALL=1  TARG V(vout) VAL='0.5*VDD' RISE=1
.measure tran tr    TRIG V(vout) VAL='0.1*VDD' RISE=1  TARG V(vout) VAL='0.9*VDD' RISE=1
.measure tran tf    TRIG V(vout) VAL='0.9*VDD' FALL=1  TARG V(vout) VAL='0.1*VDD' FALL=1

.end
