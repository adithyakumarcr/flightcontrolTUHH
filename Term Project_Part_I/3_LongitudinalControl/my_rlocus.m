%% function to create root locus plots for specific i/o
% my_rlocus(sys,output,input,color)
% inputs:   sys -> system to be investigated
%           output -> output of the system as a string, e.g. 'output_1' , note: only one output allowed
%           input -> input to the system as a string, e.g. 'input_1' , note: only one input allowed
%           color -> color of the root locus plot
% outputs:  figure only

% This function is provided as part of the term project for the class
% "Flight Control Law Design and Application" at TU Hamburg.
% by Julian Theis and Nicolas Sedlmair, 2021

function [] = my_rlocus(sys,output,input,color)

sys_rl = pade(sys(output,input),2);
[R2,~] = rlocus(-sys_rl(output,input));

ph2 = plot(real(R2'),imag(R2'),'k',real(R2'),imag(R2'),'color',color,'LineWidth',2 );
hold on 
ph3= plot(real(R2(:,1)),imag(R2(:,1)),'k+','LineWidth',3,'MarkerSize',12);

ylim([-0.1 10.0])
xlim([-5.5 0.1])
sgrid(0:0.1:1,0:0.5:15)

xlabel('Real Part')
ylabel('Imaginary Part')