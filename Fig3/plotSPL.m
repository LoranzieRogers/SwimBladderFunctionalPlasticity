function plotSPL(f0,SPLdata)

% written by: Loranzie S. Rogers
% Date: March 10, 2022 


n = length(SPLdata(:,1));
nrows = floor(sqrt(n));
ncols = ceil(n/nrows);

figure

for i = 1:length(SPLdata(:,1))
    axis square
    subplot(nrows,ncols,i)
    hold on
    plot(f0,SPLdata(i,:),'-ok','MarkerFaceColor','k','LineWidth',1.25,'MarkerSize',6);
    xlim([75 970]);
    xticks(f0);
    set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',12,'TickLength',[0.025 0.025],'LineWidth',1.25,'YMinorTick','on');
    ylim([100 160]);
    yticks(100:10:160);
    ax=gca;
    ax.YAxis.MinorTickValues = 105:10:155;
%     xtickangle(0)
end


for i = (max(n)-(ncols-1)):1:max(n)
    Xplot = subplot(nrows,ncols,i);
    xlabel('Frequency (Hz)','FontName','Arial','fontsize',12);
end

for j = 1:1:nrows
    for i = ((ncols*j)-(ncols-1))
        Yplot = subplot(nrows,ncols,i);
        ylabel({'SPL','(dB re: 1 \muPa)'},'FontName','Arial','fontsize',12);
    end
end

end