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
.param L     = 16n
.param VDD   = 0.8
.param CYCLE = 0.075n

******************* Circuit description *******************
.subckt INV    vin vout vdd vss  nfin_p=1 nfin_n=1
    mp    vout vin vdd vdd  pch_svt_mac l=L nfin=nfin_p
    mn    vout vin vss vss  nch_svt_mac l=L nfin=nfin_n
.ends

.subckt FO4    vin vout vdd vss
    Xinv1    vin vout vdd vss  INV
    Xinv2    vin vout vdd vss  INV
    Xinv3    vin vout vdd vss  INV
    Xinv4    vin vout vdd vss  INV
.ends

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

.subckt FA    a b ci s_b co_b vdd vss  nfin_A=2 nfin_B=2 nfin_C=3
    ** C_out (without inv) circuit
    mp01    n01 ci co_b vdd  pch_svt_mac l=L nfin=nfin_A
    mp02    vdd a  n01  vdd  pch_svt_mac l=L nfin=nfin_A
    mp03    vdd b  n01  vdd  pch_svt_mac l=L nfin=nfin_A
    mp04    n03 b  co_b vdd  pch_svt_mac l=L nfin=nfin_A
    mp05    vdd a  n03  vdd  pch_svt_mac l=L nfin=nfin_A
    mn01    n02 ci co_b vss  nch_svt_mac l=L nfin=nfin_A
    mn02    vss a  n02  vss  nch_svt_mac l=L nfin=nfin_A
    mn03    vss b  n02  vss  nch_svt_mac l=L nfin=nfin_A
    mn04    n04 b  co_b vss  nch_svt_mac l=L nfin=nfin_A
    mn05    vss a  n04  vss  nch_svt_mac l=L nfin=nfin_A

    ** Sum (without inv) circuit
    mp06    n05 co_b s_b vdd  pch_svt_mac l=L nfin=nfin_B
    mp07    vdd a    n05 vdd  pch_svt_mac l=L nfin=nfin_B
    mp08    vdd b    n05 vdd  pch_svt_mac l=L nfin=nfin_B
    mp09    vdd ci   n05 vdd  pch_svt_mac l=L nfin=nfin_B
    mp10    n08 ci   s_b vdd  pch_svt_mac l=L nfin=nfin_C
    mp11    n07 b    n08 vdd  pch_svt_mac l=L nfin=nfin_C
    mp12    vdd a    n07 vdd  pch_svt_mac l=L nfin=nfin_C
    mn06    n06 co_b s_b vss  nch_svt_mac l=L nfin=nfin_B
    mn07    vss a    n06 vss  nch_svt_mac l=L nfin=nfin_B
    mn08    vss b    n06 vss  nch_svt_mac l=L nfin=nfin_B
    mn09    vss ci   n06 vss  nch_svt_mac l=L nfin=nfin_B
    mn10    n09 ci   s_b vss  nch_svt_mac l=L nfin=nfin_C
    mn11    n10 b    n09 vss  nch_svt_mac l=L nfin=nfin_C
    mn12    vss a    n10 vss  nch_svt_mac l=L nfin=nfin_C
.ends

.subckt RCA_6b    a5 a4 a3 a2 a1 a0 b5 b4 b3 b2 b1 b0 ci s5 s4 s3 s2 s1 s0 co vdd vss
    Xfa0    a0   b0   ci  s0_b co0 vdd vss  FA nfin_A=2  nfin_B=2  nfin_C=3
    Xfa1    a1_b b1_b co0 s1   co1 vdd vss  FA nfin_A=2  nfin_B=2  nfin_C=3
    Xfa2    a2   b2   co1 s2_b co2 vdd vss  FA nfin_A=2  nfin_B=2  nfin_C=3
    Xfa3    a3_b b3_b co2 s3   co3 vdd vss  FA nfin_A=2  nfin_B=2  nfin_C=3
    Xfa4    a4   b4   co3 s4_b co4 vdd vss  FA nfin_A=2  nfin_B=2  nfin_C=3
    Xfa5    a5_b b5_b co4 s5   co  vdd vss  FA nfin_A=2  nfin_B=2  nfin_C=3

    Xinv0   s0_b s0   vdd vss  INV nfin_p=1 nfin_n=1
    Xinv1a  a1   a1_b vdd vss  INV nfin_p=1 nfin_n=1
    Xinv1b  b1   b1_b vdd vss  INV nfin_p=1 nfin_n=1
    Xinv2   s2_b s2   vdd vss  INV nfin_p=1 nfin_n=1
    Xinv3a  a3   a3_b vdd vss  INV nfin_p=1 nfin_n=1
    Xinv3b  b3   b3_b vdd vss  INV nfin_p=1 nfin_n=1
    Xinv4   s4_b s4   vdd vss  INV nfin_p=1 nfin_n=1
    Xinv5a  a5   a5_b vdd vss  INV nfin_p=1 nfin_n=1
    Xinv5b  b5   b5_b vdd vss  INV nfin_p=1 nfin_n=1
