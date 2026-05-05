
%% Windfarm Short Circuit Analysis - Multi-Path Topology & Power Distribution

Sbase = 100e6 %[output:25e4c803]
Ugrid = 380e3 %[output:46123620]
Ubase = Ugrid %[output:251f82c6]
Ubase2 = 66e3 %[output:3c192fba]
f = 50;                      % Frequentie [Hz]
omega = 2 * pi * f %[output:73b7d78c]

%%Grid parameters calculations
S_grid = 20e9 %[output:1fdf1a52]
% X_R_ratio = 20                                                                                                                                                          %[output:2721ca17]
% Z_grid = Ugrid^2 / S_grid %[output:792e10d7]
% R_grid = sqrt(Z_grid^2 / (1 + X_R_ratio^2)) %[output:3da1dc24]
% X_grid = X_R_ratio*R_grid*j %[output:61d154de]

% Z1_grid_pu = (R_grid + X_grid) * (Sbase / Ubase2^2) %[output:7c219cb6]



% %Grid zero sequence impedance
% X0_X1_grid_ratio = 4 %[output:3eb6d533]
% Z0_grid_pu = Z1_grid_pu * X0_X1_grid_ratio %[output:53e05f78]

%Grid parameter taken from the Simulink simulation
X0_X1_grid_ratio = 30

R1_grid = 0.01 * ((Ugrid^2) / S_grid) / 10
L1_grid = (0.1 / 100*pi) * ((Ugrid^2) / S_grid) / 10

ZL1_grid = 100*pi*L1_grid

Z1_grid = R1_grid + j*ZL1_grid
Z1_grid_pu = Z1_grid * (Sbase / Ubase2^2)

R0_grid = R1_grid*X0_X1_grid_ratio
ZL0_grid = ZL1_grid*X0_X1_grid_ratio

Z0_grid = R0_grid + j*Z0_grid_pu
Z0_grid_pu = Z0_grid * (Sbase / Ubase2^2)

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
Z1_T_Btb1 = uk_trafo_turbine*(U_66kv^2 / S_T_Btb1)*j %[output:50432b69]
Z1_T_Btb2 = uk_trafo_turbine*(U_66kv^2 / S_T_Btb2)*j %[output:6111e463]
Z1_T_Atb = uk_trafo_turbine*(U_66kv^2 / S_T_A)*j %[output:406676ac]


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

% Export Cables (Submarine cables)
length = 60 %The export cable length is 60km %[output:52bbb9d6]
% R_km = 0.1  %Ohm/km
% L_km = 0.39 %mH/km
% C_km = 0.18 %uF/km  %Just mock number, could be different later on

% Z_line = R_km*length + j*(omega*L_km*length*10^-3) 

%Data from simulated lines based on paper: Calculation and Measurement 
%of Sequence Parameters of Three-Core 
%Submarine Cable with Semi-conductive 
%Sheaths
%
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

Z1_LON_B = R1_Le_ON*length_ON + j*L1_Le_ON*length_ON*100*pi %[output:98017ce2]
Z0_LON_B = R0_Le_ON*length_ON + j*L0_Le_ON*length_ON*100*pi %[output:6a662091]

Z1_LON_A = R1_Le_ON*length_ON + j*L1_Le_ON*length_ON*100*pi %[output:83a5cf02]
Z0_LON_A = R0_Le_ON*length_ON + j*L0_Le_ON*length_ON*100*pi %[output:8b017d34]

Z1_LON_B_pu = Z1_LON_B * (Sbase / Ubase^2) %[output:3a490f70]
Z0_LON_B_pu = Z0_LON_B * (Sbase / Ubase^2) %[output:88a96e0b]

Z1_LON_A_pu = Z1_LON_A * (Sbase / Ubase^2) %[output:8058a2e5]
Z0_LON_A_pu = Z0_LON_A * (Sbase / Ubase^2) %[output:981da208]


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


%Grouding transformer on feeder side parameters
S_TB1_Grounding = 100e6;

Z0_TB1_grouding = 0.025*(U_66kv^2 / S_TB1_Grounding) + j*0.15*(U_66kv^2 / S_TB1_Grounding)  %[output:2f2c0c42]
Z0_TB1_grouding_pu = Z0_TB1_grouding / (U_66kv^2 / S_TB1_Grounding) %[output:6ef30931]

