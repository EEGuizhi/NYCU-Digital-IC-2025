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
Xstb3   v3 v4 vdd gnd  STB

******************* Power declaration *******************
Vgnd    gnd  0  0
Vvdd    vdd  0  VDD

******************* Analysis setting *******************
.tran 5p 4n

******************* Measurement (use .op) *******************
.ic   V(v1)=0

.alter
.ic   V(v1)=VDD

.end
