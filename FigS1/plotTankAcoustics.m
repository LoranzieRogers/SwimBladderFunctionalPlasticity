function plotTankAcoustics(f0,impX,impY,impZ,impMag,dpXv,dpYv,dpZv,dpMagv)

% Plot tank acoustics

figure(1); clf;

% Impedance
subplot(2,4,1)
axis square
hold on
plot(f0([3:3:end],:),impX([3:3:end],:),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',8);
plot(f0([2:3:end],:),impX([2:3:end],:),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',8);
plot(f0([1:3:end],:),impX([1:3:end],:),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',8);xlim([75 970]);
xticks(95:95:950);
ylim([-90 90]);
yticks([-90:30:90]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on');
% xlabel('Frequency (Hz)','FontName','Arial','fontsize',12);
ylabel('Impedance (dB re: 1.5597 MRayl)','FontName','Arial','fontsize',12);
ax=gca;
ax.YAxis.MinorTickValues = -75:15:75;
title('X Axis','FontName','Arial','fontsize',12);
hold off

subplot(2,4,2)
axis square
hold on
plot(f0([3:3:end],:),impY([3:3:end],:),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',8);
plot(f0([2:3:end],:),impY([2:3:end],:),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',8);
plot(f0([1:3:end],:),impY([1:3:end],:),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',8);
xlim([75 970]);
xticks(95:95:950);
ylim([-90 90]);
yticks([-90:30:90]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on');
ax=gca;
ax.YAxis.MinorTickValues = -75:15:75;
title('Y Axis','FontName','Arial','fontsize',12);
hold off

subplot(2,4,3)
axis square
hold on
plot(f0([3:3:end],:),impZ([3:3:end],:),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',8);
plot(f0([2:3:end],:),impZ([2:3:end],:),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',8);
plot(f0([1:3:end],:),impZ([1:3:end],:),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',8);
xlim([75 970]);
xticks(95:95:950);
ylim([-90 90]);
yticks([-90:30:90]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on');
ax=gca;
ax.YAxis.MinorTickValues = -75:15:75;
title('Z Axis','FontName','Arial','fontsize',12);
hold off

subplot(2,4,4)
axis square
hold on
plot(f0([3:3:end],:),impMag([3:3:end],:),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',8);
plot(f0([2:3:end],:),impMag([2:3:end],:),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',8);
plot(f0([1:3:end],:),impMag([1:3:end],:),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',8);
xlim([75 970]);
xticks(95:95:950);
ylim([-90 90]);
yticks([-90:30:90]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on');
ax=gca;
ax.YAxis.MinorTickValues = -75:15:75;
title('Combined Magnitude','FontName','Arial','fontsize',12);
hold off

legend('154 dB re: 1 \muPa','142 dB re: 1 \muPa','130 dB re: 1 \muPa','box','off','FontName','Arial','fontsize',12)


% Phase difference
subplot(2,4,5)
axis square
hold on
plot(f0([3:3:end],:),dpXv([3:3:end],:),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',8);
plot(f0([2:3:end],:),dpXv([2:3:end],:),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',8);
plot(f0([1:3:end],:),dpXv([1:3:end],:),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',8);xlim([75 970]);
xticks(95:95:950);
ylim([-270 270]);
yticks([-270:90:270]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on');
ax=gca;
ax.YAxis.MinorTickValues = -225:90:225;
xlabel('Frequency (Hz)','FontName','Arial','fontsize',12);
ylabel('Phase difference (deg)','FontName','Arial','fontsize',12);
hold off

subplot(2,4,6)
axis square
hold on
plot(f0([3:3:end],:),dpYv([3:3:end],:),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',8);
plot(f0([2:3:end],:),dpYv([2:3:end],:),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',8);
plot(f0([1:3:end],:),dpYv([1:3:end],:),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',8);xlim([75 970]);
xticks(95:95:950);
ylim([-270 270]);
yticks([-270:90:270]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on');
ax=gca;
ax.YAxis.MinorTickValues = -225:90:225;
xlabel('Frequency (Hz)','FontName','Arial','fontsize',12);
hold off

subplot(2,4,7)
axis square
hold on
plot(f0([3:3:end],:),dpZv([3:3:end],:),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',8);
plot(f0([2:3:end],:),dpZv([2:3:end],:),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',8);
plot(f0([1:3:end],:),dpZv([1:3:end],:),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',8);
xlim([75 970]);
xticks(95:95:950);
ylim([-270 270]);
yticks([-270:90:270]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on');
ax=gca;
ax.YAxis.MinorTickValues = -225:90:225;
xlabel('Frequency (Hz)','FontName','Arial','fontsize',12);
hold on

subplot(2,4,8)
axis square
hold on
plot(f0([3:3:end],:),dpMagv([3:3:end],:),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',8);
plot(f0([2:3:end],:),dpMagv([2:3:end],:),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',8);
plot(f0([1:3:end],:),dpMagv([1:3:end],:),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',8);
xlim([75 970]);
xticks(95:95:950);
ylim([-270 270]);
yticks([-270:90:270]);
set(gca,'tickdir','out','box','off','TickLength',[0.015 0.015],'FontName','Arial','fontsize',12,'LineWidth',1.5,'YMinorTick','on');
ax=gca;
ax.YAxis.MinorTickValues = -225:90:225;
xlabel('Frequency (Hz)','FontName','Arial','fontsize',12);
hold off


end