S_TA_Grounding = 100e6;

Z0_TA_grouding = 0.025*(U_66kv^2 / S_TA_Grounding) + j*0.15*(U_66kv^2 / S_TA_Grounding)  %[output:69c16f1b]
Z0_TA_grouding_pu = Z0_TA_grouding / (U_66kv^2 / S_TA_Grounding) %[output:2991768d]

%% 1f to Earth fault calc Feeder B1 
%Current source B1
z1 = Z1_fLB1_pu + Z1_TB1_pu + Z1_LSM1a_pu + Z1_LSM1b_pu + Z1_TB3_pu + Z1_LON_B_pu %[output:5af1fd3d]
z2 = Z1_fLB1_pu + Z1_TB1_pu + Z1_LSM1a_pu + Z1_LSM1b_pu + Z1_TB3_pu + Z1_LON_B_pu + Z0_fLB1_pu + Z0_TB1_grouding_pu %[output:21ac6f82]

I_base_66kv = 100e6 / (sqrt(3)*66e3) %[output:1e353ea1]
I_source_b1 = 450e6 / (sqrt(3)*66e3) %[output:104c5b7b]
I_source_b1_pu = I_source_b1 / I_base_66kv %[output:0fdd8891]
I_fault_b1_pu = 1.1*I_source_b1_pu*(z1 / (z1 + z2)) %[output:6082474f]
I_fault_b1_pu_abs = abs(I_fault_b1_pu) %[output:892f320d]

%Current source B2
z1 = Z1_TB3_pu + Z1_LON_B_pu + Z1_grid_pu %[output:7dd2f6d9]
z2 = Z1_fLB1_pu + Z1_TB1_pu + Z1_LSM1b_pu + Z1_LSM1a_pu + Z1_TB3_pu + Z1_LON_B_pu + Z1_grid_pu + Z0_fLB1_pu + Z0_TB1_grouding_pu %[output:5ba312d3]
I_source_b2 = 450e6 / (sqrt(3)*66e3) %[output:3300f802]
I_source_b2_pu = I_source_b2 / I_base_66kv %[output:05453124]
I_fault_b2_pu = 1.1*I_source_b2_pu*(z1 / (z1 + z2)) %[output:93997cb6]
I_fault_b2_pu_abs = abs(I_fault_b2_pu) %[output:9328fd92]

%Current source A
z1 = Z1_grid_pu %[output:6e9cf13a]
z2 = Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu + Z1_LSM1a_pu + Z1_TB1_pu + Z1_fLB1_pu + Z0_TB1_grouding_pu + Z0_fLB1_pu + Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu + Z1_LSM1a_pu + Z1_TB1_pu + Z1_fLB1_pu %[output:2defe093]

I_source_A = 675e6 / (sqrt(3)*66e3) %[output:6d7d3db1]
I_source_A_pu = I_source_A / I_base_66kv %[output:465c27ec]
I_fault_A_pu = 1.1*I_source_A_pu*(z1 / (z1 + z2)) %[output:12b91f3e]
I_fault_A_pu_abs = abs(I_fault_A_pu) %[output:805c8d24]

%Voltage source Grid
z1 = Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu + Z1_LSM1a_pu + Z1_fLB1_pu + Z0_TB1_grouding_pu + Z0_fLB1_pu + Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu + Z1_LSM1a_pu + Z1_fLB1_pu %[output:0964dbf0]

I_fault_grid_pu = 1 / z1 %[output:71fd220e]
I_fault_grid_pu_abs = abs(I_fault_grid_pu) %[output:4ffc0fe6]

I_fault_1f_e_feederb1_pu = I_fault_grid_pu + I_fault_A_pu + I_fault_b2_pu + I_fault_b1_pu %[output:09b65577]
I_fault_1f_e_feederb1_pu * I_base_66kv %[output:3eb50380]
abs(I_fault_1f_e_feederb1_pu * I_base_66kv) %[output:6f1f88d8]

I_fault_1f_e_feederb1_pu = I_fault_grid_pu_abs + I_fault_A_pu_abs + I_fault_b2_pu_abs + I_fault_b1_pu_abs %[output:11e0a50a]
I_fault_1f_e_feederb1 = I_fault_1f_e_feederb1_pu * I_base_66kv %[output:376eb740]
I_fault_1f_e_feederb1_peak = I_fault_1f_e_feederb1 * sqrt(2) %[output:376eb740]

