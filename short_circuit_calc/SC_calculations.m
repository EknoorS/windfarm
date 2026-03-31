
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

ST1 = 600e6 %[output:24baec0a]
ST2 = ST1 %[output:881934c8]
ST3 = 450e6 %[output:8c903fb5]
ST4 = 450e6 %[output:0a257361]
ST5 = 225e6 %[output:49622d72]
U_66kv = 66e3 %[output:90442a2c]
U_380kV = 380e3  %[output:4ccd0c98]
% Z_grid = ((380e3)^2/S_grid)*(Sbase/Ubase^2)

% Transfo 
uk_trafo = 0.14;             % Kortsluitspanning trafo (14%)
ZTB1 = uk_trafo*(U_66kv^2/ST1)*j %[output:5f0e66e1]
ZTB2 = uk_trafo* (U_66kv^2/ST2)*j %[output:50432b69]
ZTA38a = uk_trafo* (U_66kv^2/ST3)*j %[output:984046ea]
ZTA38b = uk_trafo*(U_66kv^2/ST4)*j %[output:8806d3bb]
ZTA37 = uk_trafo* (U_66kv^2/ST5)*j %[output:02ac021b]

ZTB1_pu = ZTB1*( Sbase/Ubase2^2 )  %[output:6111e463]
ZTB2_pu = ZTB2*( Sbase/Ubase2^2 )   %[output:406676ac]
ZTA38a_pu = ZTA38a*( Sbase/Ubase2^2 )  %[output:0e36b99a]
ZTA38b_pu = ZTA38b*( Sbase/Ubase2^2 )  %[output:32b0c49c]
ZTA37_pu = ZTA37*( Sbase/Ubase2^2 ) %[output:1621f991]

%Transformer zero sequence parameter
X0_X1_T_ratio = 2.4 %[output:0499a215]

Z0_TB1_pu = ZTB1_pu* X0_X1_T_ratio %[output:9a6ca00e]
Z0_TB2_pu = ZTB2_pu* X0_X1_T_ratio %[output:72a7a891]
Z0_TA38a_pu = ZTA38a_pu* X0_X1_T_ratio %[output:7e5f9e24]
Z0_TA38b_pu = ZTA38b_pu* X0_X1_T_ratio %[output:87c18141]
Z0_TA37_pu = ZTA37_pu* X0_X1_T_ratio %[output:02197d08]

% Export Cables 
length = 60 %The export cable length is 60km %[output:2cbaa86d]
R_km = 0.1  %Ohm/km %[output:30a79469]
C_km = 0.18 %uF/km  %Just mock number, could be different later on %[output:6fe428bf]
L_km = 0.39 %mH/km %[output:52061116]

Z_line = R_km*length + j*(omega*L_km*length*10^-3)  %[output:2d75037d]

ZLe1_pu = Z_line * (Sbase/Ubase^2) %[output:424b1f03]
ZLe1_1_pu = ZLe1_pu/2 %[output:5435ed8d]
ZLe1_2_pu = ZLe1_pu/2 %[output:6cb383a7]
ZLe2_pu = Z_line * (Sbase/Ubase^2) %[output:864d84e6]
ZLe3_pu = Z_line * (Sbase/Ubase^2) %[output:4c0c949c]

xo_x1_ratio_submarine = 1 %(could be from 1 to 1.5 because submarine cables have good return path via water and cable sheath) %[output:1d9c9443]
Z0_Le1_pu = ZLe1_pu * xo_x1_ratio_submarine %[output:65de1136]
Z0_Le1_1_pu = Z0_Le1_pu/2 * xo_x1_ratio_submarine %[output:6bb1159d]
Z0_Le1_2_pu = Z0_Le1_pu/2 * xo_x1_ratio_submarine %[output:29db49c3]
Z0_Le2_pu = ZLe2_pu * xo_x1_ratio_submarine %[output:1e768a8f]
Z0_Le3_pu = ZLe3_pu * xo_x1_ratio_submarine %[output:08d12e67]


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

Z1_Le_ON = R1_Le_ON*length_ON + j*L1_Le_ON*100*pi %[output:1dceb1ab]
Z0_Le_ON = R0_Le_ON*length_ON + j*L0_Le_ON*100*pi %[output:4ba1a123]

Z1_Le_ON_pu = Z1_Le_ON * (Sbase / Ubase^2) %[output:93fbbe05]
Z0_Le_ON_pu = Z0_Le_ON * (Sbase / Ubase^2) %[output:535c4548]

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

%%Turbine equivalent current source circuit:

%Current source parallel impedance

Z_sB1 = U_66kv^2 / (P_B1*10^6) %[output:451d89e0]
Z_sB2 = U_66kv^2 / (P_B2*10^6) %[output:90949ce3]
Z_sA38a = U_66kv^2 / (P_A38a*10^6) %[output:094255b7]
Z_sA38b = U_66kv^2 / (P_A38b*10^6) %[output:8baf6cc8]
Z_sA37 = U_66kv^2 / (P_A37*10^6) %[output:789aca9e]

