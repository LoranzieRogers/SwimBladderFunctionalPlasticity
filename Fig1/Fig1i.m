%% Fig. 1i: morphospace analysis
%
%
% Written by: Loranzie S. Rogers
% email: loranzie@uw.edu
% Date: January 12, 2023
% 

% DISCRIPTION %
% 
% The following code takes in the PCA output from the GPA module of
% SlicerMorph, which is where morphospace analysis was conducted.
% 

%% Clear all and set directory

clear all; close all; clc;                                                  % clear and close everything
dir = uigetdir();                                                           % set directory 
% cd(dir)

%% Load data

pcs = readmatrix('pcScores.csv');

%% Plot data

figure(1); clf;
plot(pcs(1:8,2),pcs(1:8,3),'o','LineWidth',2,'MarkerFaceColor',[0.6 0.05 0.05],'MarkerEdgeColor','k','MarkerSize',12)
hold on
plot(pcs(9:end,2),pcs(9:end,3),'o','LineWidth',1.5,'MarkerFaceColor',[0.05 0.35 0.6],'MarkerEdgeColor','k','MarkerSize',12)
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',18,'LineWidth',2,'XMinorTick','off','YMinorTick','off');
xlim([-.2 .2])
xticks(-.2:.1:.2)
ylim([-.2 .2])
yticks(-.2:.1:.2)
xlabel('PC1 (53.5%)','FontName','Arial','fontsize',18);
ylabel('PC2 (9.1%)','FontName','Arial','fontsize',18);
axis square
set(gcf, "Position", [476,586,448,280])
hold off
