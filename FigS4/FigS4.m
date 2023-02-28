%% Male SSB iso-intensity level
% 
% The following code will import data and calc mean +/- s.d. iso-intensity 
% level responses at 154, 142, and 130 dB re: 1 uPa. It will then use
% PlotIsoIntensity.m to plot responses at all three sound levels. 

%% Clear all and set directory

clear all; close all; clc;                                                  % clear and close everything
dir = uigetdir();
cd(dir);

% set file location of iso-intensity data
FileLocation = '/Users/loranzierogers/Documents/UW/projects/maleSaccule-SeasonalRemovalSB/Data/AllData/FigS4';
f0 = 95:95:950;

%% Non-reproductive control

NRC = dir(fullfile(dir,'NRC-PN22*.xls'));
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


%% Non-reproductive removal

NRR = dir(fullfile(dir,'NRR-PN22*.xls'));
NRRfilenames = {NRR.name}; % all of the filenames in one cell array

for i = 1:numel(NRR)
    G = fullfile(FileLocation,NRR(i).name);
    NRR(i).Iso154 = readmatrix(G,'Sheet','154dB','Range','C1:J10');
    NRR(i).Iso142 = readmatrix(G,'Sheet','142dB','Range','C1:J10');
    NRR(i).Iso130 = readmatrix(G,'Sheet','130dB','Range','C1:J10');
end

% convert to uV
for i = 1:numel(NRR)
    NRR(i).Iso154 = NRR(i).Iso154*10000;
    NRR(i).Iso142 = NRR(i).Iso142*10000;
    NRR(i).Iso130 = NRR(i).Iso130*10000;
end

for i = 1:numel(NRR)
    NRRmean154(:,i) = mean(NRR(i).Iso154,2,'omitnan');
    NRRmean142(:,i) = mean(NRR(i).Iso142,2,'omitnan');
    NRRmean130(:,i) = mean(NRR(i).Iso130,2,'omitnan');
end

for i = 1:numel(NRR)
    NRRsd154(:,i) = std(NRR(i).Iso154,[],2,'omitnan');
    NRRsd142(:,i) = std(NRR(i).Iso142,[],2,'omitnan');
    NRRsd130(:,i) = std(NRR(i).Iso130,[],2,'omitnan');
end

for i = 1:numel(NRC)
    NRRsem154(:,i) = std(NRR(i).Iso154,[],2,'omitnan')/sqrt(length(NRR));
    NRRsem142(:,i) = std(NRR(i).Iso142,[],2,'omitnan')/sqrt(length(NRR));
    NRRsem130(:,i) = std(NRR(i).Iso130,[],2,'omitnan')/sqrt(length(NRR));
end


NRRmean = [mean(NRRmean154,2) mean(NRRmean142,2,'omitnan') mean(NRRmean130,2,'omitnan')];
NRRsd = [std(NRRmean154,[],2,'omitnan') std(NRRmean142,[],2,'omitnan') std(NRRmean130,[],2,'omitnan')];
NRRsem = [std(NRRmean154,[],2,'omitnan')/sqrt(length(NRRmean154)) std(NRRmean142,[],2,'omitnan')/sqrt(length(NRRmean142)) std(NRRmean130,[],2,'omitnan')/sqrt(length(NRRmean130))];


%% Reproductive control

RC = dir(fullfile(dir,'RC-PN22*.xls'));
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


%% Reproductive removal

RR = dir(fullfile(dir,'RR-PN22*.xls'));
RRfilenames = {RR.name}; % all of the filenames in one cell array

for i = 1:numel(RR)
    G = fullfile(FileLocation,RR(i).name);
    RR(i).Iso154 = readmatrix(G,'Sheet','154dB','Range','C1:J10');
    RR(i).Iso142 = readmatrix(G,'Sheet','142dB','Range','C1:J10');
    RR(i).Iso130 = readmatrix(G,'Sheet','130dB','Range','C1:J10');
end

% convert to uV
for i = 1:numel(RR)
    RR(i).Iso154 = RR(i).Iso154*10000;
    RR(i).Iso142 = RR(i).Iso142*10000;
    RR(i).Iso130 = RR(i).Iso130*10000;
end

