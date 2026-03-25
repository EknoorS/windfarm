% This file has the purpose of declaring all the variables that are used 
% in the blocks 

%%Substation Cluster B

P_b_nom = 600e6;
P_a3_8_1_nom = 450e6;
P_a3_8_2_nom = 450e6;
P_a3_7_nom = 450e6;

Vac = 380e3;
Vnom = 66e3;


%% =====================================================
% EXPORT CABLE
% Given: Z1 = 0.1 + j0.1225 ohm/km, X0/X1 = 3
% Assumption: R0 = R1
% =====================================================

R1_Le_1 = 0.1;              % ohm/km
X1_Le_1 = 0.1225;           % ohm/km
R0_Le_1 = R1_Le_1;          % assumed
X0_Le_1 = 3 * X1_Le_1;      % ohm/km

R1_Le_2 = 0.1;
X1_Le_2 = 0.1225;
R0_Le_2 = R1_Le_2;
X0_Le_2 = 3 * X1_Le_2;

R1_Le_3 = 0.1;
X1_Le_3 = 0.1225;
R0_Le_3 = R1_Le_3;
X0_Le_3 = 3 * X1_Le_3;

% Simulink block needs L instead of X  
f = 50; % Hz
freq = 50;
w = 2*pi*f;

length_onshore = 150;
length_SM = 60; 

L1_Le_1 = X1_Le_1 / w;      % H/km
L0_Le_1 = X0_Le_1 / w;

L1_Le_2 = X1_Le_2 / w;
L0_Le_2 = X0_Le_2 / w;

L1_Le_3 = X1_Le_3 / w;
L0_Le_3 = X0_Le_3 / w;

C1_Le_1 = 0.42e-6;   % F/km
C1_Le_2 = 0.42e-6;   % F/km
C1_Le_3 = 0.42e-6;   % F/km

C0_Le_1 = C1_Le_1;   % approximation
C0_Le_2 = C1_Le_2;
C0_Le_3 = C1_Le_3;


%% ONSHORE 

R1_Le_ON = 0.1;              % ohm/km
X1_Le_ON = 0.1225;           % ohm/km
R0_Le_ON = R1_Le_ON;          % assumed
X0_Le_ON = 3 * X1_Le_ON;      % ohm/km


L1_Le_ON = X1_Le_ON / w;
L0_Le_ON = X0_Le_ON / w;

C1_Le_ON = 0.42e-6;   % F/km
C1_Le_ON = 0.42e-6;   % F/km
C1_Le_ON = 0.42e-6;   % F/km


C0_Le_ON = C1_Le_ON;   % approximation
C0_Le_ON = C1_Le_ON;
C0_Le_ON = C1_Le_ON;




%% =====================================================
% TRANSFORMERS (66 kV side)
% Given purely reactive values, X0/X1 = 2.4
% Assumption: R0 = R1 = 0
% =====================================================

R1_TB1 = 0.0025;
X1_TB1 = 1.0164;
R0_TB1 = R1_TB1;
X0_TB1 = 2.4 * X1_TB1;

R1_TB2 = 0.0025;
X1_TB2 = 1.0164;
R0_TB2 = R1_TB2;
X0_TB2 = 2.4 * X1_TB2;

R1_TA38a = 0.0025;
X1_TA38a = 1.3552;
R0_TA38a = R1_TA38a;
X0_TA38a = 2.4 * X1_TA38a;

R1_TA38b = 0.0025;
X1_TA38b = 1.3552;
R0_TA38b = R1_TA38b;
X0_TA38b = 2.4 * X1_TA38b;

R1_TA37 = 0.0025;
X1_TA37 = 2.7104;
R0_TA37 = R1_TA37;
X0_TA37 = 2.4 * X1_TA37;

% inductances
L1_TB1 = X0_TB1 / w;

L1_TB2 = X1_TB2 / w;
L0_TB2 = X0_TB2 / w;

L1_TA38a = X1_TA38a / w;
L0_TA38a = X0_TA38a / w;

L1_TA38b = X1_TA38b / w;
L0_TA38b = X0_TA38b / w;

L1_TA37 = X1_TA37 / w;
L0_TA37 = X0_TA37 / w;


%% =====================================================
% FEEDER WIRES
% Given: Z1 values and X0/X1 = 3
% Assumption: R0 = R1
% =====================================================

R1_fLB1 = 0.244686;
X1_fLB1 = 0.153423;
R0_fLB1 = R1_fLB1;
X0_fLB1 = 3 * X1_fLB1;

R1_fLB2 = 0.20829138;
X1_fLB2 = 0.13060804;
R0_fLB2 = R1_fLB2;
X0_fLB2 = 3 * X1_fLB2;

R1_fLA38a = 0.3514672;
X1_fLA38a = 0.220373;
R0_fLA38a = R1_fLA38a;
X0_fLA38a = 3 * X1_fLA38a;

R1_fLA38b = 0.408561332;
X1_fLA38b = 0.2561899;
R0_fLA38b = R1_fLA38b;
X0_fLA38b = 3 * X1_fLA38b;

R1_fLA37 = 0.43514837;
X1_fLA37 = 0.27285307;
R0_fLA37 = R1_fLA37;
X0_fLA37 = 3 * X1_fLA37;

%inductances
L1_fLB1 = X1_fLB1 / w;
L0_fLB1 = X0_fLB1 / w;

L1_fLB2 = X1_fLB2 / w;
L0_fLB2 = X0_fLB2 / w;

L1_fLA38a = X1_fLA38a / w;
L0_fLA38a = X0_fLA38a / w;

L1_fLA38b = X1_fLA38b / w;
L0_fLA38b = X0_fLA38b / w;

L1_fLA37 = X1_fLA37 / w;
L0_fLA37 = X0_fLA37 / w;