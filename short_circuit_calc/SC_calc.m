
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
S_T_B1 = 600e6; %[output:24baec0a]
S_T_B2 = S_T_B1; %[output:881934c8]
S_T_A = 900e6; %[output:881934c8]
S_T_Btb1 = 450e6;
S_T_Btb2 = S_T_Btb1;
% ST3 = 450e6 %[output:8c903fb5]
% ST4 = 450e6 %[output:0a257361]
% ST5 = 225e6 %[output:49622d72]
S_T_shore = 1000e6;
U_690 = 690;
U_66kv = 66e3; %[output:90442a2c]
U_220kV = 220e3;
U_380kV = 380e3; %[output:4ccd0c98]
% Z_grid = ((380e3)^2/S_grid)*(Sbase/Ubase^2)

% Transfo 
uk_trafo_transport = 0.14;             % Kortsluitspanning trafo (14%)
ZTB1 = uk_trafo_transport*(U_66kv^2/S_T_B1)*j %[output:5f0e66e1]
ZTB2 = uk_trafo_transport* (U_66kv^2/S_T_B2)*j %[output:50432b69]
% ZTA38a = uk_trafo* (U_66kv^2/ST3)*j %[output:984046ea]
% ZTA38b = uk_trafo*(U_66kv^2/ST4)*j %[output:8806d3bb]
% ZTA37 = uk_trafo* (U_66kv^2/ST5)*j %[output:02ac021b]
ZTB_shore = uk_trafo_transport*(U_380kV^2 / S_T_shore)*j
ZTA_shore = uk_trafo_transport*(U_380kV^2 / S_T_shore)*j
ZTA = uk_trafo_transport*(U_66kv^2 / S_T_A)*j;

uk_trafo_turbine = 0.025;
Z_T_Btb1 = uk_trafo_turbine*(U_66kv^2 / S_T_Btb1)
Z_T_Btb2 = uk_trafo_turbine*(U_66kv^2 / S_T_Btb2)


ZTB1_pu = ZTB1*( Sbase/U_66kv^2 )  %[output:6111e463]
ZTB2_pu = ZTB2*( Sbase/U_66kv^2 )   %[output:406676ac]
ZTB_shore_pu = ZTB3*( Sbase/U_380kV^2)

Z_T_Btb1_pu = Z_T_Btb1*(Sbase / U_66kv^2)
Z_T_Btb2_pu = Z_T_Btb2*(Sbase / U_66kv^2)

ZTA_shore_pu = ZTA_shore*( Sbase/U_380kV^2)

% ZTA38a_pu = ZTA38a*( Sbase/Ubase2^2 )  %[output:0e36b99a]
% ZTA38b_pu = ZTA38b*( Sbase/Ubase2^2 )  %[output:32b0c49c]
% ZTA37_pu = ZTA37*( Sbase/Ubase2^2 ) %[output:1621f991]

%Transformer zero sequence parameter
X0_X1_T_ratio = 2.4 %[output:0499a215]

Z0_TB1_pu = ZTB1_pu* X0_X1_T_ratio %[output:9a6ca00e]
Z0_TB2_pu = ZTB2_pu* X0_X1_T_ratio %[output:72a7a891]
% Z0_TA38a_pu = ZTA38a_pu* X0_X1_T_ratio %[output:7e5f9e24]
% Z0_TA38b_pu = ZTA38b_pu* X0_X1_T_ratio %[output:87c18141]
% Z0_TA37_pu = ZTA37_pu* X0_X1_T_ratio %[output:02197d08]

Z0_TB_shore_pu = ZTB_shore_pu* X0_X1_T_ratio
Z0_TA_pu = ZTA_pu* X0_X1_T_ratio

Z0_T_Btb1_pu = Z_T_Btb1_pu* X0_X1_T_ratio;
Z0_T_Btb2_pu = Z_T_Btb2_pu* X0_X1_T_ratio;
% Export Cables 
length = 60 %The export cable length is 60km %[output:2cbaa86d]
% R_km = 0.1  %Ohm/km %[output:30a79469]
% L_km = 0.39 %mH/km %[output:52061116]
% C_km = 0.18 %uF/km  %Just mock number, could be different later on %[output:6fe428bf]

% Z_line = R_km*length + j*(omega*L_km*length*10^-3)  %[output:2d75037d]

