* NYCU IEE DIC 1132 homework 1
* BSChen

******************* Simulator setting *******************
.option accurate
.option post           
.op
.TEMP 25.0

******************* Library setting *******************
.protect
.lib '../bulk_32nm.l'TT
.unprotect

******************* Parameter setting *******************
.param wp = 64n
.param wn = 64n

******************* Circuit description *******************
mn1    vd_n  vg_n  vs_n  gnd  nmos_svt w=wn1 l=32n
mp1    vd_p  vg_p  vs_p  vdd  pmos_svt w=wp1 l=32n

******************* Power declaration *******************
Vgnd     gnd  0  0
Vvdd     vdd  0  1.0

Vvd_n    vd_n  0  1.0
Vvg_n    vg_n  0  1.0
Vvs_n    vs_n  0  0

Vvd_p    vd_p  0  0
Vvg_p    vg_p  0  0
Vvs_p    vs_p  0  1.0

******************* Input declaration *******************


******************* Analysis setting *******************
.dc 

.end   


