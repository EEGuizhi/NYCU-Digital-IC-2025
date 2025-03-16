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
.param wp = 64n
.param wn = 64n
.param VDD = 1.0

******************* Circuit description *******************
mn1    vd_n  vg_n  vs_n  gnd  nmos_svt w=wn l=32n
mp1    vd_p  vg_p  vs_p  vdd  pmos_svt w=wp l=32n

******************* Power declaration *******************
Vgnd     gnd   0  0
Vvdd     vdd   0  VDD

Vvd_n    vd_n  0  VDD
Vvg_n    vg_n  0  VDD
Vvs_n    vs_n  0  0

Vvd_p    vd_p  0  0
Vvg_p    vg_p  0  0
Vvs_p    vs_p  0  VDD

******************* Input declaration *******************
* skipped

******************* Analysis setting *******************
.dc  Vvd_n  0  VDD  0.01  sweep  Vvg_n  0  VDD  0.1
.dc  Vvd_p  VDD  0  0.01  sweep  Vvg_p  VDD  0  0.1
.probe  DC  i(mn1)  i(mp1)

.end