for i = 1:numel(RR)
    RRmean154(:,i) = mean(RR(i).Iso154,2,'omitnan');
    RRmean142(:,i) = mean(RR(i).Iso142,2,'omitnan');
    RRmean130(:,i) = mean(RR(i).Iso130,2,'omitnan');
end

for i = 1:numel(RR)
    RRsd154(:,i) = std(RR(i).Iso154,[],2,'omitnan');
    RRsd142(:,i) = std(RR(i).Iso142,[],2,'omitnan');
    RRsd130(:,i) = std(RR(i).Iso130,[],2,'omitnan');
end

for i = 1:numel(RR)
    RRsem154(:,i) = std(RR(i).Iso154,[],2,'omitnan')/sqrt(length(RR));
    RRsem142(:,i) = std(RR(i).Iso142,[],2,'omitnan')/sqrt(length(RR));
    RRsem130(:,i) = std(RR(i).Iso130,[],2,'omitnan')/sqrt(length(RR));
end


RRmean = [mean(RRmean154,2) mean(RRmean142,2,'omitnan') mean(RRmean130,2,'omitnan')];
RRsd = [std(RRmean154,[],2,'omitnan') std(RRmean142,[],2,'omitnan') std(RRmean130,[],2,'omitnan')];
RRsem = [std(RRmean154,[],2,'omitnan')/sqrt(length(RRmean154)) std(RRmean142,[],2,'omitnan')/sqrt(length(RRmean142)) std(RRmean130,[],2,'omitnan')/sqrt(length(RRmean130))];

%%


figure(1); clf;

% NRC and NRR
for i = 1:1:3
    figure(1)
    subplot(2,3,i)
    errorbar(f0,NRCmean(:,i),NRCsem(:,i),'-ok','MarkerFaceColor',[0.05 0.35 0.6],'LineWidth',1.5,'MarkerSize',7.5);
    hold on
    errorbar(f0,NRRmean(:,i),NRRsem(:,i),'-ok','MarkerFaceColor',[0.4 0.75 1],'LineWidth',1.5,'MarkerSize',7.5);
    hold off
    xlim([75 970]);
    xticks(95:95:950);
    xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
    ylim([0 round((max(max(NRCmean(:,i)))+(2*max(max(NRCsem(:,i))))),1,"significant")]);   
    set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',10,'TickLength',[0.025 0.025],'LineWidth',1.5,'XMinorTick','off','YMinorTick','off');
    xtickangle(0)
end

[~,icons] = legend('NR control (n = 12, 24)','NR removal (n = 12, 24)','box','off','FontName','Arial','fontsize',10);
icons = findobj(icons,'Type','patch'); 
set(icons, 'Markersize', 7.5); %// set value as desired

subplot1 = subplot(3,3,4);
ylim(subplot1,[0 round((max(max(NRCmean(:,1)))+(2*max(max(NRCsem(:,1))))),2,"significant")]);


% RC and RR
for i = 1:length(RCmean(1,:))
    subplot(2,3,i+3)
    errorbar(f0,RCmean(:,i),RCsem(:,i),'-ok','MarkerFaceColor',[0.6 0.05 0.05],'LineWidth',1.5,'MarkerSize',7.5);
    hold on
    errorbar(f0,RRmean(:,i),RRsem(:,i),'-ok','MarkerFaceColor',[1 0.05 0.05],'LineWidth',1.5,'MarkerSize',7.5);
    hold off
    xlim([75 970]);
    xticks(95:95:950);
    xlabel('Frequency (Hz)','FontName','Arial','fontsize',10);
    ylim([0 round((max(max(RCmean(:,i)))+(2*max(max(RCsem(:,i))))),2,"significant")]);
    set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',10,'TickLength',[0.025 0.025],'LineWidth',1.5,'XMinorTick','off','YMinorTick','off');
    xtickangle(0)
end

[~,icons] = legend('Rep control (n = 12, 24)','Rep removal (n = 13, 24)','box','off','FontName','Arial','fontsize',10);
icons = findobj(icons,'Type','patch'); 
set(icons, 'Markersize', 7.5); %// set value as desired


for i = [1 4 ]
    Yplot = subplot(2,3,i);
    ylabel('Saccular P\potential (\muV)','FontName','Arial','fontsize',10);
end


%% Fold changes

ControlFold = RCmean ./ NRCmean;
NRFold = NRCmean ./ NRRmean;
RFold = RCmean ./ RRmean;