Z_sB1_pu = Z_sB1 * (Sbase / Ubase2^2) %[output:525045e0]
Z_sB2_pu = Z_sB2 * (Sbase / Ubase2^2) %[output:964ad76e]
Z_sA38a_pu = Z_sA38a * (Sbase / Ubase2^2) %[output:36c59655]
Z_sA38b_pu = Z_sA38b * (Sbase / Ubase2^2) %[output:52fb70a7]
Z_sA37_pu = Z_sA37 * (Sbase / Ubase2^2) %[output:4cb70c82]

%%Phase to ground fault situation
%On feeder B1;

%Build the admittance matrix
A = zeros(15, 15);

%Diagonal terms
A(1,1) = 1 / (Z_grid_pu);
A(2,2) =  1 / (Z_grid_pu) + 1 / ZLe2_pu + 1 / ZLe3_pu  + 1 / ZLe1_pu;
A(3,3) =  1 / ZLe1_pu + 1 / ZTB1_pu + 1 / ZTB2_pu;
A(4,4) =  1 / ZLe2_pu + 1 / ZTA38a_pu + 1 / ZTA38b_pu;
A(5,5) =  1 / ZLe3_pu + 1 / ZTA37_pu;
A(6,6) =  1 / ZTB1_pu + 1/ ZfLB1_pu;
A(7,7) =  1 / ZTB2_pu + 1 / ZfLB2_pu;
A(8,8) =  1 / ZTA38a_pu + 1 / ZfLA38a_pu;
A(9,9) =  1 / ZTA38b_pu + 1 / ZfLA38b_pu;
A(10,10) =  1 / ZTA37_pu + 1 / ZfLA37_pu;
A(11,11) =  1 / ZfLB1_pu + 1 / Z_sB1_pu;
A(12,12) =  1 / ZfLB2_pu + 1 / Z_sB2_pu;
A(13,13) =  1 / ZfLA38a_pu + 1 / Z_sA38a_pu;
A(14,14) =  1 / ZfLA38b_pu + 1 / Z_sA38b_pu;
A(15,15) =  1 / ZfLA37_pu + 1 / Z_sA37_pu; 
   
%Off-diagonal terms
A(1, 2) = -(1 / Z_grid_pu);
A(1, 2) = A(2, 1);

A(2, 3) = -(1 /  ZLe1_pu);
A(3, 2) = A(2, 3);

A(2, 4) = -(1 / ZLe2_pu);
A(4, 2) = A(2, 4);

A(2, 5) = -(1 / ZLe3_pu);
A(5, 2) = A(2, 5);

A(3, 6) = -(1 / ZTB1_pu);
A(6, 3) = A(3, 6);

A(3, 7) = -(1 / ZTB2_pu);
A(7, 3) = A(3, 7);

A(4, 8) = -(1 / ZTA38a_pu);
A(8, 4) = A(4, 8);

A(4, 9) = -(1 / ZTA38b_pu);
A(9, 4) = A(4, 9);

A(5, 10) = -(1 / ZTA37_pu);
A(10, 5) = A(5, 10);

A(6, 11) = -(1 / ZfLB1_pu);
A(11, 6) = A(6, 11);

A(7, 12) = -(1 / ZfLB2_pu);
A(12, 7) = A(7, 12);

A(8, 13) = -(1 / ZfLA38a_pu);
A(13, 8) = A(8, 13);

A(9, 14) = -(1 / ZfLA38b_pu);
A(14, 9) = A(9, 14);

A(10, 15) = -(1 / ZfLA37_pu);
A(15, 10) = A(10, 15);

A %[output:6f3e8db3]

% Contruct the current injection matrix
I = zeros(15, 1);

k = 6;
I(k) = 1; %Inject 1A at node k

V = A \ I;

V(k) %[output:2c8c48e3]


%Admittance matrix at the fault condition, remove the current source
%parallel impedance. 
%Build the admittance matrix
A_fault = zeros(15, 15);

% Diagonal terms
% A_fault(1,1) = 1 / (Z_grid_pu);
A_fault(1, 1) = eps; %This is to represent the bus 1 is excluded from the admittance matrix

A_fault(2,2) =  1 / (Z_grid_pu + Z1_Le_ON_pu) + 1 / ZLe2_pu + 1 / ZLe3_pu  + 1 / ZLe1_pu;
A_fault(3,3) =  1 / ZLe1_pu + 1 / ZTB1_pu + 1 / ZTB2_pu;
A_fault(4,4) =  1 / ZLe2_pu + 1 / ZTA38a_pu + 1 / ZTA38b_pu;
A_fault(5,5) =  1 / ZLe3_pu + 1 / ZTA37_pu;
A_fault(6,6) =  1 / ZTB1_pu + 1/ ZfLB1_pu;
A_fault(7,7) =  1 / ZTB2_pu + 1 / ZfLB2_pu;
A_fault(8,8) =  1 / ZTA38a_pu + 1 / ZfLA38a_pu;
A_fault(9,9) =  1 / ZTA38b_pu + 1 / ZfLA38b_pu;
A_fault(10,10) =  1 / ZTA37_pu + 1 / ZfLA37_pu;
A_fault(11,11) =  1 / ZfLB1_pu;
A_fault(12,12) =  1 / ZfLB2_pu;
A_fault(13,13) =  1 / ZfLA38a_pu;
A_fault(14,14) =  1 / ZfLA38b_pu;
A_fault(15,15) =  1 / ZfLA37_pu; 