R1_km = 0.0612 %Ohm/km
Z1_L_km = j*0.1545 %Ohm/km

R0_km = 0.1968
Z0_L_km = j*0.1322

Z1_SM_line = length * (R1_km + Z1_L_km)

Z1_LSM1_pu = Z1_SM_line * (Sbase/Ubase^2) %[output:424b1f03]
Z1_LSM1a_pu = Z1_LSM1b_pu/2 %[output:5435ed8d]
Z1_LSM1b_pu = Z1_LSM1b_pu/2 %[output:6cb383a7]

Z1_LSM2_pu = Z1_SM_line * (Sbase/Ubase^2) %[output:864d84e6]
Z1_LSM3_pu = Z1_SM_line * (Sbase/Ubase^2) %[output:4c0c949c]

% xo_x1_ratio_submarine = 1 %(could be from 1 to 1.5 because submarine cables have good return path via water and cable sheath) %[output:1d9c9443]
% Z0_Le1_pu = ZLSM1b_pu * xo_x1_ratio_submarine %[output:65de1136]
% Z0_Le1_1_pu = Z0_Le1_pu/2 * xo_x1_ratio_submarine %[output:6bb1159d]
% Z0_Le1_2_pu = Z0_Le1_pu/2 * xo_x1_ratio_submarine %[output:29db49c3]
% Z0_Le2_pu = ZLSM2_pu * xo_x1_ratio_submarine %[output:1e768a8f]
% Z0_Le3_pu = ZLSM3_pu * xo_x1_ratio_submarine %[output:08d12e67]

Z0_SM_line = length * (R0_km + Z0_L_km)

Z0_LSM1_pu = Z0_SM_line * (Sbase/Ubase^2) %[output:424b1f03]
Z0_LSM1a_pu = Z0_LSM1b_pu/2 %[output:5435ed8d]
Z0_LSM1b_pu = Z0_LSM1b_pu/2 %[output:6cb383a7]

Z0_LSM2_pu = Z0_SM_line * (Sbase/Ubase^2) %[output:864d84e6]
Z0_LSM3_pu = Z0_SM_line * (Sbase/Ubase^2) %[output:4c0c949c]


%%On shore overhead transmission cables
R1_Le_ON = 0.0209;      % ohm/km
R0_Le_ON = 0.3030;      % from RT_OPAL parameters

L1_Le_ON = 0.8467e-3;   %H/km
L0_Le_ON = 3.1544e-3;   %H/km

C1_Le_ON = 0.0137e-6;   % F/km
C0_Le_ON = 0.0084e-6;   % from RT_OPAL parameters

length_ON = 150; %km

comp = 1/(C1_Le_ON*length_ON*100*pi) %[output:0b071e2c]
(comp / 100*pi) / length_ON %[output:5d520934]

Z1_ON_B = R1_Le_ON*length_ON + j*L1_Le_ON*100*pi %[output:1dceb1ab]
Z0_ON_B = R0_Le_ON*length_ON + j*L0_Le_ON*100*pi %[output:4ba1a123]

Z1_ON_A = R1_Le_ON*length_ON + j*L1_Le_ON*100*pi %[output:1dceb1ab]
Z0_ON_A = R0_Le_ON*length_ON + j*L0_Le_ON*100*pi %[output:4ba1a123]

Z1_ON_B_pu = Z1_ON_B * (Sbase / Ubase^2) %[output:93fbbe05]
Z0_ON_B_pu = Z0_ON_B * (Sbase / Ubase^2) %[output:535c4548]

Z1_ON_A_pu = Z1_ON_A * (Sbase / Ubase^2) %[output:93fbbe05]
Z0_ON_A_pu = Z0_ON_A * (Sbase / Ubase^2) %[output:535c4548]

%%Feeder cables
% ZLf4 = 1 * (Sbase/Ubase2^2)
% ZL5 = 1 * (Sbase/Ubase2^2)
% ZL6 = 1 * (Sbase/Ubase2^2)
% ZL7 = 1 * (Sbase/Ubase2^2)
% ZL8 = 1 * (Sbase/Ubase2^2)

%Feeder line zero sequence impedance
X0_X1_L_ratio = 3 %[output:3dca68af]


%% --- SYSTEEM PARAMETERS & VERMOGENS --- w
V_66 = 66000;                % Offshore spanning [V]
V_380 = 380000;              % Onshore spanning [V]

