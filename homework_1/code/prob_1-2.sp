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

.param wp34 = 212n
.param wn34 = 128n

******************* Circuit description *******************
.subckt STB    vin vb vout vdd gnd
    mp1    vp1  vin  vdd vdd  pmos_svt w=wp   l=L
    mp3    vp2  vout vp1 vdd  pmos_svt w=wp34 l=L
    mp4    gnd  vb   vp2 vdd  pmos_svt w=wp34 l=L
    mn2    vout vin  vp1 vdd  nmos_svt w=wp   l=L

    mn2    vout vin  vn1 gnd  nmos_svt w=wn   l=L
    mn4    vdd  vb   vn2 gnd  nmos_svt w=wn34 l=L
    mn3    vn2  vout vn1 gnd  nmos_svt w=wn34 l=L
    mn1    vn1  vin  gnd gnd  nmos_svt w=wn   l=L
.ends

Xstb    vin vb vout vdd gnd  STB
Cload   vout gnd             5f

******************* Power declaration *******************
Vgnd    gnd  0  0
Vvdd    vdd  0  VDD

Vvin    vin  0  0
Vvb     vb   0  0.56

******************* Analysis setting *******************
.dc  Vvin  0  VDD  0.005
.dc  Vvin  VDD  0  0.005

.end   
