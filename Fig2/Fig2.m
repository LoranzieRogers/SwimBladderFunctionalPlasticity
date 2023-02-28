%% Fig 2: Male midshipman exhibit seasonal changes in saccular hair cell auditory sensitivity
% 
% Iso-level response and auditory threshold curves recorded from saccular 
% hair cells of nonreproductive (blue) and reproductive (red) male 
% plainfin midshipman.
% 
% Written by: Loranzie Rogers
% email: loranzie@uw.edu
% Date: February 27, 2023
% 

%% Clear all and set directory

clear all; close all; clc;                                                  % clear and close everything
dir = uigetdir();                                                           % set directory 
cd(dir)


%% Test frequencies

f0 = 95:95:950;                                                             % test freqs


%% Set file location of iso-intensity data

FileLocation = uigetdir();


%% Iso-intensity data
% 
% Import data, convert to uV, and solve for mean, s.d., and s.e.m.
% 

% Nonreproductive control
NRC = dir(fullfile(FileLocation,'NRC-PN22*.xls'));
NRCfilenames = {NRC.name}; % all of the filenames in one cell array

for i = 1:numel(NRC)
    F = fullfile(FileLocation,NRC(i).name);
    NRC(i).Iso154 = readmatrix(F,'Sheet','154dB','Range','C1:J10');
    NRC(i).Iso142 = readmatrix(F,'Sheet','142dB','Range','C1:J10');
    NRC(i).Iso130 = readmatrix(F,'Sheet','130dB','Range','C1:J10');
end

% convert to uV
for i = 1:numel(NRC)
    NRC(i).Iso154 = NRC(i).Iso154*10000;
    NRC(i).Iso142 = NRC(i).Iso142*10000;
    NRC(i).Iso130 = NRC(i).Iso130*10000;
end

for i = 1:numel(NRC)
    NRCmean154(:,i) = mean(NRC(i).Iso154,2,'omitnan');
    NRCmean142(:,i) = mean(NRC(i).Iso142,2,'omitnan');
    NRCmean130(:,i) = mean(NRC(i).Iso130,2,'omitnan');
end

for i = 1:numel(NRC)
    NRCsd154(:,i) = std(NRC(i).Iso154,[],2,'omitnan');
    NRCsd142(:,i) = std(NRC(i).Iso142,[],2,'omitnan');
    NRCsd130(:,i) = std(NRC(i).Iso130,[],2,'omitnan');
end

for i = 1:numel(NRC)
    NRCsem154(:,i) = std(NRC(i).Iso154,[],2,'omitnan')/sqrt(length(NRC));
    NRCsem142(:,i) = std(NRC(i).Iso142,[],2,'omitnan')/sqrt(length(NRC));
    NRCsem130(:,i) = std(NRC(i).Iso130,[],2,'omitnan')/sqrt(length(NRC));
end


NRCmean = [mean(NRCmean154,2) mean(NRCmean142,2,'omitnan') mean(NRCmean130,2,'omitnan')];
NRCsd = [std(NRCmean154,[],2,'omitnan') std(NRCmean142,[],2,'omitnan') std(NRCmean130,[],2,'omitnan')];
NRCsem = [std(NRCmean154,[],2,'omitnan')/sqrt(length(NRCmean154)) std(NRCmean142,[],2,'omitnan')/sqrt(length(NRCmean142)) std(NRCmean130,[],2,'omitnan')/sqrt(length(NRCmean130))];


% Reproductive control
RC = dir(fullfile(FileLocation,'RC-PN22*.xls'));
RCfilenames = {RC.name}; % all of the filenames in one cell array

for i = 1:numel(RC)
    F = fullfile(FileLocation,RC(i).name);
    RC(i).Iso154 = readmatrix(F,'Sheet','154dB','Range','C1:J10');
    RC(i).Iso142 = readmatrix(F,'Sheet','142dB','Range','C1:J10');
    RC(i).Iso130 = readmatrix(F,'Sheet','130dB','Range','C1:J10');