%Off-diagonal terms
% A_fault(1, 2) = -(1 / Z_grid_pu);
% A_fault(2, 1) = A_fault(2, 1);

A_fault(1, 2) = eps;
A_fault(2, 1) = A_fault(2, 1);

A_fault(2, 3) = -(1 /  ZLe1_pu);
A_fault(3, 2) = A_fault(2, 3);

A_fault(2, 4) = -(1 / ZLe2_pu);
A_fault(4, 2) = A_fault(2, 4);

A_fault(2, 5) = -(1 / ZLe3_pu);
A_fault(5, 2) = A_fault(2, 5);

A_fault(3, 6) = -(1 / ZTB1_pu);
A_fault(6, 3) = A_fault(3, 6);

A_fault(3, 7) = -(1 / ZTB2_pu);
A_fault(7, 3) = A_fault(3, 7);

A_fault(4, 8) = -(1 / ZTA38a_pu);
A_fault(8, 4) = A_fault(4, 8);

A_fault(4, 9) = -(1 / ZTA38b_pu);
A_fault(9, 4) = A_fault(4, 9);

A_fault(5, 10) = -(1 / ZTA37_pu);
A_fault(10, 5) = A_fault(5, 10);

A_fault(6, 11) = -(1 / ZfLB1_pu);
A_fault(11, 6) = A_fault(6, 11);

A_fault(7, 12) = -(1 / ZfLB2_pu);
A_fault(12, 7) = A_fault(7, 12);

A_fault(8, 13) = -(1 / ZfLA38a_pu);
A_fault(13, 8) = A_fault(8, 13);

A_fault(9, 14) = -(1 / ZfLA38b_pu);
A_fault(14, 9) = A_fault(9, 14);

A_fault(10, 15) = -(1 / ZfLA37_pu);
A_fault(15, 10) = A_fault(10, 15);

% A_fault = zeros(14, 14) %Test removing bus 1 to make it a ground
% connection point.
% 
%Diagonal terms

% A_fault(1,1) =  1 / (Z_grid_pu) + 1 / ZLe2_pu + 1 / ZLe3_pu  + 1 / ZLe1_pu;
% A_fault(2,2) =  1 / ZLe1_pu + 1 / ZTB1_pu + 1 / ZTB2_pu;
% A_fault(3,3) =  1 / ZLe2_pu + 1 / ZTA38a_pu + 1 / ZTA38b_pu;
% A_fault(4,4) =  1 / ZLe3_pu + 1 / ZTA37_pu;
% A_fault(5,5) =  1 / ZTB1_pu + 1/ ZfLB1_pu;
% A_fault(6,6) =  1 / ZTB2_pu + 1 / ZfLB2_pu;
% A_fault(7,7) =  1 / ZTA38a_pu + 1 / ZfLA38a_pu;
% A_fault(8,8) =  1 / ZTA38b_pu + 1 / ZfLA38b_pu;
% A_fault(9,9) =  1 / ZTA37_pu + 1 / ZfLA37_pu;
% A_fault(10,10) =  1 / ZfLB1_pu;
% A_fault(11,11) =  1 / ZfLB2_pu;
% A_fault(12,12) =  1 / ZfLA38a_pu;
% A_fault(13,13) =  1 / ZfLA38b_pu;
% A_fault(14,14) =  1 / ZfLA37_pu; 
% 
% %Off-diagonal terms
% 
% A_fault(1, 2) = -(1 /  ZLe1_pu);
% A_fault(2, 1) = A_fault(1, 2);
% 
% A_fault(1, 3) = -(1 / ZLe2_pu);
% A_fault(3, 1) = A_fault(1, 3);
% 
% A_fault(1, 4) = -(1 / ZLe3_pu);
% A_fault(4, 1) = A_fault(1, 4);
% 
% A_fault(2, 5) = -(1 / ZTB1_pu);
% A_fault(5, 2) = A_fault(2, 5);
% 
% A_fault(2, 6) = -(1 / ZTB2_pu);
% A_fault(6, 2) = A_fault(2, 6);
% 
% A_fault(3, 7) = -(1 / ZTA38a_pu);
% A_fault(7, 3) = A_fault(3, 7);
% 
% A_fault(3, 8) = -(1 / ZTA38b_pu);
% A_fault(8, 3) = A_fault(3, 8);
% 
% A_fault(4, 9) = -(1 / ZTA37_pu);
% A_fault(9, 4) = A_fault(4, 9);
% 
% A_fault(5, 10) = -(1 / ZfLB1_pu);
% A_fault(10, 5) = A_fault(5, 10);
% 
% A_fault(6, 11) = -(1 / ZfLB2_pu);
% A_fault(11, 6) = A_fault(6, 11);
% 
% A_fault(7, 12) = -(1 / ZfLA38a_pu);
% A_fault(12, 7) = A_fault(7, 12);
% 
% A_fault(8, 13) = -(1 / ZfLA38b_pu);
% A_fault(13, 8) = A_fault(8, 13);
% 
% A_fault(9, 14) = -(1 / ZfLA37_pu);
% A_fault(14, 9) = A_fault(9, 14);


