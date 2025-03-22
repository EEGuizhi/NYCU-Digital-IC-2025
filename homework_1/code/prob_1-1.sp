* NYCU IEE DIC 1132 homework 1
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
.param wp  = 106n
.param wn  = 64n
.param L   = 32n
.param VDD = 1.0

.param wp_4 = 580n
.param wn_1 = 190n

******************* Circuit description *******************
.subckt STB    vin vout vdd gnd
    mp4    vp   vin  vdd vdd  pmos_svt w=wp_4 l=L
    mp6    gnd  vout vp  vdd  pmos_svt w=wp   l=L
    mp5    vout vin  vp  vdd  pmos_svt w=wp   l=L
    mn2    vout vin  vn  gnd  nmos_svt w=wn   l=L
    mn3    vdd  vout vn  gnd  nmos_svt w=wn   l=L
    mn1    vn   vin  gnd gnd  nmos_svt w=wn_1 l=L
.ends

Xstb    vin vout vdd gnd  STB
Cload   vout gnd          5f

******************* Power declaration *******************
Vgnd    gnd  0  0
Vvdd    vdd  0  VDD

Vvin    vin  0  0

******************* Analysis setting *******************
.dc  Vvin  0  VDD  0.005
.dc  Vvin  VDD  0  0.005

.end   
