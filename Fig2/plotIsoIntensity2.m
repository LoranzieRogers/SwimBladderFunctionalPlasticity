function plotIsoIntensity2(f0,mean154,sd154,mean142,sd142,mean130,sd130)

% Preliminary figure displaying all records.
% The following code will loop through and plot iso-intensity level curves
% for each recording at one sound pressure level.
%
% written by: Loranzie S. Rogers
% Date: March 11, 2022


n = length(mean154(1,:));
nrows = floor(sqrt(n));
ncols = ceil(n/nrows);

figure(1); clf;
for i = 1:length(mean154(1,:))
    subplot(nrows,ncols,i)
    errorbar(f0,mean154(:,i),sd154(:,i),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',6);
    hold on
    plot(f0,mean154(:,i),'-ok','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',6);
    errorbar(f0,mean142(:,i),sd142(:,i),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',6)
    plot(f0,mean142(:,i),'-ok','MarkerFaceColor',[0.5 0.5 0.5],'LineWidth',1.5,'MarkerSize',6);
    errorbar(f0,mean130(:,i),sd130(:,i),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',6);
    plot(f0,mean130(:,i),'-ok','MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',6);
    hold off
    xlim([75 970]);
    xticks(95:95:950);
%     ylim([0 round(max(max(mean154(:,i)))+(2*max(max(sd154(:,i)))),2,"significant")]);
    set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',12,'LineWidth',1.5,'XMinorTick','off','YMinorTick','off');
end


for i = (max(n)-(ncols-1)):1:max(n)
    Xplot = subplot(nrows,ncols,i);
    xlabel('Frequency (Hz)','FontName','Arial','fontsize',12);
end


for j = 1:1:nrows
    for i = ((ncols*j)-(ncols-1))
        Yplot = subplot(nrows,ncols,i);
        ylabel('Saccular Potential (\muV)','FontName','Arial','fontsize',12);
    end
end


end

%     ylim([0 round((max(max(NRCmean(:,i)))+(2*max(max(NRCsem(:,i))))),1,"significant")]);   
