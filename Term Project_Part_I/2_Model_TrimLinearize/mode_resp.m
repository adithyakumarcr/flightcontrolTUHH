%% function to create mode response
% mode_resp(model,idx,ylimits)
% inputs:   model   -> linear system under investigation
%           idx     -> indizes corresponding to the the dynamic mode of interest, e.g. 'idx_sp' for the short period mode
%           ylimits -> limit the y-axis of the plot, e.g. [-0.1 0.9]
% outputs:  figure only

% This function is provided as part of the term project for the class 
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function [] = mode_resp(model,idx,ylimits)

[M,~] = eig(model.a); % compute the modal matrix of the linear system under investigation (columns are the right eigenvectors of the system)

[X,T] = initial(model,M(:,idx(1))); % compute free response of the model: note that the first entry of 'idx' determines the dynamic mode as it defines the (right) eigenvector of the system to investigate
X = real(X(:,[2 8 1 4 6])); % take only real part of the outputs of interest, i.e. the vector [2 8 1 4 6] picks the desired outputs of the model (see 'OutputNames' of the model) and changes the order
X = X.*[1 180/pi 180/pi 180/pi 1]; % transform 'rad' --> '°' and 'rad/s' --> '°/s' , maintain 'm' and 'm/s'
plot(T,X,'-','LineWidth',3);
legend('u (m/s)','\alpha (°)', 'q (°/s)', '\Theta (°)','Alt (m)','Location','best')
xlabel('Time (s)')
ylim(ylimits)
grid
clear X T
end