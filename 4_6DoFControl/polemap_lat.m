%% function to create polemap_lat
% polemap_lat(model,idx_rs,idx_dr,idx_sl)
% inputs:   model   -> model for which the poles shall be computed and ploted
%           idx_rs  -> index of the roll subsidence pole within the vector 'lambda' containing the eigenvalues of 'model'
%           idx_dr  -> index of the dutch roll poles within the vector 'lambda' containing the eigenvalues of 'model'
%           idx_sl  -> index of the spiral pole within the vector 'lambda' containing the eigenvalues of 'model'
% outputs:  figure only

% This function is provided as part of the term project for the class 
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function [] = polemap_lat(model,idx_rs,idx_dr,idx_sl)

    [P,~] = pzmap(model);
    ph1 = plot(real(P(idx_rs)),imag(P(idx_rs)),'x','LineWidth',3,'MarkerSize',12);
    hold on;
    ph2 = plot(real(P(idx_dr)),imag(P(idx_dr)),'x','LineWidth',3,'MarkerSize',12);
    ph3 = plot(real(P(idx_sl)),imag(P(idx_sl)),'x','LineWidth',3,'MarkerSize',12);
    ylim([-0.1 4])
    xlim([-4 0.5])
    sgrid(0:0.1:0.9,0:0.5:4)
    legend([ph1,ph2,ph3],'Roll Subsidence', 'Dutch Roll', 'Spiral','Location','West');
    xlabel('Real Part')
    ylabel('Imaginary Part')
    title('Pole Map')
end