% Contruct the current injection matrix
I = zeros(15, 1);

k = 11;
% I(2) = -1;
I(2) = 1;


V = A_fault \ I %[output:13cb3dfd] %[output:031b3826]
% (V(11) - V(1))*(A_fault(6, 11) + A_fault(3, 6))
abs((V(1) - V(2)) / (Z_grid_pu)) %[output:27322763]

V(9) %[output:354023d0]

%The correct number for the equivalent impendance seen from bus 11
fprintf("Hand calculate the impendace from bus 11 to GND:") %[output:8bc5d837]
ZfLB1_pu + ZTB1_pu + ZLe1_pu + Z_grid_pu %[output:34353223]

Z_fault2 = A_fault \ eye(size(A_fault)); %[output:33ec8d23]
fprintf("B1 3 phase fault equivalent extracted via the Z impedance bus:") %[output:3633aef0]
Z_fault2(11, 11) %[output:49375457]
fprintf("Fault current from bus 11 (pu)") %[output:9a8e204c]
1 / Z_fault2(11, 11) %[output:04842961]
fprintf("Fault current from bus 11: ") %[output:5495ea02]
abs(Sbase/Ubase2 * 1 / Z_fault2(11, 11)) %[output:9aa24e57]

I_fault2 = A_fault * V %[output:41d99e86]

S_bus = V .* I %[output:76bbb151]

%%
%[text] ## 3 phase short at the export cable
Z_fault_3f_e = zeros(16, 16) %[output:2e021f91]

Z_fault_3f_e(1,1) = eps;
Z_fault_3f_e(2,2) =  1 / (Z_grid_pu + Z1_Le_ON_pu) + 1 / ZLe2_pu + 1 / ZLe3_pu  + 1/ZLe1_1_pu;
Z_fault_3f_e(3,3) =  1/ZLe1_2_pu + 1 / ZTB1_pu + 1 / ZTB2_pu;
Z_fault_3f_e(4,4) =  1 / ZLe2_pu + 1 / ZTA38a_pu + 1 / ZTA38b_pu;
Z_fault_3f_e(5,5) =  1 / ZLe3_pu + 1 / ZTA37_pu;
Z_fault_3f_e(6,6) =  1 / ZTB1_pu + 1/ ZfLB1_pu;
Z_fault_3f_e(7,7) =  1 / ZTB2_pu + 1 / ZfLB2_pu;
Z_fault_3f_e(8,8) =  1 / ZTA38a_pu + 1 / ZfLA38a_pu;
Z_fault_3f_e(9,9) =  1 / ZTA38b_pu + 1 / ZfLA38b_pu;
Z_fault_3f_e(10,10) =  1 / ZTA37_pu + 1 / ZfLA37_pu;
Z_fault_3f_e(11,11) =  1 / ZfLB1_pu;
Z_fault_3f_e(12,12) =  1 / ZfLB2_pu;
Z_fault_3f_e(13,13) =  1 / ZfLA38a_pu;
Z_fault_3f_e(14,14) =  1 / ZfLA38b_pu;
Z_fault_3f_e(15,15) =  1 / ZfLA37_pu; 
Z_fault_3f_e(16,16) =  1/ZLe1_1_pu + 1/ZLe1_2_pu;

Z_fault_3f_e(1, 2) = eps;
Z_fault_3f_e(2, 1) = Z_fault_3f_e(2, 1);

Z_fault_3f_e(2, 4) = -(1 / ZLe2_pu);
Z_fault_3f_e(4, 2) = Z_fault_3f_e(2, 4);

Z_fault_3f_e(2, 5) = -(1 / ZLe3_pu);
Z_fault_3f_e(5, 2) = Z_fault_3f_e(2, 5);

Z_fault_3f_e(3, 6) = -(1 / ZTB1_pu);
Z_fault_3f_e(6, 3) = Z_fault_3f_e(3, 6);

Z_fault_3f_e(3, 7) = -(1 / ZTB2_pu);
Z_fault_3f_e(7, 3) = Z_fault_3f_e(3, 7);

Z_fault_3f_e(4, 8) = -(1 / ZTA38a_pu);
Z_fault_3f_e(8, 4) = Z_fault_3f_e(4, 8);

Z_fault_3f_e(4, 9) = -(1 / ZTA38b_pu);
Z_fault_3f_e(9, 4) = Z_fault_3f_e(4, 9);

