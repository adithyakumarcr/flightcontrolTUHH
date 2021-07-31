%% function to check step responses of a linear model
% checklinearmodel(model,t)
% inputs:   model -> linear system under investigation
%           t     -> time scale
% outputs:  figure only

% This function is provided as part of the term project for the class 
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function [] = checklinearmodel(model,t)

% get step responses
[sig,time] = step(model*blkdiag(deg2rad(-3),deg2rad(3),deg2rad(5),0.2),t); % the inputs deviations are scaled to -3° elevator deflection, 3° aileron deflection, 5° rudder deflection and 0.2 thrust lever command

% longitudinal motion
figure(400); clf
    subplot(3,2,1), plot(time,sig(:,4,1),'LineWidth',2), grid on, title('Input: $\Delta \delta_e$',"Interpreter","latex","FontSize",14), xlabel(''), ylabel('Output: $\tilde{u}$', "Interpreter","latex","FontSize",13)  
    subplot(3,2,2), plot(time,sig(:,4,4),'LineWidth',2), grid on, title('Input: $\Delta \delta_t$',"Interpreter","latex","FontSize",14), ylabel('')   
    subplot(3,2,3), plot(time,sig(:,2,1),'LineWidth',2), grid on, title(''), ylabel('Output: $\tilde{q}$', "Interpreter","latex","FontSize",13)
    subplot(3,2,4), plot(time,sig(:,2,4),'LineWidth',2), grid on, title(''), ylabel('')
    subplot(3,2,5), plot(time,sig(:,15,1),'LineWidth',2), grid on, title(''), xlabel('Time (s)'), ylabel('Output: $\tilde{\alpha}$', "Interpreter","latex","FontSize",13)
    subplot(3,2,6), plot(time,sig(:,15,4),'LineWidth',2), grid on, title(''), xlabel('Time (s)'), ylabel('')
    annotation('textbox', [0.35 0.99 0.1 0.02],'String','(Scaled) Step Inputs','LineStyle','none','Interpreter','latex','FontSize',13,'FitBoxToText','on');

% lateral directional motion
figure(401); clf
    subplot(3,2,1), plot(time,sig(:,1,2),'LineWidth',2), grid on, title('Input: $\Delta \delta_a$',"Interpreter","latex","FontSize",14), xlabel(''), ylabel('Output: $\tilde{p}$', "Interpreter","latex","FontSize",13)  
    subplot(3,2,2), plot(time,sig(:,1,3),'LineWidth',2), grid on, title('Input: $\Delta \delta_r$',"Interpreter","latex","FontSize",14), xlabel(''),
    subplot(3,2,3), plot(time,sig(:,7,2),'LineWidth',2), grid on, title(''), ylabel('Output: $\tilde{\Phi}$', "Interpreter","latex","FontSize",13)
    subplot(3,2,4), plot(time,sig(:,7,3),'LineWidth',2), grid on, title(''), ylabel('')
    subplot(3,2,5), plot(time,sig(:,3,2),'LineWidth',2), grid on, title(''), xlabel('Time (s)'), ylabel('Output: $\tilde{r}$', "Interpreter","latex","FontSize",13)
    subplot(3,2,6), plot(time,sig(:,3,3),'LineWidth',2), grid on, title(''), xlabel('Time (s)'), ylabel('')
    annotation('textbox', [0.35 0.99 0.1 0.02],'String','(Scaled) Step Inputs','LineStyle','none','Interpreter','latex','FontSize',13,'FitBoxToText','on');

%------------%
clear sig time