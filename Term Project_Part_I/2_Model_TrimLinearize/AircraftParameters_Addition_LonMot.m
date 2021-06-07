%% Additional Aircraft Parameters

% initialize structs
Actuators.Limits = [];
Actuators.Delays = [];

%% Actuators:

% elevator
Actuators.Limits.u_max_He = [-0.3115,0.2332]; %maximum and minimum elevator deflection in "rad"

Actuators.Act_e = ss(-21.2760, 21.2760, 1, 0);  % elevator dynamics
Actuators.Act_e.InputName = 'cmd_de';
Actuators.Act_e.OutputName = 'de';
Actuators.Act_e.InputUnit = 'rad';
Actuators.Act_e.OutputUnit = 'rad';

Actuators.Delays.tau_de = 0.033;    % time delay of elevator in "s"
Actuators.Act_e.InputDelay = Actuators.Delays.tau_de; % add time delay as input delay to ss model of elevator


%% Propulsion:

Propulsion.Act_t = ss(-0.5450, 0.5450, 1, 0);   % engine dynamics
Propulsion.Act_t.InputName = 'cmd_dt';
Propulsion.Act_t.OutputName = 'X_Pi';
Propulsion.Act_t.InputUnit = '-';
Propulsion.Act_t.OutputUnit = 'N';

Propulsion.Delays.tau_dt = 0.45;            % engine time delay in "s"
Propulsion.Act_t.InputDelay = Propulsion.Delays.tau_dt;  % add time delay as input delay to ss model of engine