% Vermogensverdeling per Zone [MW]
P_B1  = 450;                 %
P_B2  = 450; 
P_A38a = 225;                 % Zone 3.8 MW
P_A38b = 225; 
P_A37 = 225;                 % Zone 3.7 MW

%%Feeder equivalent parallel impedance
ZfLB1 = 0.244686 + j*0.153423 %[output:5710454c]
ZfLB2 = 0.20829138 + j*0.13060804 %[output:3bbeb79e]
ZfLA38a = 0.3514672 + j*0.220373 %[output:5ade169b]
ZfLA38b = 0.408561332 + j*0.2561899 %[output:24a51edb]
ZfLA37 = 0.43514837 + j*0.27285307 %[output:1a1f8217]


ZfLB1_pu = ZfLB1 * (Sbase / Ubase2^2) %[output:6d773145]
ZfLB2_pu = ZfLB2 * (Sbase / Ubase2^2) %[output:3262f315]

ZfLA38a_pu = ZfLA38a * (Sbase / Ubase2^2) %[output:6d80f36a]
ZfLA38b_pu = ZfLA38b * (Sbase / Ubase2^2) %[output:5a15c653]
ZfLA37_pu = ZfLA37 * (Sbase / Ubase2^2) %[output:2c66f961]

ZlfA = (ZfLA38a_pu^-1 + ZfLA38b_pu^-1 + ZfLA37_pu^-1)^-1


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
%   data: {"dataType":"textualVariable","outputData":{"name":"ST1","value":"600000000"}}
%---
%[output:881934c8]
%   data: {"dataType":"textualVariable","outputData":{"name":"ST2","value":"600000000"}}
%---
%[output:8c903fb5]
%   data: {"dataType":"textualVariable","outputData":{"name":"ST3","value":"450000000"}}
%---
%[output:0a257361]
%   data: {"dataType":"textualVariable","outputData":{"name":"ST4","value":"450000000"}}
%---
%[output:49622d72]
%   data: {"dataType":"textualVariable","outputData":{"name":"ST5","value":"225000000"}}
%---
%[output:90442a2c]
%   data: {"dataType":"textualVariable","outputData":{"name":"U_66kv","value":"66000"}}
%---
%[output:4ccd0c98]
%   data: {"dataType":"textualVariable","outputData":{"name":"U_380kV","value":"380000"}}
%---
%[output:5f0e66e1]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTB1","value":"0.0000 + 1.0164i"}}
%---
%[output:50432b69]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTB2","value":"0.0000 + 1.0164i"}}
%---
%[output:984046ea]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTA38a","value":"0.0000 + 1.3552i"}}
%---
%[output:8806d3bb]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTA38b","value":"0.0000 + 1.3552i"}}
%---
%[output:02ac021b]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTA37","value":"0.0000 + 2.7104i"}}
%---
%[output:6111e463]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTB1_pu","value":"0.0000 + 0.0233i"}}
%---
%[output:406676ac]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTB2_pu","value":"0.0000 + 0.0233i"}}
%---
%[output:0e36b99a]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTA38a_pu","value":"0.0000 + 0.0311i"}}
%---
%[output:32b0c49c]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTA38b_pu","value":"0.0000 + 0.0311i"}}
%---
%[output:1621f991]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZTA37_pu","value":"0.0000 + 0.0622i"}}
%---
%[output:0499a215]
%   data: {"dataType":"textualVariable","outputData":{"name":"X0_X1_T_ratio","value":"2.4000"}}
%---
%[output:9a6ca00e]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TB1_pu","value":"0.0000 + 0.0560i"}}
%---
%[output:72a7a891]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TB2_pu","value":"0.0000 + 0.0560i"}}
%---
%[output:7e5f9e24]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TA38a_pu","value":"0.0000 + 0.0747i"}}
%---
%[output:87c18141]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TA38b_pu","value":"0.0000 + 0.0747i"}}
%---
%[output:02197d08]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TA37_pu","value":"0.0000 + 0.1493i"}}
%---
%[output:2cbaa86d]
%   data: {"dataType":"textualVariable","outputData":{"name":"length","value":"60"}}
%---
%[output:30a79469]
%   data: {"dataType":"textualVariable","outputData":{"name":"R_km","value":"0.1000"}}
%---
%[output:6fe428bf]
%   data: {"dataType":"textualVariable","outputData":{"name":"C_km","value":"0.1800"}}
%---
%[output:52061116]
%   data: {"dataType":"textualVariable","outputData":{"name":"L_km","value":"0.3900"}}
%---
%[output:2d75037d]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_line","value":"6.0000 + 7.3513i"}}
%---
%[output:424b1f03]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZLe1_pu","value":"0.0042 + 0.0051i"}}
%---
%[output:5435ed8d]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZLe1_1_pu","value":"0.0021 + 0.0025i"}}
%---
%[output:6cb383a7]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZLe1_2_pu","value":"0.0021 + 0.0025i"}}
%---
%[output:864d84e6]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZLe2_pu","value":"0.0042 + 0.0051i"}}
%---
%[output:4c0c949c]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZLe3_pu","value":"0.0042 + 0.0051i"}}
%---
%[output:1d9c9443]
%   data: {"dataType":"textualVariable","outputData":{"name":"xo_x1_ratio_submarine","value":"1"}}
%---
%[output:65de1136]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_Le1_pu","value":"0.0042 + 0.0051i"}}
%---
%[output:6bb1159d]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_Le1_1_pu","value":"0.0021 + 0.0025i"}}
%---
%[output:29db49c3]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_Le1_2_pu","value":"0.0021 + 0.0025i"}}
%---
%[output:1e768a8f]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_Le2_pu","value":"0.0042 + 0.0051i"}}
%---
%[output:08d12e67]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_Le3_pu","value":"0.0042 + 0.0051i"}}
%---
%[output:0b071e2c]
%   data: {"dataType":"textualVariable","outputData":{"name":"comp","value":"1.5490e+03"}}
%---
%[output:5d520934]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.3244"}}
%---
%[output:1dceb1ab]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_Le_ON","value":"3.1350 + 0.2660i"}}
%---
%[output:4ba1a123]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_Le_ON","value":"45.4500 + 0.9910i"}}
%---
%[output:93fbbe05]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_Le_ON_pu","value":"0.0022 + 0.0002i"}}
%---
%[output:535c4548]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_Le_ON_pu","value":"0.0315 + 0.0007i"}}
%---
%[output:3dca68af]
%   data: {"dataType":"textualVariable","outputData":{"name":"X0_X1_L_ratio","value":"3"}}
%---
%[output:5710454c]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLB1","value":"0.2447 + 0.1534i"}}
%---
%[output:3bbeb79e]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLB2","value":"0.2083 + 0.1306i"}}
%---
%[output:5ade169b]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLA38a","value":"0.3515 + 0.2204i"}}
%---
%[output:24a51edb]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLA38b","value":"0.4086 + 0.2562i"}}
%---
%[output:1a1f8217]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLA37","value":"0.4351 + 0.2729i"}}
%---
%[output:6d773145]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLB1_pu","value":"0.0056 + 0.0035i"}}
%---
%[output:3262f315]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLB2_pu","value":"0.0048 + 0.0030i"}}
%---
%[output:6d80f36a]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLA38a_pu","value":"0.0081 + 0.0051i"}}
%---
%[output:5a15c653]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLA38b_pu","value":"0.0094 + 0.0059i"}}
%---
%[output:2c66f961]
%   data: {"dataType":"textualVariable","outputData":{"name":"ZfLA37_pu","value":"0.0100 + 0.0063i"}}
%---
%[output:451d89e0]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sB1","value":"9.6800"}}
%---
%[output:90949ce3]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sB2","value":"9.6800"}}
%---
%[output:094255b7]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sA38a","value":"19.3600"}}
%---
%[output:8baf6cc8]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sA38b","value":"19.3600"}}
%---
%[output:789aca9e]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sA37","value":"19.3600"}}
%---
%[output:525045e0]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sB1_pu","value":"0.2222"}}
%---
%[output:964ad76e]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sB2_pu","value":"0.2222"}}
%---
%[output:36c59655]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sA38a_pu","value":"0.4444"}}
%---
%[output:52fb70a7]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sA38b_pu","value":"0.4444"}}
%---
%[output:4cb70c82]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_sA37_pu","value":"0.4444"}}
%---
%[output:6f3e8db3]
%   data: {"dataType":"matrix","outputData":{"columns":15,"exponent":"2","name":"A","rows":15,"type":"complex","value":[["0.0030 - 0.0603i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","2.8897 - 3.5970i","-0.9622 + 1.1789i","-0.9622 + 1.1789i","-0.9622 + 1.1789i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","-0.9622 + 1.1789i","0.9622 - 2.0361i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.4286i","0.0000 + 0.4286i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","-0.9622 + 1.1789i","0.0000 + 0.0000i","0.9622 - 1.8218i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.3214i","0.0000 + 0.3214i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","-0.9622 + 1.1789i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.9622 - 1.3396i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.1607i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.4286i","0.0000 + 0.0000i","0.0000 + 0.0000i","1.2778 - 1.2298i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-1.2778 + 0.8012i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.4286i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","1.5011 - 1.3698i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-1.5011 + 0.9413i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.3214i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.8896 - 0.8792i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-0.8896 + 0.5578i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.3214i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.7653 - 0.8013i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-0.7653 + 0.4799i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.1607i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.7185 - 0.6113i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-0.7185 + 0.4505i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-1.2778 + 0.8012i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","1.3228 - 0.8012i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-1.5011 + 0.9413i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","1.5461 - 0.9413i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-0.8896 + 0.5578i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.9121 - 0.5578i","0.0000 + 0.0000i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-0.7653 + 0.4799i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.7878 - 0.4799i","0.0000 + 0.0000i"],["0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","-0.7185 + 0.4505i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.0000 + 0.0000i","0.7410 - 0.4505i"]]}}
%---
%[output:2c8c48e3]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.0594 + 0.0381i"}}
%---
%[output:13cb3dfd]
%   data: {"dataType":"warning","outputData":{"text":"Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.418887e-19."}}
%---
%[output:031b3826]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"V","rows":15,"type":"complex","value":[["-0.0104 - 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"],["0.0104 + 0.1657i"]]}}
%---
%[output:27322763]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"2.0037"}}
%---
%[output:354023d0]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.0104 + 0.1657i"}}
%---
%[output:8bc5d837]
%   data: {"dataType":"text","outputData":{"text":"Hand calculate the impendace from bus 11 to GND:","truncated":false}}
%---
%[output:34353223]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.0180 + 0.1975i"}}
%---
%[output:33ec8d23]
%   data: {"dataType":"warning","outputData":{"text":"Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  2.418887e-19."}}
%---
%[output:3633aef0]
%   data: {"dataType":"text","outputData":{"text":"B1 3 phase fault equivalent extracted via the Z impedance bus:","truncated":false}}
%---
%[output:49375457]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.0202 + 0.1977i"}}
%---
%[output:9a8e204c]
%   data: {"dataType":"text","outputData":{"text":"Fault current from bus 11 (pu)","truncated":false}}
%---
%[output:04842961]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.5121 - 5.0065i"}}
%---
%[output:5495ea02]
%   data: {"dataType":"text","outputData":{"text":"Fault current from bus 11: ","truncated":false}}
%---
%[output:9aa24e57]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"7.6252e+03"}}
%---
%[output:41d99e86]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"I_fault2","rows":15,"type":"complex","value":[["0.0000 + 0.0000i"],["1.0000 - 0.0000i"],["-0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["-0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["-0.0000 - 0.0000i"],["-0.0000 - 0.0000i"],["-0.0000 + 0.0000i"],["0.0000 - 0.0000i"],["-0.0000 - 0.0000i"],["-0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 - 0.0000i"],["0.0000 - 0.0000i"]]}}
%---
%[output:76bbb151]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"S_bus","rows":15,"type":"complex","value":[["0.0000 + 0.0000i"],["0.0104 + 0.1657i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"],["0.0000 + 0.0000i"]]}}
%---
%[output:2e021f91]
%   data: {"dataType":"matrix","outputData":{"columns":16,"name":"Z_fault_3f_e","rows":16,"type":"double","value":[["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"],["0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"]]}}
%---
%[output:5d46006d]
%   data: {"dataType":"warning","outputData":{"text":"Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  1.816599e-19."}}
%---
%[output:245dfc12]
%   data: {"dataType":"text","outputData":{"text":"The grid fault impendance at the point 16 is:","truncated":false}}
%---
%[output:913c1e5d]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.0125 + 0.1683i"}}
%---
%[output:11b1f05d]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid","value":"5.9264"}}
%---
%[output:849d6518]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"9.0042e+05"}}
%---
%[output:76651de7]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b1","value":"4.3301e+03"}}
%---
%[output:4cdbb90d]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b2","value":"4.3301e+03"}}
%---
%[output:8948f3db]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_a38a","value":"2.0979e+03"}}
%---
%[output:8348d3a2]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_a38b","value":"2.0979e+03"}}
%---
%[output:8ccd0509]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_37","value":"2.0979e+03"}}
%---
%[output:000423aa]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B1","value":"4.3301e+03"}}
%---
%[output:6ea01538]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B2","value":"4.3301e+03"}}
%---
%[output:46288c91]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A38a","value":"1.8465e+03"}}
%---
%[output:98595851]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A38b","value":"1.8465e+03"}}
%---
%[output:6bc3e807]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A37","value":"1.8465e+03"}}
%---
%[output:1440f525]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid","value":"7.6252e+03"}}
%---
%[output:3429cf3f]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"2.1825e+04"}}
%---
%[output:6fb1238b]
%   data: {"dataType":"matrix","outputData":{"columns":6,"name":"I_fault_B1","rows":6,"type":"double","value":[["0","0","0","0","0","0"],["0","0","0","0","0","0"],["0","0","0","0","0","0"],["0","0","0","0","0","0"],["0","0","0","0","0","0"],["0","0","0","0","0","0"]]}}
%---
%[output:2d893d2a]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_base_66kv","value":"1.5152e+03"}}
%---
%[output:53c16ddb]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_indirect","value":"0.0124 + 0.1940i"}}
%---
%[output:9938685b]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_homo","value":"0"}}
%---
%[output:53090f47]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_direct","value":"0.0124 + 0.2173i"}}
%---
%[output:2a8822b3]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.0124 + 0.1706i"}}
%---
%[output:1eb19898]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_base_66kv","value":"1.5152e+03"}}
%---
%[output:4322efb4]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault","value":"0.2093 - 0.0018i"}}
%---
%[output:69a9040c]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"0.2093"}}
%---
%[output:709a5366]
%   data: {"dataType":"text","outputData":{"text":"The contribution of fault current from source 1 to feeder B2 is: 0.20928802 pu","truncated":false}}
%---
%[output:0f70782e]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_direct","value":"0.0042 + 0.0284i"}}
%---
%[output:337056bd]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_indirect","value":"0.0124 + 0.1940i"}}
%---
%[output:6e595fa2]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_homo","value":"0"}}
%---
%[output:7de53382]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault","value":"0.2027 + 0.0028i"}}
%---
%[output:7c671131]
%   data: {"dataType":"text","outputData":{"text":"The contribution of fault current from source A38a to feeder B2 is: 0.20276002 pu","truncated":false}}
%---
%[output:5aed5471]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_direct","value":"0.0042 + 0.0284i"}}
%---
%[output:04b2abce]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_indirect","value":"0.0124 + 0.1940i"}}
%---
%[output:2c726d74]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_homo","value":"0"}}
%---
%[output:24793ebb]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault","value":"0.2027 + 0.0028i"}}
%---
%[output:356e6fb8]
%   data: {"dataType":"text","outputData":{"text":"The contribution of fault current from source A38a to feeder B2 is: 0.20276002 pu","truncated":false}}
%---
%[output:5d70d80b]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_direct","value":"0.0042 + 0.0284i"}}
%---
%[output:49483421]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_indirect","value":"0.0124 + 0.1940i"}}
%---
%[output:6270d2ae]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z_homo","value":"0"}}
%---
%[output:45bf3693]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault","value":"0.2027 + 0.0028i"}}
%---
%[output:511546ff]
%   data: {"dataType":"text","outputData":{"text":"The contribution of fault current from source A38a to feeder B2 is: 0.20276002 pu","truncated":false}}
%---
%[output:16a0b71a]
%   data: {"dataType":"matrix","outputData":{"columns":6,"exponent":"3","name":"I_fault_B1","rows":6,"type":"double","value":[["4.3301","0","0","0","0","0"],["0","0","0","0","0","0"],["0","0","0","0","0","0"],["0","0","0","0","0","0"],["0","0","0","0","0","0"],["0","0","0","0","0","0"]]}}
%---
