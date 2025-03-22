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
.param VDD = 1.0

******************* Circuit description *******************
.subckt SRAM    word bit bit_b q q_b vdd gnd
    mp1    q   q_b  vdd   vdd  pmos_svt W=48n  L=48n AD=4078n  AS=4078n  PD=266n PS=266n
    mp2    q_b q    vdd   vdd  pmos_svt W=48n  L=48n AD=4078n  AS=4078n  PD=266n PS=266n
    mn1    q   q_b  gnd   gnd  nmos_svt W=128n L=32n AD=17208n AS=11973n PD=620n PS=443n
    mn2    q_b q    gnd   gnd  nmos_svt W=128n L=32n AD=17208n AS=11973n PD=620n PS=443n
    mn3    q   word bit   gnd  nmos_svt W=59n  L=32n AD=17208n AS=5235n  PD=620n PS=295n
    mn4    q_b word bit_b gnd  nmos_svt W=59n  L=32n AD=17208n AS=5235n  PD=620n PS=295n
.ends

Xstb    word bit bit_b q q_b vdd gnd  SRAM
* Cl_1    q    gnd                      5f
* Cl_2    q_b  gnd                      5f

******************* Power declaration *******************
Vgnd     gnd  0  0
Vvdd     vdd  0  VDD

******************* Input & Analysis *******************
Vword    word  0  VDD  *(keep word as 1)
Vbit     bit   0  0
Vbit_b   bit_b 0  VDD

.option  captab
.ic      V(q)=0  V(q_b)=1  V(word)=VDD
.tran    10p  100n  uic

.alter
Vbit     bit   0  VDD
Vbit_b   bit_b 0  0
.ic      V(q)=1  V(q_b)=0  V(word)=VDD

.end
