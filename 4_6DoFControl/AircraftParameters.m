%% Aircraft Model Parameters

% defines the interfaces
load BusObjects.mat

% Constants for earth geoid model (used for position on earth)
CNT_a = 6378137;
CNT_f = 0.003352810664747;

%% Trim Point

%TrimPoint.States.debar = deg2rad(-6.8640);
TrimPoint.States.debar = -0.143;
%TrimPoint.States.dabar = 0;;
TrimPoint.States.dabar = -6.3e-19;
%TrimPoint.States.drbar = 0;
TrimPoint.States.drbar =  4.69e-18;
%TrimPoint.States.dtbar = 0.185;
TrimPoint.States.dtbar = 0.343;

%TrimPoint.States.X_P = 2000;
TrimPoint.States.X_P = 5.49e+03;

%TrimPoint.States.Phibar   = 0; 
TrimPoint.States.Phibar   = 0;
%TrimPoint.States.Thetabar = deg2rad(4);
TrimPoint.States.Thetabar = 0.10798;
%TrimPoint.States.Psibar   = deg2rad(60);
TrimPoint.States.Psibar   = 1.57 ;

%TrimPoint.States.Latbar   = deg2rad(53.58715);
TrimPoint.States.Latbar   =  -3.17e+05;
%TrimPoint.States.Lonbar   = deg2rad(9.89862);
TrimPoint.States.Lonbar   = 0.17276;
%TrimPoint.States.Altbar   = 3000;
TrimPoint.States.Altbar   = 4500;

%TrimPoint.States.ubar = 120*cos(TrimPoint.States.Thetabar);
TrimPoint.States.ubar = 115;
%TrimPoint.States.vbar =   0;
TrimPoint.States.vbar =   6.13e-17;
%TrimPoint.States.wbar = 120*sin(TrimPoint.States.Thetabar);  
TrimPoint.States.wbar = 12.4174;

TrimPoint.States.pbar = 0;
TrimPoint.States.qbar = 0;
TrimPoint.States.rbar = 0;

%% Inertia:

% Tensor:

Ixx = 105390; % inertia around body-fixed x axis in "kg*m^2"
Iyy = 280790; % inertia around body-fixed y axis in "kg*m^2"
Izz = 350200; % inertia around body-fixed z axis in "kg*m^2"
Ixz = 15539;  % product of inertia in "kg*m^2"

% Mass:

CNT_g = [0;0;9.81]; % Gravitational acceleration vector 
CNT_m = 15917;      % aircraft mass in "kg"

%% Propulsion:

Propulsion.Act_t = ss(-0.5450, 0.5450, 1, 0);  % engine dynamics
Propulsion.Act_t.InputName = 'cmd_dt';
Propulsion.Act_t.OutputName = 'X_Pi';
Propulsion.Act_t.InputUnit = '-';
Propulsion.Act_t.OutputUnit = 'N';

Propulsion.Delays.tau_dt = 0.45;            % engine time delay in "s"
Propulsion.Act_t.InputDelay = Propulsion.Delays.tau_dt;  % add time delay as input delay to ss model of engine

% ---- Look-up table to compute thrust ----%
Propulsion.LUT.LUT_dt  = [-0.8:0.1:1];  % in "-" (normalized)
Propulsion.LUT.LUT_Alt = [2000;8000];   % in "m"
Propulsion.LUT.LUT_V_A = [90;200];      % in "m/s"

k = 1.04;   % temporary skaling factor
Propulsion.LUT.LUT_X_P(:,:,1)=k.*[1640,-343;2816,1244];
Propulsion.LUT.LUT_X_P(:,:,2)=k.*[1640,-343;2816,1244];
Propulsion.LUT.LUT_X_P(:,:,3)=k.*[1640,-343;2816,1244];
Propulsion.LUT.LUT_X_P(:,:,4)=k.*[2077,-85;2816,1244];
Propulsion.LUT.LUT_X_P(:,:,5)=k.*[3386,1032;3475,1833];
Propulsion.LUT.LUT_X_P(:,:,6)=k.*[4607,2042;4335,2610];
Propulsion.LUT.LUT_X_P(:,:,7)=k.*[6044,3268;5061,3263];
Propulsion.LUT.LUT_X_P(:,:,8)=k.*[7511,4452;5977,4119];
Propulsion.LUT.LUT_X_P(:,:,9)=k.*[9174,5983;6870,4932];
Propulsion.LUT.LUT_X_P(:,:,10)=k.*[10744,7271;7687,5669];
Propulsion.LUT.LUT_X_P(:,:,11)=k.*[12458,8892;8518,6478];
Propulsion.LUT.LUT_X_P(:,:,12)=k.*[14574,10806;9442,7423];
Propulsion.LUT.LUT_X_P(:,:,13)=k.*[16780,12799;10179,8397];
Propulsion.LUT.LUT_X_P(:,:,14)=k.*[18736,14701;10875,9215];
Propulsion.LUT.LUT_X_P(:,:,15)=k.*[20883,16795;11509,9982];
Propulsion.LUT.LUT_X_P(:,:,16)=k.*[22384,18750;12105,10744];
Propulsion.LUT.LUT_X_P(:,:,17)=k.*[23705,20108;12712,11434];
Propulsion.LUT.LUT_X_P(:,:,18)=k.*[25050,21432;13323,12079];
Propulsion.LUT.LUT_X_P(:,:,19)=k.*[26243,22779;13933,12728];
clear k
% -----------------------------------------%

