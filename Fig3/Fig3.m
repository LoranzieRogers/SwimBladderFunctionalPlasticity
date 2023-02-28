%% Fig 3
% 
% The swim bladder affords greater saccular auditory sensitivity and 
% enhanced frequency bandwidth in nonreproductive males but not 
% reproductive males.
% 
% The following code will plot the iso-intensity and auditory threshold
% curves of nonreproductive (blue) and reproductive (red) male midshipman
% with intact (i.e., control; dark colors) or removed (light colors) swim
% bladders. 
% 
% written by: Loranzie Rogers
% email: loranzie@uw.edu
% date: February 27, 2023
% 

%% Clear all and set directory

clear all; close all; clc;                                                  % clear and close everything
dir = uigetdir();                                                           % set directory 
cd(dir)


%% Import data

f0 = 95:95:950;                                                             % test freqs

% Import spl (dB re: 1 uPa) data, calculate mean, and 95% C.I.

% non-reproductive control data
NRC = readmatrix('NRC.csv');                                  
NRCmean = mean(NRC,'omitnan');
NRCsem = std(NRC,'omitnan')/sqrt(length(NRC));
ts = tinv([0.025  0.975],length(NRC)-1);      
NRCci = NRCsem * ts(:,2);

% non-reprodutive SB removal data
NRR = readmatrix('NRR.csv');                                   
NRRmean = mean(NRR,'omitnan');
NRRsem = std(NRR,'omitnan')/sqrt(length(NRR));
ts = tinv([0.025  0.975],length(NRR)-1);      
NRRci = NRRsem * ts(:,2);

% reproductive control data
RC = readmatrix('RC.csv');                                  
RCmean = mean(RC,'omitnan');
RCsem = std(RC,'omitnan')/sqrt(length(RC));
ts = tinv([0.025  0.975],length(RC)-1);      
RCci = RCsem * ts(:,2);

% reprodutive SB removal data
RR = readmatrix('RR.csv');                                   
RRmean = mean(RR,'omitnan');
RRsem = std(RR,'omitnan')/sqrt(length(RR));
ts = tinv([0.025  0.975],length(RR)-1);      
RRci = RRsem * ts(:,2);


%% Plot all threshold curves

% Plot SPL threshold curves
plotSPL(f0,NRC)
plotSPL(f0,NRR)
plotSPL(f0,RC)
plotSPL(f0,RR)

%% Threshold difference

NRdifferenceSPL = abs(NRRmean-NRCmean);
RdiffSPL = abs(RRmean - RCmean);


%% Percent records

% Non-reproductive
NRCnumrecords = sum(~isnan(NRC),1);
NRCpercent = (NRCnumrecords./length(NRC)).*100;
NRRnumrecords = sum(~isnan(NRR),1);
NRRpercent = (NRRnumrecords./length(NRR)).*100;

% Reproductive
RCnumrecords = sum(~isnan(RC),1);
RCpercent = (RCnumrecords./length(RC)).*100;
RRnumrecords = sum(~isnan(RR),1);
RRpercent = (RRnumrecords./length(RR)).*100;


%% Figure code

figure(1); clf;

% NR SPL
subplot(2,3,1)                                                              % NR SPL plot
figure(1);
axis square
hold on
errorbar(f0,NRCmean,NRCci,'-ok','MarkerFaceColor',[0.05 0.35 0.6],'LineWidth',1.5,'MarkerSize',7.5);
errorbar(f0,NRRmean,NRRci,'-ok','MarkerFaceColor',[0.4 0.75 1],'LineWidth',1.5,'MarkerSize',7.5);
xlim([75 970]);
xticks(95:95:950);
ylim([115 155]);
yticks(115:10:155);
set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',10,'TickLength',[0.025 0.025],'LineWidth',1.5,'XMinorTick','off','YMinorTick','on');
xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
ylabel('SPL (dB re: 1 \muPa)','FontName','Arial','fontsize',10);
ax=gca;
ax.YAxis.MinorTickValues = 120:10:150;
xtickangle(45)
hold off
[~,icons] = legend('NR control (n = 12, 24)','NR removal (n = 12, 24)','box','off','location','southeast','FontName','Arial','fontsize',10);
icons = findobj(icons,'Type','patch'); 
set(icons, 'Markersize', 7.5);

% NR threshold difference
subplot(2,3,2)                                                              % NR PAL plot
axis square
hold on
plot(f0,NRdifferenceSPL,'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',7.5);
xlim([75 970]);
xticks(95:95:950);
ylim([0 12]);
yticks(0:2:12);
set(gca,'tickdir','out','box','off','TickLength',[0.025 0.025],'FontName','Arial','fontsize',10,'LineWidth',1.5,'XMinorTick','off','YMinorTick','off');
xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
ylabel('\Delta Threshold (dB re: \muPa)','FontName','Arial','fontsize',10);
a = refline([0 6]);
a.Color = 'k';
a.LineWidth = 1.5;
a.LineStyle = '--';
ax=gca;
ax.YAxis.MinorTickValues = 1:2:11;
xtickangle(45)
hold off


