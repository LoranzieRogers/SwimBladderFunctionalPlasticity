%% Figure S1: Representative evoked saccular hair cell potential input-output response curves.
% 
% Here, we will plot the input-outpus response curves of a representative
% non-reproducrive and reproductive male midshipman in response to three
% representative test frequencies: 95, 190, and 285 Hz.
% 
% Written by: Loranzie S. Rogers
% email: loranzie@uw.edu
% Date: January 30, 2023

%% Clear and set cd

clc; clf;

uigetdir()

%% Import and partition data

nr = readmatrix("nrIO.csv");
nrIntensity = nr(1,3:end);
nrFloor = nr(2:end,2);  nrFloor = nrFloor.*10000;
nr95 = nr(2,3:end);     nr95 = nr95.*10000;
nr190 = nr(3,3:end);    nr190 = nr190.*10000;
nr285 = nr(4,3:end);    nr285 = nr285.*10000;

rep = readmatrix("repIO.csv");
rIntensity = rep(1,3:end);
rFloor = rep(2:end,2);  rFloor = rFloor.*10000;
r95 = rep(2,3:end);     r95 = r95.*10000;
r190 = rep(3,3:end);    r190 = r190.*10000;
r285 = rep(4,3:end);    r285 = r285.*10000;


%% Figure

figure(1); clf;


% Part A (top row): Non-reproductive male i-o response curves

subplot(2,3,1) % 95 Hz
axis square
hold on
plot(nrIntensity,nr95,'-ok','MarkerFaceColor',[0.05 0.35 0.6],'LineWidth',1.5,'MarkerSize',8)
yline(nrFloor(1,1),'--o','Color',[0.5 0.5 0.5],'LineWidth',1.5)
xlim([100 154]);
xticks(100:6:154);
ylim([0 80]);
yticks([0:20:80]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on','XMinorTick','on','XDir','reverse');
ylabel('Saccular potential (\muV)','FontName','Arial','fontsize',12);
xtickangle(45);
ax=gca;
ax.YAxis.MinorTickValues = 10:20:70;
ax.XAxis.MinorTickValues = 103:6:151;
title('95 Hz','FontName','Arial','fontsize',12);
hold off

subplot(2,3,2) % 190 Hz
axis square
hold on
plot(nrIntensity,nr190,'-ok','MarkerFaceColor',[0.05 0.35 0.6],'LineWidth',1.5,'MarkerSize',8)
yline(nrFloor(2,1),'--o','Color',[0.5 0.5 0.5],'LineWidth',1.5)
xlim([100 154]);
xticks(100:6:154);
ylim([0 45]);
yticks([0:15:45]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','off','XMinorTick','on','XDir','reverse');
xtickangle(45);
ax=gca;
ax.XAxis.MinorTickValues = 103:6:151;
title('190 Hz','FontName','Arial','fontsize',12);
hold off

subplot(2,3,3) % 285 Hz
axis square
hold on
plot(nrIntensity,nr285,'-ok','MarkerFaceColor',[0.05 0.35 0.6],'LineWidth',1.5,'MarkerSize',8)
yline(nrFloor(3,1),'--o','Color',[0.5 0.5 0.5],'LineWidth',1.5)
xlim([100 154]);
xticks(100:6:154);
ylim([0 25]);
yticks([0:5:25]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','off','XMinorTick','on','XDir','reverse');
xtickangle(45);
ax=gca;
ax.XAxis.MinorTickValues = 103:6:151;
title('285 Hz','FontName','Arial','fontsize',12);
hold off




% Part B (bottom row): Reproductive male i-o response curves

subplot(2,3,4) % 95 Hz
axis square
hold on
plot(rIntensity,r95,'-ok','MarkerFaceColor',[0.6 0.05 0.05],'LineWidth',1.5,'MarkerSize',8)
yline(rFloor(1,1),'--o','Color',[0.5 0.5 0.5],'LineWidth',1.5)
xlim([100 154]);
xticks(100:6:154);
ylim([0 210]);
yticks([0:30:210]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on','XMinorTick','on','XDir','reverse');
ylabel('Saccular potential (\muV)','FontName','Arial','fontsize',12);
xlabel('Sound pressure level (dB re: 1 \muPa)','FontName','Arial','fontsize',12);
xtickangle(45);
ax=gca;
ax.YAxis.MinorTickValues = 15:30:195;
ax.XAxis.MinorTickValues = 103:6:151;
hold off

subplot(2,3,5) % 190 Hz
axis square
hold on
plot(rIntensity,r190,'-ok','MarkerFaceColor',[0.6 0.05 0.05],'LineWidth',1.5,'MarkerSize',8)
yline(rFloor(2,1),'--o','Color',[0.5 0.5 0.5],'LineWidth',1.5)
xlim([100 154]);
xticks(100:6:154);
ylim([0 60]);
yticks([0:20:60]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on','XMinorTick','on','XDir','reverse');
xlabel('Sound pressure level (dB re: 1 \muPa)','FontName','Arial','fontsize',12);
xtickangle(45);
ax=gca;
ax.YAxis.MinorTickValues = 10:20:50;
ax.XAxis.MinorTickValues = 103:6:151;
hold off

subplot(2,3,6) % 285 Hz
axis square
hold on
plot(rIntensity,r285,'-ok','MarkerFaceColor',[0.6 0.05 0.05],'LineWidth',1.5,'MarkerSize',8)
yline(rFloor(3,1),'--o','Color',[0.5 0.5 0.5],'LineWidth',1.5)
xlim([100 154]);
xticks(100:6:154);
ylim([0 120]);
yticks([0:20:120]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on','XMinorTick','on','XDir','reverse');
xlabel('Sound pressure level (dB re: 1 \muPa)','FontName','Arial','fontsize',12);
xtickangle(45);
ax=gca;
ax.YAxis.MinorTickValues = 10:20:110;
ax.XAxis.MinorTickValues = 103:6:151;
hold off