Z_fault_3f_e(5, 10) = -(1 / ZTA37_pu);
Z_fault_3f_e(10, 5) = Z_fault_3f_e(5, 10);

Z_fault_3f_e(6, 11) = -(1 / ZfLB1_pu);
Z_fault_3f_e(11, 6) = Z_fault_3f_e(6, 11);

Z_fault_3f_e(7, 12) = -(1 / ZfLB2_pu);
Z_fault_3f_e(12, 7) = Z_fault_3f_e(7, 12);

Z_fault_3f_e(8, 13) = -(1 / ZfLA38a_pu);
Z_fault_3f_e(13, 8) = Z_fault_3f_e(8, 13);

Z_fault_3f_e(9, 14) = -(1 / ZfLA38b_pu);
Z_fault_3f_e(14, 9) = Z_fault_3f_e(9, 14);

Z_fault_3f_e(10, 15) = -(1 / ZfLA37_pu);
Z_fault_3f_e(15, 10) = Z_fault_3f_e(10, 15);

Z_fault_3f_e(2, 16) = -(1/ZLe1_1_pu);
Z_fault_3f_e(16, 2) = Z_fault_3f_e(2, 16);

Z_fault_3f_e(3, 16) = -(1/ZLe1_2_pu);
Z_fault_3f_e(16, 3) = Z_fault_3f_e(3, 16);

%Calculate the fault equivalent impendance at the point of fault
Z_fault2 = Z_fault_3f_e \ eye(size(Z_fault_3f_e)); %[output:5d46006d]

fprintf("The grid fault impendance at the point 16 is:") %[output:245dfc12]
Z_fault2(16, 16) %[output:913c1e5d]

I_fault_grid_pu = abs(1/Z_fault2(16, 16)) %[output:11b1f05d]
I_fault_grid_pu*(100e6/(sqrt(3)*380)) %[output:849d6518]
%From B1 source
I_fault_b1 =  I_base_66kv*(3936.479 / I_base_66kv)*1.1 %[output:76651de7]
I_fault_b2 = I_base_66kv*(3936.479 / I_base_66kv)*1.1 %[output:4cdbb90d]
I_fault_a38a = I_base_66kv*(1968.2 / I_base_66kv)*abs(1.1*((Z1_Le_ON_pu + Z_grid_pu / (Z1_Le_ON_pu + Z_grid_pu + ZLe1_pu)))) %[output:8948f3db]
I_fault_a38b = I_base_66kv*(1968.2 / I_base_66kv)*abs(1.1*((Z1_Le_ON_pu + Z_grid_pu / (Z1_Le_ON_pu + Z_grid_pu + ZLe1_pu)))) %[output:8348d3a2]
I_fault_37 = I_base_66kv*(1968.2 / I_base_66kv)*abs(1.1*((Z1_Le_ON_pu + Z_grid_pu / (Z1_Le_ON_pu + Z_grid_pu + ZLe1_pu)))) %[output:8ccd0509]
%%
%[text] ## Single phase to Earth fault calculation 
%Fault at feeder B1, %%error the fault point is after the delta connection,
%therefore there is not a return path via earth path!
I_fault_B1 = zeros(6, 6) %[output:6fb1238b]
I_base_66kv = Sbase / U_66kv %[output:2d893d2a]

I_fault_B1(1, 1) = I_base_66kv*(3936.479 / I_base_66kv)*1.1;


%Contribution from B2 current source
Z_indirect = ZTB1_pu + ZLe1_pu + Z_grid_pu %[output:53c16ddb]
Z_homo = 0 %[output:9938685b]
Z_direct = ZTB1_pu + Z_indirect + Z_homo %[output:53090f47]
ZLe1_pu + Z_grid_pu %[output:2a8822b3]
I_base_66kv = Sbase / U_66kv %[output:1eb19898]

I_fault = 1.1 *(655 / I_base_66kv)* (ZLe1_pu + Z_grid_pu) / ((ZLe1_pu + Z_grid_pu)+(ZTB1_pu + Z_indirect + Z_homo)) %[output:4322efb4]
abs(I_fault) %[output:69a9040c]
fprintf("The contribution of fault current from source 1 to feeder B2 is: %f02 pu", abs(I_fault)) %[output:709a5366]
% I_fault_B1(2, 1) = abs(I_fault)*I_base_66kv
I_fault_B1(2, 1) = 0;

%Contribution from A38a current source
Z_direct = ZLe1_pu + ZTB1_pu %[output:0f70782e]
Z_indirect = ZLe1_pu + ZTB1_pu + Z_grid_pu %[output:337056bd]
Z_homo = 0 %[output:6e595fa2]
I_fault = 1.1 * (655 / I_base_66kv) * (Z_grid_pu) / ((Z_direct + Z_indirect + Z_homo + Z_grid_pu)) %[output:7de53382]
fprintf("The contribution of fault current from source A38a to feeder B2 is: %f02 pu", abs(I_fault)) %[output:7c671131]
% I_fault_B1(3, 1) = abs(I_fault)*I_base_66kv
I_fault_B1(3, 1) = 0;

