* NYCU IEE DIC 1132 homework 4
* BSChen

******************* Simulator setting *******************
.option accurate
.option post           
.op
.TEMP 25.0

******************* Library setting *******************
.protect
.lib '../N16ADFP_SPICE_MODEL/n16adfp_spice_model_v1d0_usage.l' FFMacro_MOS_MOSCAP
.unprotect

******************* Parameter setting *******************
.param L   = 16n
.param VDD = 0.8

******************* Circuit description *******************
.subckt DFF   clk d q vdd vss
    mp1    n5 d   vdd vdd  pch_svt_mac l=L nfin=1
    mp2    n0 clk n5  vdd  pch_svt_mac l=L nfin=2
    mn1    n0 d   vss vss  nch_svt_mac l=L nfin=1

    mp3    n1 clk vdd vdd  pch_svt_mac l=L nfin=1
    mn2    n1 n0  n2  vss  nch_svt_mac l=L nfin=2
    mn3    n2 clk vss vss  nch_svt_mac l=L nfin=2

    mp4    n3 n1  vdd vdd  pch_svt_mac l=L nfin=2
    mn4    n3 clk n4  vss  nch_svt_mac l=L nfin=1
    mn5    n4 n1  vss vss  nch_svt_mac l=L nfin=1

    mp5    q  n3  vdd vdd  pch_svt_mac l=L nfin=1
    mn6    q  n3  vss vss  nch_svt_mac l=L nfin=1
.ends

Xdff   clk d q vdd vss  DFF

******************* Power declaration *******************
Vgnd  vss 0  0
Vvdd  vdd 0  VDD

******************* Input & Analysis *******************
Vvin    d     vss  pulse(0 VDD 1.3n 0.01n 0.01n 1.29n 2.5n)
Vclk    clk   vss  pulse(0 VDD 0.0n 0.01n 0.01n 0.99n 2.0n)
Vrst_b  rst_b vss  VDD

** Simulation
.tran 1p 15n

** Setup time & Clock-to-Q propagation delay
.meas tran t_setup_1  TRIG V(d)   VAL='0.5*VDD' RISE=1  TARG V(Xdff.n0) VAL='0.5*VDD' FALL=1
.meas tran t_pcq_1    TRIG V(clk) VAL='0.5*VDD' RISE=2  TARG V(q)       VAL='0.5*VDD' RISE=1
.meas tran t_setup_0  TRIG V(d)   VAL='0.5*VDD' FALL=2  TARG V(Xdff.n0) VAL='0.5*VDD' RISE=2
.meas tran t_pcq_0    TRIG V(clk) VAL='0.5*VDD' RISE=4  TARG V(q)       VAL='0.5*VDD' FALL=1

.end