end

% convert to uV
for i = 1:numel(RC)
    RC(i).Iso154 = RC(i).Iso154*10000;
    RC(i).Iso142 = RC(i).Iso142*10000;
    RC(i).Iso130 = RC(i).Iso130*10000;
end

for i = 1:numel(RC)
    RCmean154(:,i) = mean(RC(i).Iso154,2,'omitnan');
    RCmean142(:,i) = mean(RC(i).Iso142,2,'omitnan');
    RCmean130(:,i) = mean(RC(i).Iso130,2,'omitnan');
end

for i = 1:numel(RC)
    RCsd154(:,i) = std(RC(i).Iso154,[],2,'omitnan');
    RCsd142(:,i) = std(RC(i).Iso142,[],2,'omitnan');
    RCsd130(:,i) = std(RC(i).Iso130,[],2,'omitnan');
end

for i = 1:numel(RC)
    RCsem154(:,i) = std(RC(i).Iso154,[],2,'omitnan')/sqrt(length(RC));
    RCsem142(:,i) = std(RC(i).Iso142,[],2,'omitnan')/sqrt(length(RC));
    RCsem130(:,i) = std(RC(i).Iso130,[],2,'omitnan')/sqrt(length(RC));
end


RCmean = [mean(RCmean154,2) mean(RCmean142,2,'omitnan') mean(RCmean130,2,'omitnan')];
RCsd = [std(RCmean154,[],2,'omitnan') std(RCmean142,[],2,'omitnan') std(RCmean130,[],2,'omitnan')];
RCsem = [std(RCmean154,[],2,'omitnan')/sqrt(length(RCmean154)) std(RCmean142,[],2,'omitnan')/sqrt(length(RCmean142)) std(RCmean130,[],2,'omitnan')/sqrt(length(RCmean130))];


%% Fig 2d
% 
% Iso-intensity responses to biologically relevant pure tone playbacks at 
% sound pressure levels of 154, 142, and 130 dB re: 1 uPa, respectively. 
% Data are represented as mean +/- 1 SE; note that some error bars are 
% minimal, and the symbols may obscure the bars. 
% 

for i = 1:1:3
    figure(1)
    axis square
    subplot(1,3,i)
    errorbar(f0,NRCmean(:,i),NRCsem(:,i),'-ok','MarkerFaceColor',[0.05 0.35 0.6],'LineWidth',1.5,'MarkerSize',7.5);
    hold on
    errorbar(f0,RCmean(:,i),RCsem(:,i),'-ok','MarkerFaceColor',[0.6 0.05 0.05],'LineWidth',1.5,'MarkerSize',7.5);
    hold off
    xlim([75 970]);
    xticks(95:95:950);
    xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
    ylim([0 round((max(max(RCmean(:,i)))+(2*max(max(RCsem(:,i))))),2,"significant")]);   
    set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',10,'TickLength',[0.025 0.025],'LineWidth',1.5,'XMinorTick','off','YMinorTick','off');
    xtickangle(45)
    axis square
end

[~,icons] = legend('NR control (n = 12, 24)','Rep control (n = 12, 24)','box','off','location','bestoutside','FontName','Arial','fontsize',10);
icons = findobj(icons,'Type','patch'); 
set(icons, 'Markersize', 7.5); 

for i = 1
    Yplot = subplot(1,3,i);
    ylabel('Saccular potential (\muV)','FontName','Arial','fontsize',10);
end

%% Sound pressure level data
% 
% Import spl (dB re: 1 uPa) data, calculate mean, and 95% C.I.
% 

% nonreproductive control data
NRC = readmatrix('NRC.csv');                                  
NRCmean = mean(NRC,'omitnan');
NRCsem = std(NRC,'omitnan')/sqrt(length(NRC));
ts = tinv([0.025  0.975],length(NRC)-1);      
NRCci = NRCsem * ts(:,2);

