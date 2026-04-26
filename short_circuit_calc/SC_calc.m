
%% Windfarm Short Circuit Analysis - Multi-Path Topology & Power Distribution

% 1. Symbolen voor onbekenden (Grid & Compensatie)
syms S_sc_onshore L_shore L_substation Z_turbine S_grid ST1 ST2 ST3 ST4 ST5
syms Z1 Z2 Z3 Z4 Z5 Z6 Z7 Z8 Z9 Z10 Z11 Z12 Z13 Z14 Z15 Zgrid_0 Zgrid
syms ZL1 ZL2 ZL3 ZL4 ZL5 ZL6 ZL7 ZL8 R X
syms ZTB1 ZTB2 ZTA38a ZTA38b ZTA37 Z_380kV Z_66kV Zeq1 Zeq2 ZR1 ZR2 ZR Sbase Ubase Ubase2 
Sbase = 100e6 %[output:25e4c803]

Zgrid_0=Zgrid * 10  %[output:20269858]
X = R*20   %[output:5e860e2e]
Zgrid = X*j + R %[output:2f616fae]
Ugrid = 380e3 %[output:46123620]
Ubase = Ugrid %[output:251f82c6]
Ubase2 = 66e3 %[output:3c192fba]
f = 50;                      % Frequentie [Hz]
omega = 2 * pi * f %[output:73b7d78c]

%%Grid parameters calculations
S_grid = 20e9 %[output:1fdf1a52]
X_R_ratio = 20                                                                                                                                                          %[output:2721ca17]
Z_grid = Ugrid^2 / S_grid %[output:792e10d7]
R_grid = sqrt(Z_grid^2 / (1 + X_R_ratio^2)) %[output:3da1dc24]
X_grid = X_R_ratio*R_grid*j %[output:61d154de]

Z_grid_pu = (R_grid + X_grid) * (Sbase / Ubase2^2) %[output:7c219cb6]


%Grid zero sequence impedance
X0_X1_grid_ratio = 4 %[output:3eb6d533]
Z0_grid_pu = Z_grid_pu * X0_X1_grid_ratio %[output:53e05f78]

%%\
S_T_B1 = 600e6;
S_T_B2 = S_T_B1;
S_T_A = 900e6;
S_T_Btb1 = 450e6;
S_T_Btb2 = S_T_Btb1;
% ST3 = 450e6
% ST4 = 450e6
% ST5 = 225e6
S_T_shore = 1000e6;
U_690 = 690;
U_66kv = 66e3;
U_220kV = 220e3;
U_380kV = 380e3;
% Z_grid = ((380e3)^2/S_grid)*(Sbase/Ubase^2)

% Transfo 
uk_trafo_transport = 0.14;             % Kortsluitspanning trafo (14%)
X0_X1_T_ratio = 2.4 %[output:24baec0a]

Z1_TB1 = uk_trafo_transport*(U_66kv^2/S_T_B1)*j %[output:881934c8]
Z1_TB2 = uk_trafo_transport* (U_66kv^2/S_T_B2)*j %[output:90442a2c]
% ZTA38a = uk_trafo* (U_66kv^2/ST3)*j
% ZTA38b = uk_trafo*(U_66kv^2/ST4)*j
% ZTA37 = uk_trafo* (U_66kv^2/ST5)*j
Z1_TB3 = uk_trafo_transport*(U_380kV^2 / S_T_shore)*j %[output:4ccd0c98]
Z1_TA3 = uk_trafo_transport*(U_380kV^2 / S_T_shore)*j %[output:5f0e66e1]
Z1_TA = uk_trafo_transport*(U_66kv^2 / S_T_A)*j;

uk_trafo_turbine = 0.025;
Z1_T_Btb1 = uk_trafo_turbine*(U_66kv^2 / S_T_Btb1) %[output:50432b69]
Z1_T_Btb2 = uk_trafo_turbine*(U_66kv^2 / S_T_Btb2) %[output:6111e463]
Z1_T_Atb = uk_trafo_turbine*(U_66kv^2 / S_T_A) %[output:406676ac]


Z1_TB1_pu = Z1_TB1*( Sbase/U_66kv^2 )  %[output:0499a215]
Z0_TB1_pu = Z1_TB1_pu* X0_X1_T_ratio %[output:9a6ca00e]

