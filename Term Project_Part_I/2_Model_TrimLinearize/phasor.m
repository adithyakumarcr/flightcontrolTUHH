%% function to create phasor diagrams
% phasor(model,idx)
% inputs:   model -> linear system under investigation
%           idx   -> indices corresponding to the the dynamic mode of interest, e.g. 'idx_sp' for the short period mode
% outputs:  figure only

% This function is provided as part of the term project for the class 
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function [] = phasor(model,idx)

[M,~] = eig(model.a); % compute the modal matrix of the linear system under investigation (columns are the right eigenvectors of the system)

    for ii=1:size(M,1) % note that the modal matrix comprising the right eigenvectors of the system contain all the information required
        polarplot([0 angle(M(ii,idx(1)))],[0 abs(M(ii,idx(1)))],'-*','LineWidth',3); % note that only the eigenvector corresponding to the eigenvalue with imag(lambda)>0 is chosen, i.e. the first index in 'idx'
        hold on
    end
    ch = gca;
    ch.ThetaZeroLocation = 'top';
    ch.ThetaTickLabel = {'0','30','60','90','120','150','-180','-150','-120','-90','-60','-30'};
    if size(M,1)==5
        legend('u (m/s)','\alpha (°)', 'q (°/s)', '\Theta (°)', 'Alt (m)','Location','best')
    elseif size(M,1)==4
        legend('u (m/s)','\alpha (°)', 'q (°/s)', '\Theta (°)','Location','best')
    end
clear M
end