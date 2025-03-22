* NYCU IEE DIC 1132 homework 2
* BSChen

******************* Simulator setting *******************
.option accurate
.option post           
.op
.TEMP 25.0
.option captab

******************* Library setting *******************
.protect
.lib '../bulk_32nm.l' TT
.unprotect

******************* Parameter setting *******************
.param VDD = 1.0

******************* Circuit description *******************
.subckt SRAM    word bit bit_b q q_b vdd gnd
    mp1    q   q_b  vdd   vdd  pmos_svt W=48n  L=48n AD=4078e-18  AS=4078e-18  PD=266n PS=266n
    mp2    q_b q    vdd   vdd  pmos_svt W=48n  L=48n AD=4078e-18  AS=4078e-18  PD=266n PS=266n
    mn1    q   q_b  gnd   gnd  nmos_svt W=128n L=32n AD=17208e-18 AS=11973e-18 PD=620n PS=443n
    mn2    q_b q    gnd   gnd  nmos_svt W=128n L=32n AD=17208e-18 AS=11973e-18 PD=620n PS=443n
    mn3    q   word bit   gnd  nmos_svt W=59n  L=32n AD=17208e-18 AS=5235e-18  PD=620n PS=295n
    mn4    q_b word bit_b gnd  nmos_svt W=59n  L=32n AD=17208e-18 AS=5235e-18  PD=620n PS=295n
.ends

Xstb    word bit bit_b q q_b vdd gnd  SRAM

******************* Power declaration *******************
Vgnd     gnd  0  0
Vvdd     vdd  0  VDD

******************* Input & Analysis *******************
Vword    word  0  VDD

** Scenario 1 **
*Vbit     bit   0  0
*Vbit_b   bit_b 0  VDD
*.ic      V(q)=VDD  V(q_b)=0  V(word)=VDD

** Scenario 2 **
Vbit     bit   0  VDD
Vbit_b   bit_b 0  0
.ic      V(q)=0  V(q_b)=VDD  V(word)=VDD

.end
