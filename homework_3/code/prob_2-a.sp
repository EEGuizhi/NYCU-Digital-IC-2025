* NYCU IEE DIC 1132 homework 3
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
.subckt INV_LD    vin vout vdd vss
    mp    vout vin vdd vdd  pch_svt_mac l=L nfin=1
    mn    vout vin vss vss  nch_svt_mac l=L nfin=1
.ends

.subckt INV_N1    vin vout vdd vss
    mp    vout vin vdd vdd  pch_svt_mac l=L nfin=3  **nfin=1 for ver1
    mn    vout vin vss vss  nch_svt_mac l=L nfin=3  **nfin=1 for ver1
.ends

*.subckt INV_N2    vin vout vdd vss
*    mp    vout vin vdd vdd  pch_svt_mac l=L nfin=2
*    mn    vout vin vss vss  nch_svt_mac l=L nfin=2
*.ends

.subckt TG    vin en_p en_n vout vdd vss
    mp    vin en_p vout vdd  pch_svt_mac l=L nfin=3  **nfin=1 for ver1
    mn    vin en_n vout vss  nch_svt_mac l=L nfin=3  **nfin=1 for ver1
.ends

.subckt NAND    vin1 vin2 vout vdd vss
    mp1    vout vin1 vdd vdd  pch_svt_mac l=L nfin=3  **nfin=1 for ver1
    mp2    vout vin2 vdd vdd  pch_svt_mac l=L nfin=3  **nfin=1 for ver1
    mn1    vout vin1 v1  vss  nch_svt_mac l=L nfin=6  **nfin=2 for ver1
    mn2    v1   vin2 vss vss  nch_svt_mac l=L nfin=6  **nfin=2 for ver1
.ends

.subckt TRI_INV    vin en_p en_n vout vdd vss
    mp1    v1   vin  vdd vdd  pch_svt_mac l=L nfin=1
    mp2    vout en_p v1  vdd  pch_svt_mac l=L nfin=1
    mn1    vout en_n v2  vss  nch_svt_mac l=L nfin=1
    mn2    v2   vin  vss vss  nch_svt_mac l=L nfin=1
.ends

.subckt DFF    rst_b d clk q q_b vdd vss
    X01_nand  d   rst_b v1    vdd vss      NAND
    X02_inv   clk clk_b vdd   vss          INV_N1
    X03_tg    v1  clk   clk_b v2  vdd vss  TG
    X04_inv   v2  v3    vdd   vss          INV_N1
    X05_tri   v3  clk_b clk   v2  vdd vss  TRI_INV
    X06_tg    v3  clk_b clk   v4  vdd vss  TG
    X07_inv   v4  q_b   vdd   vss          INV_N1  **INV_N2 for ver.1
    X08_inv   v4  v5    vdd   vss          INV_N1
    X09_tri   v5  clk   clk_b v4  vdd vss  TRI_INV
    X10_inv   v5  q     vdd   vss          INV_N1  **INV_N2 for ver.1
.ends

** D register circuit
Xdff  rst_b d   clk q   q_b vdd vss  DFF

** 2 unit size inverters as loading (for each output)
Xld1  q_b n1 vdd vss  INV_LD
Xld2  q_b n2 vdd vss  INV_LD
Xld3  q   n3 vdd vss  INV_LD
Xld4  q   n4 vdd vss  INV_LD

******************* Power declaration *******************
Vgnd  vss 0  0
Vvdd  vdd 0  VDD

******************* Input & Analysis *******************
Vvin    d     vss  pulse(0 VDD 1.3n 0.1n 0.1n 1.2n 2.5n)
Vclk    clk   vss  pulse(0 VDD 0.0n 0.1n 0.1n 0.8n 2.0n)
Vrst_b  rst_b vss  VDD

** Simulation
.tran 10p 15n

** Setup time & Clock-to-Q propagation delay
.measure tran t_setup_r1  TRIG V(d)   VAL='0.5*VDD' RISE=1  TARG V(Xdff.v3) VAL='0.5*VDD' RISE=1
.measure tran t_pcq_r1    TRIG V(clk) VAL='0.5*VDD' RISE=2  TARG V(q)       VAL='0.5*VDD' RISE=1
.measure tran t_setup_r0  TRIG V(d)   VAL='0.5*VDD' FALL=2  TARG V(Xdff.v3) VAL='0.5*VDD' FALL=2
.measure tran t_pcq_r0    TRIG V(clk) VAL='0.5*VDD' RISE=4  TARG V(q)       VAL='0.5*VDD' FALL=1

.end