% NR percent records
subplot(2,3,3)
axis square
hold on
plot(f0,NRCpercent,'ok','MarkerFaceColor',[0.05 0.35 0.6],'LineWidth',1.5,'MarkerSize',7.5);
plot(f0,NRRpercent,'ok','MarkerFaceColor',[0.4 0.75 1],'LineWidth',1.5,'MarkerSize',7.5);
set(gca,'tickdir','out','box','off','TickLength',[0.025 0.025],'FontName','Arial','fontsize',10,'LineWidth',1.5,'XMinorTick','off','YMinorTick','on');
xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
ylabel('Records (%)','FontName','Arial','fontsize',10);
xlim([75 970]);
xticks(95:95:950);
ylim([0 100]);
yticks(0:10:100);
a = refline([0 75]);
b = refline([0 50]);
c = refline([0 25]);
a.Color = 'k';
a.LineWidth = 1.5;
a.LineStyle = '--';
b.Color = 'k';
b.LineWidth = 1.5;
b.LineStyle = '--';
c.Color = 'k';
c.LineWidth = 1.5;
c.LineStyle = '--';
ax = gca;
ax.YAxis.MinorTickValues = 5:10:95;
xtickangle(45)
hold off


% Rep SPL
subplot(2,3,4)                                                              
axis square
hold on
errorbar(f0,RCmean,RCci,'-ok','MarkerFaceColor',[0.6 0.05 0.05],'LineWidth',1.5,'MarkerSize',7.5);  %[0.1 0.5 0.75]
errorbar(f0,RRmean,RRci,'-ok','MarkerFaceColor',[1 0.05 0.05],'LineWidth',1.5,'MarkerSize',7.5);
xlim([75 970]);
xticks(95:95:950);
ylim([105 155]);
yticks(105:10:155);
set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',10,'TickLength',[0.025 0.025],'LineWidth',1.5,'XMinorTick','off','YMinorTick','on');
xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
ylabel('SPL (dB re: 1 \muPa)','FontName','Arial','fontsize',10);
ax=gca;
ax.YAxis.MinorTickValues = 110:10:155;
xtickangle(45)
hold off
[~,icons] = legend('Rep control (n = 12, 24)','Rep removal (n = 13, 24)','box','off','location','southeast','FontName','Arial','fontsize',10);
icons = findobj(icons,'Type','patch'); 
set(icons, 'Markersize', 7.5);


% Rep threshold difference
subplot(2,3,5)                                                              % NR PAL plot
axis square
hold on
plot(f0,RdiffSPL,'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',7.5);
set(gca,'tickdir','out','box','off','TickLength',[0.025 0.025],'FontName','Arial','fontsize',10,'LineWidth',1.5,'XMinorTick','off','YMinorTick','on');
xlim([75 970]);
xticks(95:95:950);
ylim([0 12]);
yticks(0:2:12);
xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
ylabel('\Delta Threshold (dB re: 1 \muPa)','FontName','Arial','fontsize',10);
a = refline([0 6]);
a.Color = 'k';
a.LineWidth = 1.5;
a.LineStyle = '--';
ax=gca;
ax.YAxis.MinorTickValues = 1:2:11;
xtickangle(45)
hold off


% Rep percent records
subplot(2,3,6)
axis square
hold on
plot(f0,RCpercent,'ok','MarkerFaceColor',[0.6 0.05 0.05],'LineWidth',1.5,'MarkerSize',7.5);
plot(f0,RRpercent,'ok','MarkerFaceColor',[1 0.05 0.05],'LineWidth',1.5,'MarkerSize',7.5);
set(gca,'tickdir','out','box','off','TickLength',[0.025 0.025],'FontName','Arial','fontsize',10,'LineWidth',1.5,'XMinorTick','off','YMinorTick','on');
xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
ylabel('Records (%)','FontName','Arial','fontsize',10);
xlim([75 970]);
xticks(95:95:950);
ylim([0 100]);
yticks(0:10:100);
a = refline([0 75]);
b = refline([0 50]);
c = refline([0 25]);
a.Color = 'k';
a.LineWidth = 1.5;
a.LineStyle = '--';
b.Color = 'k';
b.LineWidth = 1.5;
b.LineStyle = '--';
c.Color = 'k';
c.LineWidth = 1.5;
c.LineStyle = '--';
ax = gca;
ax.YAxis.MinorTickValues = 5:10:95;
xtickangle(45)
hold off

set(gcf,'Position',[285,366,852,500]);

