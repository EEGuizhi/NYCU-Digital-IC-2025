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
.param Np  = 1
.param Nn  = 1
.param VDD = 0.8

******************* Three-Stage Ring Oscillator *******************
.subckt INV    vin vout vdd gnd
    m1    vout vin vdd vdd  pmos_rvt nfin=Np
    m2    vout vin gnd gnd  nmos_rvt nfin=Nn
.ends

Xinv   vin vout vdd gnd  INV

******************* Power declaration *******************
Vgnd    gnd  0  0
Vvdd    vdd  0  VDD

******************* Input & Analysis *******************
Vvin    vin  0  0

.dc  Vvin 0 VDD 0.01
.alter
.param Np = 2

.end
