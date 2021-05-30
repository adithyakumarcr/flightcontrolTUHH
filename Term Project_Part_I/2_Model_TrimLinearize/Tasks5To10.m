%% State space representation

load TrimState_1_LinearLonModel.mat
load MyTrimReports.mat
TrimState_1_Report
V_a= sqrt (110^2+11^2);     %u=110, w=11 from the report
LinearLonModel = ss2ss(LinearLonModel,blkdiag(1,1/V_a,1,1,1));

% Naming the states
LinearLonModel.StateName{1} = 'u';
LinearLonModel.StateName{2} = 'alpha';
LinearLonModel.StateName{3} = 'q';
LinearLonModel.StateName{4} = 'Theta';
LinearLonModel.StateName{5} = 'Alt';

% Adding Units
LinearLonModel.StateUnit{1} = 'm/s';
LinearLonModel.StateUnit{2} = 'rad';
LinearLonModel.StateUnit{3} = 'rad/s';
LinearLonModel.StateUnit{4} = 'rad';
LinearLonModel.StateUnit{5} = 'm';

% Overwrite LinLonModel
save ('TrimState_1_LinearLonModel.mat','LinearLonModel');

%% Phasor

LinearLonModel_Phasor = ss2ss(LinearLonModel,blkdiag(1,180/pi,180/pi,180/pi,1));

% State name
LinearLonModel_Phasor.StateName = LinearLonModel.StateName;

% Units
LinearLonModel_Phasor.StateUnit{1} = 'm/s';
LinearLonModel_Phasor.StateUnit{2} = 'rad';
% LinearLonModel_Phasor.StateUnit{3} = '?';
LinearLonModel_Phasor.StateUnit{4} = 'rad';
LinearLonModel_Phasor.StateUnit{5} = 'm';

%Save model

save ('TrimState_1_LinearLonModel_Phasor.mat','LinearLonModel_Phasor');

%% Task 8 (Computing Dynamic Properties)

[M,D] = eig(LinearLonModel.A);
lambda = eig(LinearLonModel.A); % vector of eigenvalues 
omega_n = abs(lambda) ; % vectors of natural frequencies     
zeta = -real(lambda)/omega_n; % vector of damping factors

%% Task 9

idx_sp  = [1 2];  % e.g. idx_sp = [1 4] --> indices of the eigenvalues within the vector of eigenvalues 'lambda' corresponding to the short period mode (sp) 
idx_ph  = [3 4];  % indices of the eigenvalues within the vector of eigenvalues 'lambda' corresponding to the phugoid mode (ph)  
idx_alt = [5];  % index of the eigenvalue within the vector of eigenvalues 'lambda' corresponding to the 'altitude mode'
 
figure(210); clf
polemap(LinearLonModel_Phasor,idx_sp,idx_ph,idx_alt)

%% Task 10: Plotting

figure(220); clf
phasor(LinearLonModel_Phasor,idx_sp), title('Phasor: Short Period Mode')
figure(221); clf
mode_resp(LinearLonModel_Phasor,idx_sp,[-0.3 0.8]), title('Time Response: Short Period Mode')
figure(222); clf
phasor(LinearLonModel_Phasor,idx_ph), title('Phasor: Phugoid Mode')
figure(223); clf
mode_resp(LinearLonModel_Phasor,idx_ph,[-0.3 0.8]), title('Time Response: Phugoid Mode')
figure(224); clf
phasor(LinearLonModel_Phasor,idx_alt), title('Phasor: Altitude Mode'),
figure(225); clf
mode_resp(LinearLonModel_Phasor,idx_alt,[-0.1 0.8]), title('Time Response: Altitude Mode')