%Contribution from A38b current source
Z_direct = ZLe1_pu + ZTB1_pu %[output:5aed5471]
Z_indirect = ZLe1_pu + ZTB1_pu + Z_grid_pu %[output:04b2abce]
Z_homo = 0 %[output:2c726d74]
I_fault = 1.1 * (655 / I_base_66kv) * (Z_grid_pu) / ((Z_direct + Z_indirect + Z_homo + Z_grid_pu)) %[output:24793ebb]
fprintf("The contribution of fault current from source A38a to feeder B2 is: %f02 pu", abs(I_fault)) %[output:356e6fb8]
% I_fault_B1(4, 1) = abs(I_fault)*I_base_66kv
I_fault_B1(4, 1) = 0;

%Contribution from A37 current source
Z_direct = ZLe1_pu + ZTB1_pu %[output:5d70d80b]
Z_indirect = ZLe1_pu + ZTB1_pu + Z_grid_pu %[output:49483421]
Z_homo = 0 %[output:6270d2ae]
I_fault = 1.1 * (655 / I_base_66kv) * (Z_grid_pu) / ((Z_direct + Z_indirect + Z_homo + Z_grid_pu)) %[output:45bf3693]
fprintf("The contribution of fault current from source A38a to feeder B2 is: %f02 pu", abs(I_fault)) %[output:511546ff]
% I_fault_B1(5, 1) = abs(I_fault)*I_base_66kv
I_fault_B1(5, 1) = 0;
I_fault_B1 %[output:16a0b71a]


%%
%[text] ## Single phase to earth fault on Export Cable B1 

%%
%[text] ## From B1 current source to B1 Export cable

z_ll1 = Z0_Le_ON_pu + Z0_grid_pu
z_ll2 = Z0_Le2_pu + Z0_TA38a_pu
z_ll3 = Z0_Le2_pu + Z0_TA38b_pu
z_ll4 = Z0_Le3_pu + Z0_TA37_pu
z_ll5 = (z_ll1^-1 + z_ll2^-1 + z_ll3^-1 + z_ll4^-1)^-1
z_s = Z0_Le1_1_pu + z_ll5

z_ll6 = (Z0_TB1_pu^-1 + Z0_TB2_pu^-1)^-1
z_s2 = Z0_Le1_2_pu + z_ll6

z_ll7 = (z_s^-1 + z_s2^-1)^-1
Z_homopolar = z_ll7

%Yeah this is taking way too long, imma do it via admittance matrix
Z_B1 = zeros(5, 5)
Z_B1(1, 1) = 1 / (ZfLB1_pu + ZTB1_pu + ZLe1_2_pu);
% Z_B1(2, 2) = Z_B1(1, 1) + 1/(ZLe1_1_pu + Z1_Le_ON_pu + Z_grid_pu) + 1 / (Z0_Le_ON_pu + Z0_grid_pu) + 1 / ( ...
%     Z0_Le2_pu + Z0_TA38a_pu) + 1 / (Z0_Le2_pu + Z0_TA38b_pu) + 1 / (Z0_Le3_pu + Z0_TA37_pu) + 1 / (Z0_TB2_pu) + 1 / (Z0_TB1_pu)
Z_B1(2, 2) = Z_B1(1, 1) + 1 / (Z0_Le_ON_pu + Z0_grid_pu) + 1 / ( ...
    Z0_Le2_pu + Z0_TA38a_pu) + 1 / (Z0_Le2_pu + Z0_TA38b_pu) + 1 / (Z0_Le3_pu + Z0_TA37_pu) + 1 / (Z0_TB2_pu) + 1 / (Z0_TB1_pu)
Z_B1(3, 3) = 1 / (Z0_Le1_1_pu) + 1 / (Z0_Le1_2_pu + Z0_TB2_pu) + 1 / (Z0_Le1_2_pu)
Z_B1(4, 4) = 1 / (Z0_Le1_1_pu) + 1 / (Z0_Le_ON_pu + Z0_grid_pu) + 1 / (Z0_Le2_pu + Z0_TA38a_pu) + 1 / (Z0_Le2_pu + Z0_TA38b_pu) + 1 / (Z0_Le3_pu + Z0_TA37_pu)
Z_B1(5, 5) = 1 / (Z0_TB1_pu) + 1 / (Z0_TB2_pu) + 1 / (Z0_Le1_2_pu);

%Off-diagonal terms
Z_B1(1, 2) = -1 / (ZfLB1_pu + ZTB1_pu + ZLe1_1_pu);
Z_B1(2, 1) = Z_B1(1, 2);

Z_B1(2, 4) = - (1 / (Z0_Le_ON_pu + Z0_grid_pu) + 1 / (Z0_Le2_pu + Z0_TA38a_pu) + 1 / (Z0_Le2_pu + Z0_TA38b_pu) + 1 / (Z0_Le3_pu + Z0_TA37_pu));
Z_B1(4, 2) = Z_B1(2, 4);