% reproductive control data
RC = readmatrix('RC.csv');                                  
RCmean = mean(RC,'omitnan');
RCsem = std(RC,'omitnan')/sqrt(length(RC));
ts = tinv([0.025  0.975],length(RC)-1);      
RCci = RCsem * ts(:,2);


%% Visualize all threshold curves
%
% This is just for fun so one can see all of the thresholds curves
% recorded.
% 

plotSPL(f0,NRC)
plotSPL(f0,RC)


%% Fig 2e
% 
% Sound pressure level (dB re: 1 μPa) auditory threshold tuning curves 
% recorded from nonreproductive (blue) and reproductive (red) male 
% midshipman saccular hair cells. Thresholds were defined as the lowest 
% auditory stimulus level needed to evoke potentials at least 2 SD above 
% the background electrical noise level. All data are plotted as mean +/- 
% 95% confidence interval.
% 

figure(2); clf;
axis square
hold on
errorbar(f0,NRCmean,NRCci,'-ok','MarkerFaceColor',[0.05 0.35 0.6],'LineWidth',1.5,'MarkerSize',7.5); 
errorbar(f0,RCmean,RCci,'-ok','MarkerFaceColor',[0.6 0.05 0.05],'LineWidth',1.5,'MarkerSize',7.5);
xlim([45 1000]);
xticks(95:95:950);
ylim([105 155]);
yticks(105:10:155);
set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',10,'TickLength',[0.025 0.025],'LineWidth',1.5,'XMinorTick','off','YMinorTick','on');
xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
ylabel('SPL (dB re: 1 \muPa)','FontName','Arial','fontsize',10);
ax=gca;
ax.YAxis.MinorTickValues = 110:10:155;
xtickangle(45)
legend('NR control (n = 12, 24)','Rep control (n = 12, 24)','box','off','location','northeastoutside')
hold off
set(gcf,'Position',[476,681,384,185]);


%% Fig 2f
% 
% Saccular hair cell sound pressure threshold difference (dB re: 1 uPa) 
% between reproductive and nonreproductive male midshipman.
% 

ReproductiveStateDiff = NRCmean - RCmean;

figure(3); clf;
axis square
hold on
plot(f0,ReproductiveStateDiff,'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',7.5);
xlim([75 970]);
xticks(95:95:950);
ylim([0 8]);
yticks(0:1:8);
set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',10,'TickLength',[0.025 0.025],'LineWidth',1.5,'XMinorTick','off','YMinorTick','off');
ylabel('\Delta Threshold (dB re: 1 \muPa)','FontName','Arial','fontsize',10);
xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
xtickangle(45)
hold off
set(gcf,'Position',[476,681,384,185]);


%% Fig 2g
% 
% Percentage of saccular potential recordings that displayed evoked 
% potential thresholds above background electrical noise levels at each 
% frequency tested for nonreproductive (blue) and reproductive (red) 
% male midshipman.
% 

% Calc number and percent records
% Non-reproductive
NRCnumrecords = sum(~isnan(NRC),1);
NRCpercent = (NRCnumrecords./length(NRC)).*100;

% Reproductive
RCnumrecords = sum(~isnan(RC),1);
RCpercent = (RCnumrecords./length(RC)).*100;

figure(4); clf;
axis square
hold on
plot(f0,NRCpercent,'ok','MarkerFaceColor',[0.05 0.35 0.6],'LineWidth',1.5,'MarkerSize',7.5);
plot(f0,RCpercent,'ok','MarkerFaceColor',[0.6 0.05 0.05],'LineWidth',1.5,'MarkerSize',7.5);
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
legend('NR control (n = 12, 24)','Rep control (n = 12, 24)','box','off','location','northeastoutside')
hold off
set(gcf,'Position',[476,681,384,185]);