%% 1fe Export cable B zone

%Current source B1
z1 = Z1_LSM1b_pu + Z1_TB3_pu + Z1_LON_B_pu + Z1_grid_pu %[output:17c70aa2]
z2 = Z1_LSM1b_pu + Z1_TB3_pu + Z1_LON_B_pu + Z1_grid_pu + ((Z0_LSM1a_pu + Z0_TB1_pu)^-1 + (Z0_LSM1b_pu + Z0_LSM2_pu + Z0_TB2_pu)^-1)^-1 %[output:6d749135]

I_base_220kv = Sbase / (sqrt(3)*220e3) %[output:3048f766]
I_source_b1_220kv = 450e6 / (sqrt(3)*220e3) %[output:4ac1c279]
I_source_b1_220kv_pu = I_source_b1_220kv / I_base_220kv %[output:58ec45d1]

I_fault_B1_export_pu = 1.1*I_source_b1_220kv_pu*(z1 / (z1 + z2)) %[output:0137b302]
I_fault_B1_export_pu_abs = abs(I_fault_B1_export_pu) %[output:3af10921]
I_fault_B1_export = I_fault_B1_export_pu_abs * I_base_220kv %[output:1ce996c5]

%Current source B2
z1 = Z1_TB3_pu + Z1_LON_B_pu + Z1_grid_pu %[output:09316920]
z2 = Z1_LSM1b_pu + ((Z0_LSM1b_pu + Z0_LSM2_pu + Z0_TB2_pu)^-1 + (Z0_LSM1a_pu + Z0_TB1_pu)^-1)^-1 + Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu %[output:680a1d69]

I_source_b2_220kv = 450e6 / (sqrt(3)*220e3) %[output:7d1ba7a7]
I_source_b2_220kv_pu = I_source_b2_220kv / I_base_220kv %[output:56a55a2d]
I_fault_B2_export_pu = 1.1*I_source_b2_220kv_pu*(z1 / (z1 + z2)) %[output:861cb2f2]
I_fault_B2_export_pu_abs = abs(I_fault_B2_export_pu) %[output:72ef06c4]
I_fault_B2_export = I_fault_B2_export_pu_abs * I_base_220kv %[output:49b1f510]

% I_grid_f_pu = 1 / (Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu)
% abs(I_grid_f_pu*I_base_220kv)

%Current source A
z1 = Z1_grid_pu %[output:436f0dd0]
z2 = Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu + Z0_TB1_pu + Z0_LSM1a_pu + Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu %[output:5406990f]

I_source_A_220kv = 675e6 / (sqrt(3)*220e3) %[output:629ca200]
I_source_A_220kv_pu = I_source_A_220kv / I_base_220kv %[output:8528c142]
I_fault_A_export_pu = 1.1*I_source_A_220kv_pu*(z1 / (z1 + z2)) %[output:8db19a03]
I_fault_A_export_pu_abs = abs(I_fault_A_export_pu) %[output:5199dc54]
I_fault_A_export = I_fault_A_export_pu_abs * I_base_220kv %[output:3f1a9742]

%Voltage source Grid
z1 = Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu + Z0_TB1_pu + Z0_LSM1a_pu + Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu %[output:7982006d]

I_fault_grid_export_pu = 1 / z1 %[output:3ec4be92]
I_fault_grid_export_pu_abs = abs(I_fault_grid_export_pu) %[output:53e28d73]
I_fault_grid_export = I_fault_grid_export_pu_abs * I_base_220kv %[output:077e38f1]

%Combine all contributions
I_fault_1fe_export = I_fault_grid_export + I_fault_A_export + I_fault_B2_export +  I_fault_B1_export %[output:2ac2f42f]
I_fault_1fe_export_peak = I_fault_1fe_export * sqrt(2) %[output:9953de2c]

%% 3f Export cable B zone

%Current source B1

I_base_220kv = Sbase / (sqrt(3)*220e3) %[output:1516e5fb]
I_source_b1_220kv = 450e6 / (sqrt(3)*220e3) %[output:452d4e2c]
I_source_b1_220kv_pu = I_source_b1_220kv / I_base_220kv %[output:537a27bd]