Z_B1(2, 5) = -(1 / (Z0_TB1_pu) + 1 / (Z0_TB2_pu));
Z_B1(5, 2) = Z_B1(2, 5);

Z_B1(3, 4) = - (1 / (Z0_Le1_1_pu));
Z_B1(4, 3) = Z_B1(3, 4);

Z_B1(3, 5) = - (1 / (Z0_Le1_2_pu));
Z_B1(5, 3) = Z_B1(3, 5);

Z_fault_B1 = Z_B1 \ eye(size(Z_B1))
z1 = Z_fault_B1(2, 2)

z2 = ZLe1_1_pu + Z1_Le_ON_pu + Z_grid_pu

z3 = (z1^-1 + z2^-2)^-1

abs(z3)
fprintf("Fault current going throught the fault point: ")
abs(1.1 * (z2 / (z2 + z1)))

%%
%[text] ## From current source A38a to export cable

Z_A38a = zeros(7, 7);
Z_A38a(1, 1) = 1 / (ZfLA38a_pu + ZTA38a_pu + ZLe2_pu);
Z_A38a(2, 2) =  1 / (ZLe1_1_pu) + 1 / (Z0_TB1_pu) + 1 / (Z0_TB2_pu) + 1 / (Z0_grid_pu + Z0_Le_ON_pu) + 1 / (Z0_TA37_pu + Z0_Le3_pu) + 1 / (Z0_TA38b_pu) + 1 / (Z0_TA38a_pu);

% Z_A38a(3, 3) = Z_A38a(1, 1) + 1 / (ZLe1_1_pu) + 1 / (Z1_Le_ON_pu + Z_grid_pu);
Z_A38a(3, 3) = Z_A38a(1, 1) + 1 / (ZLe1_1_pu);

Z_A38a(4, 4) = 1 / (Z_grid_pu + Z1_Le_ON_pu + ZLe1_1_pu) + 1 / (Z0_Le1_2_pu) + 1 / (Z0_Le1_1_pu);
Z_A38a(5, 5) = 1 / (Z0_Le1_1_pu) + 1/(Z0_Le2_pu) + 1/(Z0_Le_ON_pu + Z0_grid_pu) + 1/(Z0_Le3_pu + Z0_TA37_pu);
Z_A38a(6, 6) = 1 / (Z0_Le2_pu)  + 1/(Z0_TA38a_pu) + 1/(Z0_TA38b_pu);
Z_A38a(7, 7) = 1 / (Z0_Le1_2_pu) + 1/(Z0_TB1_pu) + 1/(Z0_TB2_pu);

Z_A38a(1, 3) = -(1 / (ZfLA38a_pu + ZTA38a_pu + ZLe2_pu)); 
Z_A38a(3, 1) = Z_A38a(1, 3);

Z_A38a(3, 2) = -(1 / (ZLe1_1_pu));
Z_A38a(2, 3) = Z_A38a(3, 2);

Z_A38a(2, 7) = -(1/(Z0_TB1_pu) + 1/(Z0_TB2_pu));
Z_A38a(7, 2) = Z_A38a(2, 7);

Z_A38a(2, 5) = -(1/(Z0_Le_ON_pu + Z0_grid_pu) + 1/(Z0_Le3_pu + Z0_TA37_pu));
Z_A38a(5, 2) = Z_A38a(2, 5);

Z_A38a(6, 2) = -(1/(Z0_TA38a_pu) + 1/(Z0_TA38b_pu));
Z_A38a(2, 6) = Z_A38a(6, 2);

Z_A38a(4, 5) = -(1 / (Z0_Le1_1_pu));
Z_A38a(5, 4) = Z_A38a(4, 5);

Z_A38a(5, 6) = -(1/(Z0_Le2_pu));
Z_A38a(6, 5) = Z_A38a(5, 6);

Z_A38a(4, 7) = -(1/(Z0_Le1_2_pu));
Z_A38a(7, 4) = Z_A38a(4, 7);

Z_fault_A38a = Z_A38a \ eye(size(Z_A38a));
fprintf("The equivalent impendance value at the fault location is: ");
z1 = Z_fault_A38a(3, 3)
z2 = Z1_Le_ON_pu + Z_grid_pu
fprintf("Fault current");
abs(1.1 * (z2/(z1+z2)))

%%
%[text] ## From current source A37 to export cable
Z_A37 = zeros(6, 6);

Z_A37(1, 1) = 1 / (ZfLA37_pu + ZTA37_pu + ZLe3_pu);

% Z_A37(2, 2) = Z_A37(1, 1) + 1/(ZLe1_1_pu) + 1/(Z1_Le_ON + Z_grid_pu);
Z_A37(2, 2) = Z_A37(1, 1) + 1/(ZLe1_1_pu);

