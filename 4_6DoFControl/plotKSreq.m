%% function to plots the control sensitivity transfer function and the resp. requirements/limitations
% [] = plotKSreq(P,K,umax,dumax,R0)
% inputs:   P -> plant model
%           K -> controller
%        umax -> actuator deflection limit
%       dumax -> actuator rate limit
%          R0 -> amplitude of a sinusoid reference signal
% outputs:  figure only

% This function is provided as part of the term project for the class
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function varargout = plotKSreq(P,K,umax,dumax,R0)
%linestyle for plotting

[~,~,w] = bode(P);

cl = semilogx([w(1) w(end)],[mag2db(umax/R0) mag2db(umax/R0)],'LineWidth',3,'Color','r');
hold on
rl = semilogx([w(1) w(end)],[mag2db(dumax/(R0*w(1))) mag2db(dumax/(R0*w(end)))],'LineWidth',3,'LineStyle','--','Color','r');

L = P*K;
w1 = getGainCrossover(L,1); % cross over frequency 

%
[magKS,phaseKS,omegaKS] = bode(feedback(K,P),w);
magKS=20*log10(magKS(:));phaseKS=phaseKS(:);
sh = semilogx(omegaKS,magKS,'LineWidth',3,'LineStyle','-','Color','black');

grid on
%
ylims = ylim;
wL = semilogx([w1 w1],[ylims(1)-20 ylims(2)+20],'LineWidth',1.5,'Color','g','LineStyle',':');

phumax = patch([w1 w(1) w(1) w1],[ylims(2)+20 ylims(2)+20 mag2db(umax/R0) mag2db(umax/R0)],'r','FaceAlpha',0.15,'LineStyle','none');
phumax = patch([w1 w(end) w(end) w1],[ylims(2)+20 ylims(2)+20 mag2db(umax/R0) mag2db(umax/R0)],'y','FaceAlpha',0.15,'LineStyle','none');
phdumax = patch([w(end) w1 w1 w(end)],[ylims(2)+20 ylims(2)+20 mag2db(dumax/(R0*w1)) mag2db(dumax/(R0*w(end)))],'y','FaceAlpha',0.15,'LineStyle','none');
phdumax = patch([w(1) w1 w1 w(1)],[ylims(2)+20 ylims(2)+20 mag2db(dumax/(R0*w1)) mag2db(dumax/(R0*w(1)))],'r','FaceAlpha',0.15,'LineStyle','none');

%
set(gca,'YTick',-100:20:100);
xlabel('Frequency (rad/s)')
ylabel('Magnitude |K(j\omega)S(j\omega)|  (dB)')
xlim([w(1) w(end)])
ylim(ylims)

if nargout == 1
    varargout{1} = fh;
end

legend([cl rl wL],'saturation limit','rate limit','loop crossover frequency','Location','best')
end