Propulsion.rr_P1_f = [-1.448;-3;-0.533];   % location of left engine wrt. cg: [x,y,z] in "m"
Propulsion.rr_P2_f = [-1.448; 3;-0.533];   % location of right engine wrt. cg: [x,y,z] in "m"
Propulsion.CNT_kappa = 3*pi/180;        % engine inclination angle in "rad"

%% Actuators:

% initialize structs
Actuators.Limits = [];
Actuators.RateLimits = [];
Actuators.Delays = [];

%% Actuators:

% elevator
Actuators.Limits.u_max_He = [-0.3115,0.2332]; %maximum and minimum elevator deflection in "rad"
Actuators.RateLimits.udot_max_He = [-0.85,0.85]; %maximum and minimum elevator deflection rate in "rad/s"

Actuators.Act_e = ss(-21.2760, 21.2760, 1, 0);  % elevator dynamics
Actuators.Act_e.InputName = 'cmd_de';
Actuators.Act_e.OutputName = 'de';
Actuators.Act_e.InputUnit = 'rad';
Actuators.Act_e.OutputUnit = 'rad';
Actuators.Act_e.StateName = 'de';
Actuators.Act_e.StateUnit = 'rad';

Actuators.Delays.tau_de = 0.033;    % time delay of elevator in "s"
Actuators.Act_e.InputDelay = Actuators.Delays.tau_de; % add time delay as input delay to ss model of elevator

% ---------------------------------------------------------------%

% aileron
Actuators.Limits.u_max_Ha = [-0.18,0.18]; %maximum and minimum aileron deflection in "rad"
Actuators.RateLimits.udot_max_Ha = [-0.4,0.4]; %maximum and minimum aileron deflection rate in "rad/s"

Actuators.Act_a = ss(-36.0248, 36.0248, 1, 0);  % aileron dynamics
Actuators.Act_a.InputName = 'cmd_da';
Actuators.Act_a.OutputName = 'da';
Actuators.Act_a.InputUnit = 'rad';
Actuators.Act_a.OutputUnit = 'rad';
Actuators.Act_a.StateName = 'da';
Actuators.Act_a.StateUnit = 'rad';

Actuators.Delays.tau_da = 0.041;    % time delay of aileron in "s"
Actuators.Act_a.InputDelay = Actuators.Delays.tau_da; % add time delay as input delay to ss model of aileron

% ---------------------------------------------------------------%

% rudder
Actuators.Limits.u_max_Hr = [-0.407,0.407]; %maximum and minimum aileron deflection in "rad"
Actuators.RateLimits.udot_max_Hr = [-0.8,0.8]; %maximum and minimum aileron deflection rate in "rad/s"

Actuators.Act_r = ss(-15.6734,  15.6734,  1, 0);  % rudder dynamics
Actuators.Act_r.InputName = 'cmd_dr';
Actuators.Act_r.OutputName = 'dr';
Actuators.Act_r.InputUnit = 'rad';
Actuators.Act_r.OutputUnit = 'rad';
Actuators.Act_r.StateName = 'dr';
Actuators.Act_r.StateUnit = 'rad';

Actuators.Delays.tau_dr = 0.044;    % time delay of aileron in "s"

Actuators.Act_r.InputDelay = Actuators.Delays.tau_dr; % add time delay as input delay to ss model of aileron

%% Aerodynamics:

Aerodynamics.S = 62.4;      % reference area in "m^2"
Aerodynamics.cbar = 3.36;   % mean aerodynamic chord in "m"

Aerodynamics.LUT_rho = [1.16438645958276, 1.05543269917814, 0.954457178414045, 0.861045612606227, 0.774795981693757	0.695318454434115, 0.622235311201119, 0.555180865323805, 0.493801382899880, 0.437755001012510, 0.386711644273802, 0.340352939612400];
Aerodynamics.LUT_Alt = [0:1000:11000];

Aerodynamics.Ca_L0 = 0.071;  % lift 
Aerodynamics.Ca_La = 4.55;
Aerodynamics.Ca_Lq = 8.27; 
Aerodynamics.Ca_Lde = 0.406;

Aerodynamics.Ca_D0 = 0.01;  % drag
Aerodynamics.Ca_Da = 0.22;
Aerodynamics.Ca_Da2 = 0.67;
Aerodynamics.Ca_Db2 = 0.041; % (LDM only)

Aerodynamics.Ca_Yb = -0.82;  % side force (LDM only)
Aerodynamics.Ca_Ydr = 0.126;
Aerodynamics.Ca_Yp = 0;
Aerodynamics.Ca_Yr = 0.0128;

Aerodynamics.Ca_lb = -0.43; % roll moment (LDM only)
Aerodynamics.Ca_lp = -11.53; 
Aerodynamics.Ca_lr = 4.29;
Aerodynamics.Ca_lda = -0.44;
Aerodynamics.Ca_ldr = 0.051;

Aerodynamics.Ca_m0 = -0.14; % pitching moment
Aerodynamics.Ca_ma = -1.13;
Aerodynamics.Ca_mq = -9.94;
Aerodynamics.Ca_mde = -1.88;

Aerodynamics.Ca_nb = 0.75;  % yaw moment (LDM only)
Aerodynamics.Ca_np = 0.30; 
Aerodynamics.Ca_nr = -6.68;
Aerodynamics.Ca_nda = 0.023;
Aerodynamics.Ca_ndr = -0.167;