Z_A37(3, 3) = 1/(ZLe1_1_pu) + 1/(Z0_TB1_pu) + 1/(Z0_TB2_pu) + 1/(Z0_grid_pu + Z0_Le_ON_pu) + 1/(Z0_TA38a_pu + Z0_Le2_pu) + 1/(Z0_TA38b_pu + Z0_Le2_pu);
Z_A37(4, 4) = 1/(ZLe1_1_pu + Z1_Le_ON_pu + Z_grid_pu) + 1/(Z0_Le1_1_pu) + 1/(Z0_Le1_2_pu);
Z_A37(5, 5) = 1/(Z0_Le1_2_pu) + 1/(Z0_TB1_pu) + 1/(Z0_TB2_pu);
Z_A37(6, 6) = 1/(Z0_Le1_1_pu) + 1/(Z0_Le_ON_pu + Z0_grid_pu) + 1/(Z0_Le2_pu + Z0_TA38a_pu) + 1/(Z0_Le2_pu + Z0_TA38b_pu) + 1/(Z0_Le3_pu + Z0_TA37_pu);

Z_A37(1, 2) = -(1 / (ZfLA37_pu + ZTA37_pu + ZLe3_pu));
Z_A37(2, 1) = Z_A37(1, 2);

Z_A37(3, 2) = -(1/(ZLe1_1_pu));
Z_A37(2, 3) = Z_A37(3, 2);

Z_A37(3, 5) = -(1/(Z0_TB1_pu) + 1/(Z0_TB2_pu));
Z_A37(5, 3) = Z_A37(3, 5);

Z_A37(4, 5) = -(1/(Z0_Le1_2_pu));
Z_A37(5, 4) = Z_A37(4, 5);

Z_A37(4, 6) = -(1/(Z0_Le1_1_pu));
Z_A37(6, 4) = Z_A37(4, 6);

Z_A37(3, 6) = -(1/(Z0_Le_ON_pu + Z0_grid_pu) + 1/(Z0_Le2_pu + Z0_TA38a_pu) + 1/(Z0_Le2_pu + Z0_TA38b_pu) + 1/(Z0_Le3_pu + Z0_TA37_pu));
Z_A37(6, 3) = Z_A37(3, 6);

Z_fault_A37 = Z_A37 \ eye(size(Z_A37));
fprintf("The equivalent impendance value at the fault location is: ");
z1 = Z_fault_A37(2, 2)
z2 = Z1_Le_ON_pu + Z_grid_pu
fprintf("Fault current"); 
abs(1.1 * (z2/(z2+z1)))

%%
%[text] ## From the grid to Export cable
Z_from_grid = zeros(6, 6);

Z_from_grid(1, 1) = 1/(Z_grid_pu + Z1_Le_ON_pu + ZLe1_1_pu);
Z_from_grid(2, 2) = Z_from_grid(1, 1) + 1/(Z0_TB1_pu) + 1/(Z0_TB2_pu) + 1/(Z0_TA38a_pu) + 1/(Z0_TA38b_pu) + 1/(ZTA37_pu+Z0_Le3_pu);
Z_from_grid(3, 3) = 1/(Z0_Le_ON_pu + Z0_grid_pu) + 1/(Z0_Le1_1_pu) + 1/(Z0_Le2_pu) + 1/(Z0_Le3_pu + Z0_TA37_pu);
Z_from_grid(4, 4) = 1/(Z0_Le1_2_pu) + 1/(Z0_TB1_pu) + 1/(Z0_TB2_pu);
Z_from_grid(5, 5) = 1/(Z0_Le2_pu) + 1/(Z0_TA38a_pu) + 1/(Z0_TA38b_pu);
Z_from_grid(6, 6) = 1/(Z0_Le1_1_pu) + 1/(Z0_Le1_2_pu) + 1/(Z_grid_pu + Z1_Le_ON + ZLe1_1_pu);

Z_from_grid(1, 2) = -(1/(Z_grid_pu + Z1_Le_ON_pu + ZLe1_1_pu));
Z_from_grid(2, 1) = Z_from_grid(1, 2);

Z_from_grid(4, 2) = -(1/(Z0_TB1_pu) + 1/(Z0_TB2_pu));
Z_from_grid(2, 4) = Z_from_grid(4, 2);

Z_from_grid(4, 6) = -(1/(Z0_Le1_2_pu));
Z_from_grid(6, 4) = Z_from_grid(4, 6);

Z_from_grid(3, 6) = -(1/(Z0_Le1_1_pu));
Z_from_grid(6, 3) = Z_from_grid(3, 6);

Z_from_grid(3, 2) = -(1/(Z0_Le_ON_pu + Z0_grid_pu) + 1/(Z0_Le3_pu + Z0_TA37_pu));
Z_from_grid(2, 3) = Z_from_grid(3, 2);

Z_from_grid(3, 5) = -(1/(Z0_Le2_pu));
Z_from_grid(5, 3) = Z_from_grid(3, 5);

Z_from_grid(5, 2) = -(1/(Z0_TA38a_pu) + 1/(Z0_TA38b_pu));
Z_from_grid(2, 5) = Z_from_grid(5, 2);

Z_fault_from_grid = Z_from_grid \ eye(size(Z_from_grid));
z1 = Z_fault_from_grid(1, 1)
fprintf("Fault current"); 
abs(1 / (z1))

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
