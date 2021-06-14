%% function to create bode plots for specific i/o
% my_bode_plot(outputs,input,sys1,sys2,sys3)
% inputs:   outputs -> outputs of the system as an array of strings, e.g. {'signal_1','signal_2',...}
%           input -> input to the system as a string, e.g. 'input_1' , note: only one input allowed
%           sys1 (2,3) -> linear system(s) under investigation, note: maximum 3 systems allowed
% outputs:  figure only

% This function is provided as part of the term project for the class
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function [] = my_bode_plot(outputs,input,sys1,sys2,sys3)

bodeopt = bodeoptions;
bodeopt.PhaseMatching = 'on';
bodeopt.PhaseMatchingFreq = 1;

ns = nargin()-2;
no = numel(outputs);

switch ns
    case 3
        for ii=1:1:no
        [mag1,phase1,omega1] = bode(sys1(outputs,input),logspace(-3,2,200));
        mag1=20*log10(mag1(:));phase1=phase1(:);
        [mag2,phase2,omega2] = bode(sys2(outputs,input),logspace(-3,2,200));
        mag2=20*log10(mag2(:));phase2=phase2(:);
        [mag3,phase3,omega3] = bode(sys3(outputs,input),logspace(-3,2,200));
        mag3=20*log10(mag3(:));phase3=phase3(:);
        s1 = subplot(2,no,ii);
        semilogx(omega1,mag1(ii:no:end),omega2,mag2(ii:no:end),'--',omega3,mag3(ii:no:end),':','LineWidth',3); grid
        ylim([-60 50])
        xlabel('Frequency (rad/s)')
        ylabel('Magnitude (dB)')
        title(['Bode Plot: from:' input 'to:' outputs(ii)],'interpreter','none')
        s2 = subplot(2,no,ii+no);
        semilogx(omega1,phase1(ii:no:end),omega2,phase2(ii:no:end),'--',omega3,phase3(ii:no:end),':','LineWidth',3); grid
        yticks(-720:90:720)
        xlabel('Frequency (rad/s)')
        ylabel('Phase (°)')
        linkaxes([s1 s2],'x')
        xlim([1e-3,1e2])
        clear mag1 mag2 mag3 omega1 omega2 omega3 phase1 phase2 phase3
        end
        legend('sys1','sys2','sys3','Location','best')
    case 2
        for ii=1:1:no
        [mag1,phase1,omega1] = bode(sys1(outputs,input),logspace(-3,2,200));
        mag1=20*log10(mag1(:));phase1=phase1(:);
        [mag2,phase2,omega2] = bode(sys2(outputs,input),logspace(-3,2,200));
        mag2=20*log10(mag2(:));phase2=phase2(:);
        s1 = subplot(2,no,ii);
        semilogx(omega1,mag1(ii:no:end),omega2,mag2(ii:no:end),'--','LineWidth',3); grid
        ylim([-60 50])
        xlabel('Frequency (rad/s)')
        ylabel('Magnitude (dB)')
        title(['Bode Plot: from:' input 'to:' outputs(ii)],'interpreter','none')
        s2 = subplot(2,no,ii+no);
        semilogx(omega1,phase1(ii:no:end),omega2,phase2(ii:no:end),'--','LineWidth',3); grid
        yticks(-720:90:720)
        xlabel('Frequency (rad/s)')
        ylabel('Phase (°)')
        linkaxes([s1 s2],'x')
        xlim([1e-3,1e2])
        end
        legend('sys1','sys2','Location','best')
    case 1
        for ii=1:1:no
        [mag1,phase1,omega1] = bode(sys1(outputs,input),logspace(-3,2,200));
        mag1=20*log10(mag1(:));phase1=phase1(:);
        s1 = subplot(2,no,ii);
        semilogx(omega1,mag1(ii:no:end),'LineWidth',3); grid
        ylim([-60 50])
        xlabel('Frequency (rad/s)')
        ylabel('Magnitude (dB)')
        title(['Bode Plot: from:' input 'to:' outputs(ii)],'interpreter','none')
        s2 = subplot(2,no,ii+no);
        semilogx(omega1,phase1(ii:no:end),'LineWidth',3); grid
        yticks(-720:90:720)
        xlabel('Frequency (rad/s)')
        ylabel('Phase (°)')
        linkaxes([s1 s2],'x')
        xlim([1e-3,1e2])
        end
        legend('sys1','Location','best')
end
clear mag1 phase1 omega1 mag2 phase2 omega2 mag3 phase3 omega3 s1 s2 ns no bodeopt ii