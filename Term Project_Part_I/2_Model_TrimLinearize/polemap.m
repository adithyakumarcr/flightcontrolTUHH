%% function to create polemap
% polemap(model,idx_sp,idx_ph,idx_alt)
% inputs:   model   -> model for which the poles shall be computed and ploted
%           idx_sp  -> index of the short period poles within the vector 'lambda' containing the eigenvalues of 'model'
%           idx_ph  -> index of the phugoid poles within the vector 'lambda' containing the eigenvalues of 'model'
%           idx_alt -> index of the 'Alt' pole within the vector 'lambda' containing the eigenvalues of 'model'
% outputs:  figure only

% This function is provided as part of the term project for the class 
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function [] = polemap(model,idx_sp,idx_ph,idx_alt)

    [P,~] = pzmap(model);
    ph1 = plot(real(P(idx_sp)),imag(P(idx_sp)),'x','LineWidth',3,'MarkerSize',12);
    hold on;
    ph2 = plot(real(P(idx_ph)),imag(P(idx_ph)),'x','LineWidth',3,'MarkerSize',12);
    ph3 = plot(real(P(idx_alt)),imag(P(idx_alt)),'x','LineWidth',3,'MarkerSize',12);
    ylim([-0.1 2.9])
    xlim([-2.9 0.1])
    sgrid(0:0.1:0.9,0:0.25:2.75)
    legend([ph1,ph2,ph3],'Short Period', 'Phugoid', 'Altitude','Location','West');
    xlabel('Real Part')
    ylabel('Imaginary Part')
    title('Pole Map')
end