I_fault_B1_3f_export_pu = 1.1*I_source_b1_220kv_pu %[output:7b82c7cf]
I_fault_B1_3f_export_pu_abs = abs(I_fault_B1_3f_export_pu) %[output:333c7b03]
I_fault_B1_3f_export = I_fault_B1_3f_export_pu_abs * I_base_220kv %[output:28cc8374]

%Current source B2
z1 = Z1_TB3_pu + Z1_LON_B_pu + Z1_grid_pu %[output:59b2be36]
z2 = Z1_LSM1b_pu %[output:5bb17480]

I_source_b2_220kv = 450e6 / (sqrt(3)*220e3) %[output:1d3265b4]
I_source_b2_220kv_pu = I_source_b2_220kv / I_base_220kv %[output:5766fa2b]
I_fault_B2_3f_export_pu = 1.1*I_source_b2_220kv_pu*(z1 / (z1 + z2)) %[output:8cc65af6]
I_fault_B2_3f_export_pu_abs = abs(I_fault_B2_3f_export_pu) %[output:3ae4d8fd]
I_fault_B2_3f_export = I_fault_B2_3f_export_pu_abs * I_base_220kv %[output:8f2f9be7]

%Current source A
z1 = Z1_grid_pu %[output:39393f5f]
z2 = Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu %[output:01b93f97]

I_source_A_220kv = 675e6 / (sqrt(3)*220e3) %[output:6af7d473]
I_source_A_220kv_pu = I_source_A_220kv / I_base_220kv %[output:16b579be]
I_fault_A_3f_export_pu = 1.1*I_source_A_220kv_pu*(z1 / (z1 + z2)) %[output:131b1551]
I_fault_A_3f_export_pu_abs = abs(I_fault_A_3f_export_pu) %[output:4e55c73c]
I_fault_A_3f_export = I_fault_A_3f_export_pu_abs * I_base_220kv %[output:2d4c3526]

%Voltage source Grid
z1 = Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu %[output:5c0b6459]
I_fault_grid_3f_export_pu = 1 / z1 %[output:639106b1]
I_fault_grid_3f_export_pu_abs = abs(I_fault_grid_3f_export_pu) %[output:9d83e423]
I_fault_grid_3f_export = I_fault_grid_3f_export_pu_abs * I_base_220kv %[output:5e5e71b4]

%Combine all contributions
I_fault_3f_export = I_fault_grid_3f_export + I_fault_A_3f_export + I_fault_B2_3f_export +  I_fault_B1_3f_export %[output:0951d554]
I_fault_3f_export_peak = I_fault_3f_export * sqrt(2) %[output:46440cde]



%% 3f Feeder cable B zone

% Current source B1
I_source_b1_pu = I_source_b1 / I_base_66kv %[output:12ab4a1e]
I_fault_b1_3f_feed_pu = 1.1*I_source_b1_pu %[output:69927e43]
I_fault_b1_3f_feed_pu_abs = abs(I_fault_b1_3f_feed_pu) %[output:7866429b]
I_fault_b1_3f_feed = I_fault_b1_3f_feed_pu_abs*I_base_66kv %[output:83e31dad]

% Current source B2
z1 = Z1_TB3_pu + Z1_LON_B_pu + Z1_grid_pu %[output:1ee00a8b]
z2 = Z1_fLB1_pu + Z1_TB1_pu + Z1_LSM1b_pu + Z1_LSM1a_pu %[output:2514cf3d]

I_source_b2 = 450e6 / (sqrt(3)*66e3) %[output:0bc1c26d]
I_source_b2_pu = I_source_b2 / I_base_66kv %[output:9a3616c8]
I_fault_b2_3f_feed_pu = I_source_b2_pu*(z1 / (z1 + z2)) %[output:44c2cb67]
I_fault_b2_3f_feed_pu_abs = abs(I_fault_b2_3f_feed_pu) %[output:0921e874]
I_fault_b1_3f_feed = I_fault_b2_3f_feed_pu_abs * I_base_66kv %[output:25911db7]

% Current source A
z1 = Z1_grid_pu %[output:5e0a9cba]
z2 = Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu + Z1_LSM1a_pu + Z1_TB1_pu + Z1_fLB1_pu %[output:762eedc7]

