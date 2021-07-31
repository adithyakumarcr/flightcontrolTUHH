%% function to run a simulink model and plot the outputs 
% []=simulate_lat(model,t,surface,Actuators)
% inputs:   model -> simulink model to run
%               t -> simulation time
%         surface -> control surface to look closer at
%       Actuators -> loads the 'Actuators'-struct
% outputs:  figure only

% This function is provided as part of the term project for the class
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function []=simulate_lat(model,t,surface,Actuators)

[out] = sim(model,t);  % USE CORRECT MODEL

figure(111); clf

subplot(2,2,2), plot(180/pi.*out.eom_check.OOmega_f.r,'k','linewidth',2), xlim([0;t]), grid,
subplot(2,2,3), plot(180/pi.*out.eom_check.PPhi.Phi,'k','linewidth',2), xlim([0;t]), grid,
if surface == 'da'
    subplot(2,2,1), plot(180/pi.*out.eom_check.OOmega_f.p,'k','linewidth',2), xlim([0;t]), hold on, plot(out.inp_check.Time,180/pi.*out.inp_check.Data(:,2),'k--','linewidth',1), grid, legend('$p$','$p_{cmd}$','Interpreter','latex','location','best'),
    subplot(2,2,4), plot(180/pi.*out.aero_check.AirData.beta,'k','linewidth',2), xlim([0;t]), grid,
elseif surface == 'dr'
    subplot(2,2,1), plot(180/pi.*out.eom_check.OOmega_f.p,'k','linewidth',2), xlim([0;t]), grid,
    subplot(2,2,4), plot(180/pi.*out.aero_check.AirData.beta,'k','linewidth',2), xlim([0;t]), hold on, plot(out.inp_check.Time,180/pi.*out.inp_check.Data(:,3),'k--','linewidth',1), legend('$\beta$','$\beta_{cmd}$','Interpreter','latex','location','best'), grid,
else
    disp('wrong input(s)')
end

figure(112); clf

if surface == 'da'
    plot(180/pi.*out.cmd_check.cmd_da,'k--','linewidth',1), xlim([0;t]), hold on, plot(180/pi.*out.act_check.da,'color',[0,0,0],'linewidth',2), plot([0:1:t],180/pi.*[min(Actuators.Limits.u_max_Ha).*ones(1,(t+1))],'r-.','linewidth',2),  plot([0:1:t],180/pi.*[max(Actuators.Limits.u_max_Ha).*ones(1,(t+1))],'r-.','linewidth',2), legend('$\delta_{a,cmd}$','$\delta_a$','saturation','Interpreter','latex','location','best'), grid
elseif surface == 'dr'
    plot(180/pi.*out.cmd_check.cmd_dr,'k','linewidth',2), xlim([0;t]), hold on, plot(180/pi.*out.act_check.dr,'color',[0.75,0.75,0.75],'linewidth',2), plot([0:1:t],180/pi.*[min(Actuators.Limits.u_max_Hr).*ones(1,(t+1))],'r-.','linewidth',2), plot([0:1:t],180/pi.*[max(Actuators.Limits.u_max_Hr).*ones(1,(t+1))],'r-.','linewidth',2), legend('$\delta_{r,cmd}$','$\delta_r$','saturation','Interpreter','latex','location','best'), grid
else
    disp('wrong input(s)')
end
clear out