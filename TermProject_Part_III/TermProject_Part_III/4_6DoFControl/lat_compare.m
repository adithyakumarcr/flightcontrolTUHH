%% function to compare the aircraft's response for different stages of the LDM SAS
% [] = lat_compare(sys1,sys2,sys3)
% inputs:   sysx -> systems to be compared
% outputs:  figure only

% This function is provided as part of the term project for the class
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function [] = lat_compare(sys1,sys2,sys3)

ns = nargin();

switch ns
    case 2        
        [sig,t] = step(sys1({'p','r','beta'},{'cmd_da','cmd_dr'})*blkdiag(deg2rad(5),deg2rad(5)),10);
        [sig2,t2] = step(sys2({'p','r','beta'},{'cmd_da','cmd_dr'})*blkdiag(deg2rad(5),deg2rad(5)),10);
        
        subplot(3,2,1), plot(t,180/pi.*sig(:,1,1),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,1,1),'LineWidth',2), grid, title('Step Response from input: $\Delta \delta_a$',"Interpreter","latex","FontSize",14), ylabel('Output: $\tilde{p}$ in deg/s', "Interpreter","latex","FontSize",10), legend('w/o yaw damper','with yaw damper'), ...
        subplot(3,2,2), plot(t,180/pi.*sig(:,1,2),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,1,2),'LineWidth',2), grid, title('Step Response from input: $\Delta \delta_r$',"Interpreter","latex","FontSize",14), ...        
        subplot(3,2,3), plot(t,180/pi.*sig(:,2,1),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,2,1),'LineWidth',2), grid, ylabel('Output: $\tilde{r}$ in deg/s', "Interpreter","latex","FontSize",10), ...
        subplot(3,2,4), plot(t,180/pi.*sig(:,2,2),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,2,2),'LineWidth',2), grid, ...
        subplot(3,2,5), plot(t,180/pi.*sig(:,3,1),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,3,1),'LineWidth',2), grid, ylabel('Output: $\tilde{\beta}$ in deg', "Interpreter","latex","FontSize",10), xlabel('Time in s'), ...
        subplot(3,2,6), plot(t,180/pi.*sig(:,3,2),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,3,2),'LineWidth',2), grid, xlabel('Time in s'),
    
    case 3
        [sig,t] = step(sys1({'p','r','beta'},{'cmd_da','cmd_dr'})*blkdiag(deg2rad(5),deg2rad(5)),10);
        [sig2,t2] = step(sys2({'p','r','beta'},{'cmd_da','cmd_dr'})*blkdiag(deg2rad(5),deg2rad(5)),10);
        [sig3,t3] = step(sys3({'p','r','beta'},{'cmd_da','cmd_dr'})*blkdiag(deg2rad(5),deg2rad(5)),10);
        
        subplot(3,2,1), plot(t,180/pi.*sig(:,1,1),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,1,1),'LineWidth',2), plot(t3,180/pi.*sig3(:,1,1),'LineWidth',2), grid, title('Step Response from input: $\Delta \delta_a$',"Interpreter","latex","FontSize",14), ylabel('Output: $\tilde{p}$ in deg/s', "Interpreter","latex","FontSize",10), legend('w/o yaw damper','with yaw damper','with ARI'), ...
        subplot(3,2,2), plot(t,180/pi.*sig(:,1,2),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,1,2),'LineWidth',2), plot(t3,180/pi.*sig3(:,1,2),'LineWidth',2), grid, title('Step Response from input: $\Delta \delta_r$',"Interpreter","latex","FontSize",14), ...        
        subplot(3,2,3), plot(t,180/pi.*sig(:,2,1),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,2,1),'LineWidth',2), plot(t3,180/pi.*sig3(:,2,1),'LineWidth',2), grid, ylabel('Output: $\tilde{r}$ in deg/s', "Interpreter","latex","FontSize",10), ...
        subplot(3,2,4), plot(t,180/pi.*sig(:,2,2),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,2,2),'LineWidth',2), plot(t3,180/pi.*sig3(:,2,2),'LineWidth',2), grid, ...
        subplot(3,2,5), plot(t,180/pi.*sig(:,3,1),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,3,1),'LineWidth',2), plot(t3,180/pi.*sig3(:,3,1),'LineWidth',2), grid, ylabel('Output: $\tilde{\beta}$ in deg', "Interpreter","latex","FontSize",10), xlabel('Time in s'), ...
        subplot(3,2,6), plot(t,180/pi.*sig(:,3,2),'LineWidth',2), hold on, plot(t2,180/pi.*sig2(:,3,2),'LineWidth',2), plot(t3,180/pi.*sig3(:,3,2),'LineWidth',2), grid, xlabel('Time in s'),
        
end

clear t t2 t3 sig si2 sig3
 