I_source_A = 675e6 / (sqrt(3)*66e3) %[output:0dcc85be]
I_source_A_pu = I_source_A / I_base_66kv %[output:9fcadc02]
I_fault_A_3f_feed_pu = I_source_A_pu*(z1 / (z1 + z2)) %[output:5622e9fa]
I_fault_A_3f_feed_pu_abs = abs(I_fault_A_3f_feed_pu) %[output:4be2c8a8]
I_fault_A_3f_feed = I_fault_A_3f_feed_pu_abs * I_base_66kv %[output:9fd3c197]

% Voltage source Grid
z1 = Z1_grid_pu + Z1_LON_B_pu + Z1_TB3_pu + Z1_LSM1b_pu + Z1_LSM1a_pu + Z1_TB1_pu + Z1_fLB1_pu %[output:5f75e8b3]

I_fault_grid_3f_feed_pu = 1 / z1 %[output:6ae09002]
I_fault_grid_3f_feed_pu_abs = abs(I_fault_grid_3f_feed_pu) %[output:724428b8]
I_fault_grid_3f_feed = I_fault_grid_3f_feed_pu_abs * I_base_66kv %[output:2c6a8e81]

I_fault_3f_feed = I_fault_grid_3f_feed + I_fault_A_3f_feed + I_fault_b1_3f_feed + I_fault_b1_3f_feed %[output:228744af]
I_fault_3f_feed_peak = I_fault_3f_feed * sqrt(2)


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":23.4}
%---
%[output:25e4c803]
%   data: {"dataType":"textualVariable","outputData":{"name":"Sbase","value":"100000000"}}
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
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_grid_pu","value":"0.0083 + 0.1655i"}}
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
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Btb1","value":"0.0000 + 0.2420i"}}
%---
%[output:6111e463]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Btb2","value":"0.0000 + 0.2420i"}}
%---
%[output:406676ac]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Atb","value":"0.0000 + 0.1210i"}}
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
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Btb1_pu","value":"0.0000 + 0.0056i"}}
%---
%[output:81e8e5f2]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Btb2_pu","value":"0.0000 + 0.0056i"}}
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
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_T_Atb_pu","value":"0.0000 + 0.0028i"}}
%---
%[output:91896ba5]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_T_Atb_pu","value":"0.0000 + 0.0067i"}}
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
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_LON_B","value":"3.1350 + 0.2660i"}}
%---
%[output:6a662091]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_LON_B","value":"45.4500 + 0.9910i"}}
%---
%[output:83a5cf02]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_LON_A","value":"3.1350 + 0.2660i"}}
%---
%[output:8b017d34]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_LON_A","value":"45.4500 + 0.9910i"}}
%---
%[output:3a490f70]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_LON_B_pu","value":"0.0022 + 0.0002i"}}
%---
%[output:88a96e0b]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_LON_B_pu","value":"0.0315 + 0.0007i"}}
%---
%[output:8058a2e5]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z1_LON_A_pu","value":"0.0022 + 0.0002i"}}
%---
%[output:981da208]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_LON_A_pu","value":"0.0315 + 0.0007i"}}
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
%[output:2f2c0c42]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TB1_grouding","value":"1.0890 + 6.5340i"}}
%---
%[output:6ef30931]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TB1_grouding_pu","value":"0.0250 + 0.1500i"}}
%---
%[output:69c16f1b]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TA_grouding","value":"1.0890 + 6.5340i"}}
%---
%[output:2991768d]
%   data: {"dataType":"textualVariable","outputData":{"name":"Z0_TA_grouding_pu","value":"0.0250 + 0.1500i"}}
%---
%[output:5af1fd3d]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0103 + 0.0475i"}}
%---
%[output:21ac6f82]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0438 + 0.2027i"}}
%---
%[output:1e353ea1]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_base_66kv","value":"874.7731"}}
%---
%[output:104c5b7b]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b1","value":"3.9365e+03"}}
%---
%[output:0fdd8891]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b1_pu","value":"4.5000"}}
%---
%[output:6082474f]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b1_pu","value":"0.9392 - 0.0014i"}}
%---
%[output:892f320d]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b1_pu_abs","value":"0.9392"}}
%---
%[output:7dd2f6d9]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0104 + 0.1797i"}}
%---
%[output:5ba312d3]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0520 + 0.3683i"}}
%---
%[output:3300f802]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b2","value":"3.9365e+03"}}
%---
%[output:05453124]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b2_pu","value":"4.5000"}}
%---
%[output:93997cb6]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b2_pu","value":"1.6132 + 0.0896i"}}
%---
%[output:9328fd92]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b2_pu_abs","value":"1.6157"}}
%---
%[output:6e9cf13a]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0083 + 0.1655i"}}
%---
%[output:2defe093]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0624 + 0.4157i"}}
%---
%[output:6d7d3db1]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_A","value":"5.9047e+03"}}
%---
%[output:465c27ec]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_A_pu","value":"6.7500"}}
%---
%[output:12b91f3e]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_pu","value":"2.0964 + 0.1490i"}}
%---
%[output:805c8d24]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_pu_abs","value":"2.1017"}}
%---
%[output:0964dbf0]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0706 + 0.5346i"}}
%---
%[output:71fd220e]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_pu","value":"0.2429 - 1.8384i"}}
%---
%[output:4ffc0fe6]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_pu_abs","value":"1.8544"}}
%---
%[output:09b65577]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_1f_e_feederb1_pu","value":"4.8918 - 1.6011i"}}
%---
%[output:3eb50380]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"4.2792e+03 - 1.4006e+03i"}}
%---
%[output:6f1f88d8]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"4.5026e+03"}}
%---
%[output:11e0a50a]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_1f_e_feederb1_pu","value":"6.5110"}}
%---
%[output:376eb740]
%   data: {"dataType":"textualVariable","outputData":{"name":"ans","value":"5.6956e+03"}}
%---
%[output:17c70aa2]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0117 + 0.1829i"}}
%---
%[output:6d749135]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0156 + 0.2137i"}}
%---
%[output:3048f766]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_base_220kv","value":"262.4319"}}
%---
%[output:4ac1c279]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b1_220kv","value":"1.1809e+03"}}
%---
%[output:58ec45d1]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b1_220kv_pu","value":"4.5000"}}
%---
%[output:0137b302]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B1_export_pu","value":"2.2821 + 0.0110i"}}
%---
%[output:3af10921]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B1_export_pu_abs","value":"2.2821"}}
%---
%[output:1ce996c5]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B1_export","value":"598.8999"}}
%---
%[output:09316920]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0104 + 0.1797i"}}
%---
%[output:680a1d69]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0169 + 0.2169i"}}
%---
%[output:7d1ba7a7]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b2_220kv","value":"1.1809e+03"}}
%---
%[output:56a55a2d]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b2_220kv_pu","value":"4.5000"}}
%---
%[output:861cb2f2]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B2_export_pu","value":"2.2411 + 0.0241i"}}
%---
%[output:72ef06c4]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B2_export_pu_abs","value":"2.2413"}}
%---
%[output:49b1f510]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B2_export","value":"588.1791"}}
%---
%[output:436f0dd0]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0083 + 0.1655i"}}
%---
%[output:5406990f]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0193 + 0.2591i"}}
%---
%[output:629ca200]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_A_220kv","value":"1.7714e+03"}}
%---
%[output:8528c142]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_A_220kv_pu","value":"6.7500"}}
%---
%[output:8db19a03]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_export_pu","value":"2.8919 + 0.0427i"}}
%---
%[output:5199dc54]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_export_pu_abs","value":"2.8923"}}
%---
%[output:3f1a9742]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_export","value":"759.0205"}}
%---
%[output:7982006d]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0275 + 0.4246i"}}
%---
%[output:3ec4be92]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_export_pu","value":"0.1520 - 2.3452i"}}
%---
%[output:53e28d73]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_export_pu_abs","value":"2.3501"}}
%---
%[output:077e38f1]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_export","value":"616.7480"}}
%---
%[output:2ac2f42f]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_1fe_export","value":"2.5628e+03"}}
%---
%[output:9953de2c]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_1fe_export_peak","value":"3.6244e+03"}}
%---
%[output:1516e5fb]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_base_220kv","value":"262.4319"}}
%---
%[output:452d4e2c]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b1_220kv","value":"1.1809e+03"}}
%---
%[output:537a27bd]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b1_220kv_pu","value":"4.5000"}}
%---
%[output:7b82c7cf]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B1_3f_export_pu","value":"4.9500"}}
%---
%[output:333c7b03]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B1_3f_export_pu_abs","value":"4.9500"}}
%---
%[output:28cc8374]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B1_3f_export","value":"1.2990e+03"}}
%---
%[output:59b2be36]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0104 + 0.1797i"}}
%---
%[output:5bb17480]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0013 + 0.0032i"}}
%---
%[output:1d3265b4]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b2_220kv","value":"1.1809e+03"}}
%---
%[output:5766fa2b]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b2_220kv_pu","value":"4.5000"}}
%---
%[output:8cc65af6]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B2_3f_export_pu","value":"4.8613 + 0.0287i"}}
%---
%[output:3ae4d8fd]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B2_3f_export_pu_abs","value":"4.8614"}}
%---
%[output:8f2f9be7]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_B2_3f_export","value":"1.2758e+03"}}
%---
%[output:39393f5f]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0083 + 0.1655i"}}
%---
%[output:01b93f97]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0034 + 0.0174i"}}
%---
%[output:6af7d473]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_A_220kv","value":"1.7714e+03"}}
%---
%[output:16b579be]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_A_220kv_pu","value":"6.7500"}}
%---
%[output:131b1551]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_3f_export_pu","value":"6.7130 + 0.0941i"}}
%---
%[output:4e55c73c]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_3f_export_pu_abs","value":"6.7136"}}
%---
%[output:2d4c3526]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_3f_export","value":"1.7619e+03"}}
%---
%[output:5c0b6459]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0117 + 0.1829i"}}
%---
%[output:639106b1]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_3f_export_pu","value":"0.3488 - 5.4441i"}}
%---
%[output:9d83e423]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_3f_export_pu_abs","value":"5.4552"}}
%---
%[output:5e5e71b4]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_3f_export","value":"1.4316e+03"}}
%---
%[output:0951d554]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_3f_export","value":"5.7683e+03"}}
%---
%[output:46440cde]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_3f_export_peak","value":"8.1576e+03"}}
%---
%[output:12ab4a1e]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b1_pu","value":"4.5000"}}
%---
%[output:69927e43]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b1_3f_feed_pu","value":"4.9500"}}
%---
%[output:7866429b]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b1_3f_feed_pu_abs","value":"4.9500"}}
%---
%[output:83e31dad]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b1_3f_feed","value":"4.3301e+03"}}
%---
%[output:1ee00a8b]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0104 + 0.1797i"}}
%---
%[output:2514cf3d]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0082 + 0.0333i"}}
%---
%[output:0bc1c26d]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b2","value":"3.9365e+03"}}
%---
%[output:9a3616c8]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_b2_pu","value":"4.5000"}}
%---
%[output:44c2cb67]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b2_3f_feed_pu","value":"3.7874 + 0.1101i"}}
%---
%[output:0921e874]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b2_3f_feed_pu_abs","value":"3.7890"}}
%---
%[output:25911db7]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_b1_3f_feed","value":"3.3145e+03"}}
%---
%[output:5e0a9cba]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0083 + 0.1655i"}}
%---
%[output:762eedc7]
%   data: {"dataType":"textualVariable","outputData":{"name":"z2","value":"0.0103 + 0.0475i"}}
%---
%[output:0dcc85be]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_A","value":"5.9047e+03"}}
%---
%[output:9fcadc02]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_source_A_pu","value":"6.7500"}}
%---
%[output:5622e9fa]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_3f_feed_pu","value":"5.2290 + 0.1945i"}}
%---
%[output:4be2c8a8]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_3f_feed_pu_abs","value":"5.2326"}}
%---
%[output:9fd3c197]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_A_3f_feed","value":"4.5774e+03"}}
%---
%[output:5f75e8b3]
%   data: {"dataType":"textualVariable","outputData":{"name":"z1","value":"0.0186 + 0.2130i"}}
%---
%[output:6ae09002]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_3f_feed_pu","value":"0.4070 - 4.6593i"}}
%---
%[output:724428b8]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_3f_feed_pu_abs","value":"4.6770"}}
%---
%[output:2c6a8e81]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_grid_3f_feed","value":"4.0913e+03"}}
%---
%[output:228744af]
%   data: {"dataType":"textualVariable","outputData":{"name":"I_fault_3f_feed","value":"1.5298e+04"}}
%---