Z1_TB2_pu = Z1_TB2*( Sbase/U_66kv^2 )   %[output:72a7a891]
Z0_TB2_pu = Z1_TB2_pu* X0_X1_T_ratio %[output:2cbaa86d]

Z1_TB3_pu = Z1_TB3*( Sbase/U_380kV^2) %[output:6642cb70]
Z0_TB3_pu = Z1_TB3_pu*X0_X1_T_ratio %[output:72dad80f]

Z1_T_Btb1_pu = Z1_T_Btb1*(Sbase / U_66kv^2) %[output:0aaf1166]
Z0_T_Btb1_pu = Z1_T_Btb1_pu* X0_X1_T_ratio;

Z1_T_Btb2_pu = Z1_T_Btb2*(Sbase / U_66kv^2) %[output:81e8e5f2]
Z0_T_Btb2_pu = Z1_T_Btb2_pu* X0_X1_T_ratio;

Z1_TA_pu = Z1_TA* ( Sbase/U_66kv^2) %[output:9040e91d]
Z0_TA_pu = Z1_TA_pu* X0_X1_T_ratio %[output:7f3ecd22]

Z1_TA3_pu = Z1_TA3*( Sbase/U_380kV^2) %[output:37695c95]
Z0_TA3_pu = Z1_TA3_pu* X0_X1_T_ratio %[output:329d66bb]

Z1_T_Atb_pu = Z1_T_Atb*( Sbase/U_66kv^2) %[output:35148a5c]
Z0_T_Atb_pu = Z1_T_Atb_pu*X0_X1_T_ratio %[output:91896ba5]

%Grounding transformer
Z0_ground = j*1 %the impedance of this ground transformer is very low. %[output:7efbdb58]

% Export Cables 
length = 60 %The export cable length is 60km %[output:52bbb9d6]
% R_km = 0.1  %Ohm/km
% L_km = 0.39 %mH/km
% C_km = 0.18 %uF/km  %Just mock number, could be different later on

% Z_line = R_km*length + j*(omega*L_km*length*10^-3) 

R1_km = 0.0612 %Ohm/km %[output:6ef11370]
Z1_L_km = j*0.1545 %Ohm/km %[output:27dc3d7d]

R0_km = 0.1968 %[output:7f689431]
Z0_L_km = j*0.1322 %[output:4288de9d]

Z1_SM_line = length * (R1_km + Z1_L_km) %[output:6aa7f0c7]

Z1_LSM1_pu = Z1_SM_line * (Sbase/Ubase^2) %[output:01213e93]
Z1_LSM1a_pu = Z1_LSM1_pu/2 %[output:2275964a]
Z1_LSM1b_pu = Z1_LSM1_pu/2 %[output:296e874c]

Z1_LSM2_pu = Z1_SM_line * (Sbase/Ubase^2) %[output:617e640f]
Z1_LSM3_pu = Z1_SM_line * (Sbase/Ubase^2) %[output:972a33b3]

% xo_x1_ratio_submarine = 1 %(could be from 1 to 1.5 because submarine cables have good return path via water and cable sheath)
% Z0_Le1_pu = ZLSM1b_pu * xo_x1_ratio_submarine
% Z0_Le1_1_pu = Z0_Le1_pu/2 * xo_x1_ratio_submarine
% Z0_Le1_2_pu = Z0_Le1_pu/2 * xo_x1_ratio_submarine
% Z0_Le2_pu = ZLSM2_pu * xo_x1_ratio_submarine
% Z0_Le3_pu = ZLSM3_pu * xo_x1_ratio_submarine

Z0_SM_line = length * (R0_km + Z0_L_km) %[output:6cfeaf0a]

Z0_LSM1_pu = Z0_SM_line * (Sbase/Ubase^2) %[output:4704df9f]
Z0_LSM1a_pu = Z0_LSM1_pu/2 %[output:9e5299ba]
Z0_LSM1b_pu = Z0_LSM1_pu/2 %[output:325fa3c6]

Z0_LSM2_pu = Z0_SM_line * (Sbase/Ubase^2) %[output:48547e02]
Z0_LSM3_pu = Z0_SM_line * (Sbase/Ubase^2) %[output:07057f12]


%%On shore overhead transmission cables
R1_Le_ON = 0.0209;      % ohm/km
R0_Le_ON = 0.3030;      % from RT_OPAL parameters

