%% Trim specification

% all trim states refer to straight and level flight, i.e., the aircraft maintains altitude and attitude as well as its velocity  

MyTrimState_1.u     = 115;      % m/s
MyTrimState_1.q     = 0;        % rad/s
MyTrimState_1.Alt   = 4500;     % m

MyTrimState_2.q     = 0;        % rad/s
MyTrimState_2.Alt   = 8000;     % m
MyTrimState_2.Theta = 0.092;    % rad

MyTrimState_3.q     = 0;        % rad/s
MyTrimState_3.Alt   = 3000;     % m
MyTrimState_3.dt    = 0.45;     % -