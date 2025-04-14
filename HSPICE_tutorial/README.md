# HSPICE Tutorial

### **# YOU NEED TO KNOW FIRST**
- 檔案中的第一行固定視為註解；檔案結尾要加上`.end`。
- 在 `*` 或 `$` 後面的字後方為註解。
- HSPICE 不區分大小寫字體。
- 在關鍵字後方緊接著變數的命名，不需要空格。</br>
  **E.g.,** 建立一個叫 `abc` 的 MOSFET : `mabc` ( `m` 是宣告 MOSFET 的關鍵字)
- **Terminal Command**:
    ```shell
    hspice -i <testbench_file.sp> -o <output_file.lis>  # Run HSPICE simulation
    wv &  # Open waveview
    ```
    輸出檔案也可以空著。

### **# Quick View**
- **Declare MOSFET:**</br>
    ```
    m<name>  <drain>  <gate>  <source>  <body>  <type>  l=<length>  w=<width>
    ```
    - Advanced settings: `ad=<drain_area>  as=<source_area>  pd=<drain_perimeter>  ps=<source_perimeter>`
- **Declare Capacitor:**</br>
    ```
    C<name>  <node1>  <node2>  <capacitance>
    ```
- **Declare Resistor:**</br>
    ```
    R<name>  <node1>  <node2>  <resistance>
    ```
- **Declare Voltage:**</br>
    ```shell
    # DC Voltage
    V<name>  <node+>  <node->  <voltage>
    # Pulse Voltage
    V<name>  <node+>  <node->  pulse(<v_high>  <v_low>  <delay>  <t_rise>  <t_fall>  <pulse_width>  <period>)
    # Sinusoidal Voltage
    V<name>  <node+>  <node->  sin(<v_offset>  <v_amp>  <freq>  <t_delay>)
    # PWL Voltage
    V<name>  <node+>  <node->  pwl(<t1> <v1> <t2> <v2> <t3> <v3> ...)
    ```
- **Create Sub-Circuit:**</br>
    ```
    .subckt <name>  <port1>  <port2>  ...
        * circuit description
    .ends
    ```
- **Declare Sub-Circuit:**</br>
    ```
    X<name>  <port1>  <port2>  ... <subckt_name>
    ```
- **Simulation Commands (Analysis Types):**</br>
    There are 3 types of analysis, AC / DC / Transient.
    1. **AC** (= `AC`) :</br>
        Small signal analysis, frequency domain analysis. (not used)
        - Output file: `xxx.ac0`
    2. **DC** (= `DC`) :</br>
        ```
        .dc  <voltage>  <v_init>  <v_end>  <v_step>  sweep  <param>  <param_init>  <param_end>  <param_step>
        ```
        - Output file: `xxx.sw0`
    3. **Trasient** (= `Tran`) :</br>
        ```
        .tran  <resolution>  <run_time>  <uic/ >
        ```
        - `uic` 是使用到 initial condition 時要打的，沒有的話空著就好。
        - Setting initial condition:</br>
            `.ic  V(<subckt_name>.<node>)=<value>`
        - Output file: `xxx.tr0`

- **Measurement:**</br>
    1. **PROBE**:</br>
        ```
        .probe  <analysis_type>  <ob1>  <ob2> ...
        ```
        - 把輸出變量以圖形的形式儲存，部會出現在輸出列表文件中。
        - Analysis type:</br>
            ac = `AC`, dc = `DC`, tran = `Tran`
        - Observation term:</br>
            Voltage = `v(<node>)`,  Current = `i(<node>)`

- **Reference:**</br>
    1. https://hackmd.io/@azoo/hspice_tutorial
    2. https://blog.csdn.net/Tranquil_ovo/article/details/132571282


</br></br>
# Example - DC Analysis
```
.option accurate
.option post
.op
.TEMP 25.0

.protect
.lib '../bulk_32nm.l'TT
.unprotect

.param xvdd = 0.9
.param xvss = 0
.param wp = 64n
.param wn = 64n
.param cycle = 1n
.param simtime = 5n

.subckt inv in out vdd vss
    m1 out in vdd vdd pmos w=wp l=32n
    m2 out in vss vss nmos w=wn l=32n
.ends

xinv_1 input output vdd vss inv
cload  output vss 5f

vvdd  vdd  0  xvdd
vvss  vss  0  xvss

vin  input  0  pulse(xvdd  0  1n  0.1n  0.1n  'cycle * 0.45'  cycle)
.dc  vin  0  0.9  0.01  sweep  wp  100n  1000n  100n

.end
```

### **# Simulator Settings**
- **Code :**
    ```
    .option accurate
    .option post
    .op
    .TEMP 25.0
    ```
- `.option accurate`: 較精準的模擬。
- `.option post`: 輸出波形檔。
- `.op`: 輸出元件工作點於.lis檔。
- `.TEMP 25.0`: 設定環境溫度。

### **# Library Settings**
- **Code :**
    ```
    .protect
    .lib '../bulk_32nm.l'TT
    .unprotect
    ```
- `.protect` --- `.unprotect`: 在這兩個關鍵字之間的檔案資訊不會顯示在.lis檔
- `.lib '../bulk_32nm.l'TT`: 引入模擬所需的library檔(路徑與製程檔放置位置要一致)
- `TT`: Typical-Typical corner (其他: SS, FF, FS, SF)

### **# Parameter Settings**
- **Code :**
    ```
    .param xvdd = 0.9
    .param xvss = 0
    .param wp = 64n
    .param wn = 64n
    .param cycle = 1n
    .param simtime = 5n
    ```
- 就是設置一些變數。

### **# Circuit description**
- **Code :**
    ```
    .subckt inv in out vdd vss
        m1 out in vdd vdd pmos w=wp l=32n
        m2 out in vss vss nmos w=wn l=32n
    .ends

    xinv_1 input output vdd vss inv
    cload  output vss 5f
    ```
- `.subckt <name> <ports>`: 建立子電路
- `mXX <drain> <gate> <source> <body> nmos/pmos w=W l=L`: 呼叫 MOSFET, XX為任意編號。

### **# Power declaration**
- **Code :**
    ```
    vvdd  vdd  0  xvdd
    vvss  vss  0  xvss
    ```

### **# Input declaration**
- **Code :**
    ```
    vin  input  0  pulse(xvdd  0  1n  0.1n  0.1n  'cycle * 0.45'  cycle)
    ```

### **# Analysis setting**
- **Code :**
    ```
    .dc  vin  0  0.9  0.01  sweep  wp  100n  1000n  100n
    ```