L1_Le_ON = 0.8467e-3;   %H/km
L0_Le_ON = 3.1544e-3;   %H/km

C1_Le_ON = 0.0137e-6;   % F/km
C0_Le_ON = 0.0084e-6;   % from RT_OPAL parameters

length_ON = 150; %km

comp = 1/(C1_Le_ON*length_ON*100*pi) %[output:63e8e86e]
(comp / 100*pi) / length_ON %[output:6852e127]

Z1_ON_B = R1_Le_ON*length_ON + j*L1_Le_ON*100*pi %[output:98017ce2]
Z0_ON_B = R0_Le_ON*length_ON + j*L0_Le_ON*100*pi %[output:6a662091]

Z1_ON_A = R1_Le_ON*length_ON + j*L1_Le_ON*100*pi %[output:83a5cf02]
Z0_ON_A = R0_Le_ON*length_ON + j*L0_Le_ON*100*pi %[output:8b017d34]

Z1_ON_B_pu = Z1_ON_B * (Sbase / Ubase^2) %[output:3a490f70]
Z0_ON_B_pu = Z0_ON_B * (Sbase / Ubase^2) %[output:88a96e0b]

Z1_ON_A_pu = Z1_ON_A * (Sbase / Ubase^2) %[output:8058a2e5]
Z0_ON_A_pu = Z0_ON_A * (Sbase / Ubase^2) %[output:981da208]


%Feeder line zero sequence impedance
X0_X1_L_ratio = 1.5 %[output:615deaab]

%%Feeder equivalent parallel impedance
Z1_fLB1 = 0.244686 + j*0.153423 %[output:19cbe8f7]
Z1_fLB2 = 0.20829138 + j*0.13060804 %[output:8b24bcbe]
Z1_fLA38a = 0.3514672 + j*0.220373 %[output:9352273c]
Z1_fLA38b = 0.408561332 + j*0.2561899 %[output:841ebe2a]
Z1_fLA37 = 0.43514837 + j*0.27285307 %[output:92377250]


Z1_fLB1_pu = Z1_fLB1 * (Sbase / Ubase2^2) %[output:52a59b09]
Z0_fLB1_pu = Z1_fLB1_pu*X0_X1_L_ratio %[output:8b20d394]

Z1_fLB2_pu = Z1_fLB2 * (Sbase / Ubase2^2) %[output:72b0d3e1]
Z0_fLB2_pu = Z1_fLB2_pu*X0_X1_L_ratio %[output:73e95482]

Z1_fLA38a_pu = Z1_fLA38a * (Sbase / Ubase2^2) %[output:1fc1cfc5]
Z0_fLA38a_pu = Z1_fLA38a_pu * X0_X1_L_ratio %[output:7a73bf85]

Z1_fLA38b_pu = Z1_fLA38b * (Sbase / Ubase2^2) %[output:058546b6]
Z0_fLA38b_pu = Z1_fLA38b_pu * X0_X1_L_ratio %[output:2c879ef5]

Z1_fLA37_pu = Z1_fLA37 * (Sbase / Ubase2^2) %[output:9a3a7bae]
Z0_fLA37_pu = Z1_fLA37_pu * X0_X1_L_ratio %[output:9b22189f]