.ends

** DFF before input inverters
Xdff_in_a0    clk a0_b_d a0_b_q vdd vss  DFF
Xdff_in_b0    clk b0_b_d b0_b_q vdd vss  DFF
Xdff_in_a1    clk a1_b_d a1_b_q vdd vss  DFF
Xdff_in_b1    clk b1_b_d b1_b_q vdd vss  DFF
Xdff_in_a2    clk a2_b_d a2_b_q vdd vss  DFF
Xdff_in_b2    clk b2_b_d b2_b_q vdd vss  DFF
Xdff_in_a3    clk a3_b_d a3_b_q vdd vss  DFF
Xdff_in_b3    clk b3_b_d b3_b_q vdd vss  DFF
Xdff_in_a4    clk a4_b_d a4_b_q vdd vss  DFF
Xdff_in_b4    clk b4_b_d b4_b_q vdd vss  DFF
Xdff_in_a5    clk a5_b_d a5_b_q vdd vss  DFF
Xdff_in_b5    clk b5_b_d b5_b_q vdd vss  DFF
Xdff_in_ci    clk ci_b_d ci_b_q vdd vss  DFF

** Unit size inverters for input signals
Xinv_in_a0    a0_b_q a0 vdd vss  INV
Xinv_in_b0    b0_b_q b0 vdd vss  INV
Xinv_in_a1    a1_b_q a1 vdd vss  INV
Xinv_in_b1    b1_b_q b1 vdd vss  INV
Xinv_in_a2    a2_b_q a2 vdd vss  INV
Xinv_in_b2    b2_b_q b2 vdd vss  INV
Xinv_in_a3    a3_b_q a3 vdd vss  INV
Xinv_in_b3    b3_b_q b3 vdd vss  INV
Xinv_in_a4    a4_b_q a4 vdd vss  INV
Xinv_in_b4    b4_b_q b4 vdd vss  INV
Xinv_in_a5    a5_b_q a5 vdd vss  INV
Xinv_in_b5    b5_b_q b5 vdd vss  INV
Xinv_in_ci    ci_b_q ci vdd vss  INV

** Ripple-Carry Adder 6-bit
Xrca    a5 a4 a3 a2 a1 a0 b5 b4 b3 b2 b1 b0 ci s5 s4 s3 s2 s1 s0 co vdd vss  RCA_6b

** Output DFFs
Xdff_out_s0    clk s0 s0_q vdd vss  DFF
Xdff_out_s1    clk s1 s1_q vdd vss  DFF
Xdff_out_s2    clk s2 s2_q vdd vss  DFF
Xdff_out_s3    clk s3 s3_q vdd vss  DFF
Xdff_out_s4    clk s4 s4_q vdd vss  DFF
Xdff_out_s5    clk s5 s5_q vdd vss  DFF
Xdff_out_co    clk co co_q vdd vss  DFF

** Output FO4 loads
Xfo4_out_s0    s0 s0_b vdd vss  FO4
Xfo4_out_s1    s1 s1_b vdd vss  FO4
Xfo4_out_s2    s2 s2_b vdd vss  FO4
Xfo4_out_s3    s3 s3_b vdd vss  FO4
Xfo4_out_s4    s4 s4_b vdd vss  FO4
Xfo4_out_s5    s5 s5_b vdd vss  FO4
Xfo4_out_co    co co_b vdd vss  FO4

******************* Power declaration *******************
Vgnd  vss 0  0
Vvdd  vdd 0  VDD

******************* Input & Analysis *******************
Va5_b    a5_b_d vss  VDD
Va4_b    a4_b_d vss  VDD
Va3_b    a3_b_d vss  VDD
Va2_b    a2_b_d vss  VDD
Va1_b    a1_b_d vss  VDD
Va0_b    a0_b_d vss  VDD
Vb5_b    b5_b_d vss  0
Vb4_b    b4_b_d vss  0
Vb3_b    b3_b_d vss  0
Vb2_b    b2_b_d vss  0
Vb1_b    b1_b_d vss  0
Vb0_b    b0_b_d vss  0
Vci_b    ci_b_d vss  VDD
Vclk     clk    vss  pwl(0n 0 0.01n VDD 0.0325n VDD 0.0425n 0)

** Simulation
.tran 5p 10ns

** Power measurement
.meas tran Leak_power   AVG POWER FROM=0.1n

.end