Z1_lfA_pu = (Z1_fLA38a_pu^-1 + Z1_fLA38b_pu^-1 + Z1_fLA37_pu^-1)^-1 %[output:874da711]
Z0_lfA_pu = Z1_lfA_pu*X0_X1_L_ratio %[output:5af88a9f]


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":17.3}
%---
%[output:25e4c803]
%   data: {"dataType":"textualVariable","outputData":{"name":"Sbase","value":"100000000"}}
%---
%[output:20269858]
%   data: {"dataType":"symbolic","outputData":{"name":"Zgrid_0","value":"10\\,\\mathrm{Zgrid}"}}
%---
%[output:5e860e2e]
%   data: {"dataType":"symbolic","outputData":{"name":"X","value":"20\\,R"}}
%---
%[output:2f616fae]
%   data: {"dataType":"symbolic","outputData":{"name":"Zgrid","value":"R\\,{\\left(1+20\\,\\mathrm{i}\\right)}"}}
%---
%[output:46123620]
%   data: {"dataType":"textualVariable","outputData":{"name":"Ugrid","value":"380000"}}
%---
%[output:251f82c6]
%   data: {"dataType":"textualVariable","outputData":{"name":"Ubase","value":"380000"}}
%---
%[output:3c192fba]
%   data: {"dataType":"textualVariable","outputData":{"name":"Ubase2","value":"66000"}}
%---
%[output:73b7d78c]
%   data: {"dataType":"textualVariable","outputData":{"name":"omega","value":"314.1593"}}
%---
%[output:1fdf1a52]
%   data: {"dataType":"textualVariable","outputData":{"name":"S_grid","value":"2.0000e+10"}}
%---
%[output:2721ca17]
%   data: {"dataType":"textualVariable","outputData":{"name":"X_R_ratio","value":"20"}}
%---
%[output:792e10d7]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_grid","value":"7.2200"}}
%---
%[output:3da1dc24]
%   data: {"dataType":"textualVariable","outputData":{"name":"R_grid","value":"0.3605"}}
%---
%[output:61d154de]
%   data: {"dataType":"textualVariable","outputData":{"name":"X_grid","value":"0.0000 + 7.2110i"}}
%---
%[output:7c219cb6]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_grid_pu","value":"0.0083 + 0.1655i"}}
%---
%[output:3eb6d533]
%   data: {"dataType":"textualVariable","outputData":{"name":"X0_X1_grid_ratio","value":"4"}}
%---
%[output:53e05f78]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_grid_pu","value":"0.0331 + 0.6622i"}}
%---
%[output:24baec0a]
%   data: {"dataType":"textualVariable","outputData":{"name":"X0_X1_T_ratio","value":"2.4000"}}
%---
%[output:881934c8]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_TB1","value":"0.0000 + 1.0164i"}}
%---
%[output:90442a2c]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_TB2","value":"0.0000 + 1.0164i"}}
%---
%[output:4ccd0c98]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_TB3","value":"0.0000 +20.2160i"}}
%---
%[output:5f0e66e1]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_TA3","value":"0.0000 +20.2160i"}}
%---
%[output:50432b69]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Btb1","value":"0.2420"}}
%---
%[output:6111e463]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Btb2","value":"0.2420"}}
%---
%[output:406676ac]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Atb","value":"0.1210"}}
%---
%[output:0499a215]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_TB1_pu","value":"0.0000 + 0.0233i"}}
%---
%[output:9a6ca00e]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TB1_pu","value":"0.0000 + 0.0560i"}}
%---
%[output:72a7a891]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_TB2_pu","value":"0.0000 + 0.0233i"}}
%---
%[output:2cbaa86d]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TB2_pu","value":"0.0000 + 0.0560i"}}
%---
%[output:6642cb70]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_TB3_pu","value":"0.0000 + 0.0140i"}}
%---
%[output:72dad80f]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TB3_pu","value":"0.0000 + 0.0336i"}}
%---
%[output:0aaf1166]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Btb1_pu","value":"0.0056"}}
%---
%[output:81e8e5f2]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Btb2_pu","value":"0.0056"}}
%---
%[output:9040e91d]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_TA_pu","value":"0.0000 + 0.0156i"}}
%---
%[output:7f3ecd22]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TA_pu","value":"0.0000 + 0.0373i"}}
%---
%[output:37695c95]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_TA3_pu","value":"0.0000 + 0.0140i"}}
%---
%[output:329d66bb]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TA3_pu","value":"0.0000 + 0.0336i"}}
%---
%[output:35148a5c]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Atb_pu","value":"0.0028"}}
%---
%[output:91896ba5]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_T_Atb_pu","value":"0.0067"}}
%---
%[output:7efbdb58]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_ground","value":"0.0000 + 1.0000i"}}
%---
%[output:52bbb9d6]
%   data: {"dataType":"textualVariable","outputData":{"name":"length","value":"60"}}
%---
%[output:6ef11370]
%   data: {"dataType":"textualVariable","outputData":{"name":"R1_km","value":"0.0612"}}
%---
%[output:27dc3d7d]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_L_km","value":"0.0000 + 0.1545i"}}
%---
%[output:7f689431]
%   data: {"dataType":"textualVariable","outputData":{"name":"R0_km","value":"0.1968"}}
%---
%[output:4288de9d]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_L_km","value":"0.0000 + 0.1322i"}}
%---
%[output:6aa7f0c7]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_SM_line","value":"3.6720 + 9.2700i"}}
%---
%[output:01213e93]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_LSM1_pu","value":"0.0025 + 0.0064i"}}
%---
%[output:2275964a]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_LSM1a_pu","value":"0.0013 + 0.0032i"}}
%---
%[output:296e874c]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_LSM1b_pu","value":"0.0013 + 0.0032i"}}
%---
%[output:617e640f]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_LSM2_pu","value":"0.0025 + 0.0064i"}}
%---
%[output:972a33b3]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_LSM3_pu","value":"0.0025 + 0.0064i"}}
%---
%[output:6cfeaf0a]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_SM_line","value":"11.8080 + 7.9320i"}}
%---
%[output:4704df9f]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_LSM1_pu","value":"0.0082 + 0.0055i"}}
%---
%[output:9e5299ba]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_LSM1a_pu","value":"0.0041 + 0.0027i"}}
%---
%[output:325fa3c6]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_LSM1b_pu","value":"0.0041 + 0.0027i"}}
%---
%[output:48547e02]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_LSM2_pu","value":"0.0082 + 0.0055i"}}
%---
%[output:07057f12]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_LSM3_pu","value":"0.0082 + 0.0055i"}}
%---
%[output:63e8e86e]
%   data: {"dataType":"textualVariable","outputData":{"name":"comp","value":"1.5490e+03"}}
%---
%[output:6852e127]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.3244"}}
%---
%[output:98017ce2]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_ON_B","value":"3.1350 + 0.2660i"}}
%---
%[output:6a662091]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_ON_B","value":"45.4500 + 0.9910i"}}
%---
%[output:83a5cf02]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_ON_A","value":"3.1350 + 0.2660i"}}
%---
%[output:8b017d34]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_ON_A","value":"45.4500 + 0.9910i"}}
%---
%[output:3a490f70]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_ON_B_pu","value":"0.0022 + 0.0002i"}}
%---
%[output:88a96e0b]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_ON_B_pu","value":"0.0315 + 0.0007i"}}
%---
%[output:8058a2e5]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_ON_A_pu","value":"0.0022 + 0.0002i"}}
%---
%[output:981da208]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_ON_A_pu","value":"0.0315 + 0.0007i"}}
%---
%[output:615deaab]
%   data: {"dataType":"textualVariable","outputData":{"name":"X0_X1_L_ratio","value":"1.5000"}}
%---
%[output:19cbe8f7]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLB1","value":"0.2447 + 0.1534i"}}
%---
%[output:8b24bcbe]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLB2","value":"0.2083 + 0.1306i"}}
%---
%[output:9352273c]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLA38a","value":"0.3515 + 0.2204i"}}
%---
%[output:841ebe2a]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLA38b","value":"0.4086 + 0.2562i"}}
%---
%[output:92377250]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLA37","value":"0.4351 + 0.2729i"}}
%---
%[output:52a59b09]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLB1_pu","value":"0.0056 + 0.0035i"}}
%---
%[output:8b20d394]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_fLB1_pu","value":"0.0084 + 0.0053i"}}
%---
%[output:72b0d3e1]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLB2_pu","value":"0.0048 + 0.0030i"}}
%---
%[output:73e95482]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_fLB2_pu","value":"0.0072 + 0.0045i"}}
%---
%[output:1fc1cfc5]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLA38a_pu","value":"0.0081 + 0.0051i"}}
%---
%[output:7a73bf85]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_fLA38a_pu","value":"0.0121 + 0.0076i"}}
%---
%[output:058546b6]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLA38b_pu","value":"0.0094 + 0.0059i"}}
%---
%[output:2c879ef5]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_fLA38b_pu","value":"0.0141 + 0.0088i"}}
%---
%[output:9a3a7bae]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_fLA37_pu","value":"0.0100 + 0.0063i"}}
%---
%[output:9b22189f]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_fLA37_pu","value":"0.0150 + 0.0094i"}}
%---
%[output:874da711]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_lfA_pu","value":"0.0030 + 0.0019i"}}
%---
%[output:5af88a9f]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_lfA_pu","value":"0.0045 + 0.0028i"}}
%---
