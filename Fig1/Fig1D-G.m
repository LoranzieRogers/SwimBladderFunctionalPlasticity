%% Functional plasticity of the swim bladder as an acoustic organ for communication in a vocal fish
% 
% Swim Bladder morphology data for non-reproductive (winter) and 
% reproductive (summer) male plainfin midshipman. 
%
% The following plots and statistics support Fig. 1 D-G.
%  
% Written by: Loranzie S. Rogers
% email: loranzie@uw.edu
% Date: 

%% Clear all and set directory

clear all; close all; clc;                                                  % clear and close everything
uigetdir();

%% CT measurement data

% Average distance from swim bladder to saccule

CT = readmatrix('CTmeasurements.csv');
Winter = CT(:,1); WinterMean = mean(Winter,'omitnan'); WinterSD = std(Winter,'omitnan');
Summer = CT(:,2); SummerMean = mean(Summer,'omitnan'); SummerSD = std(Summer,'omitnan');

x = categorical({'Non-reproductive','Reproductive'});
x = reordercats(x,{'Non-reproductive','Reproductive'});

x1 = [1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2];
Distance = [Winter' Summer'];
AvgDistance = [WinterMean SummerMean]; StdDistance = [WinterSD SummerSD];

figure(1); clf;
bar(x,AvgDistance,'FaceColor',[0.5 0.5 0.5],'BarWidth',0.8,'LineWidth',1.5,'FaceAlpha',0.75);
hold on
er = errorbar(x',AvgDistance',StdDistance,'k','LineWidth',1.5);
er.LineStyle = 'none';
scatter(x1, Distance,50,'ok','LineWidth',1,'jitter','on','jitterAmount',0.1);
% xticks([1 2]);
yticks([0:0.02:0.1]);

[h,p,ci,stats] = ttest2(Winter,Summer)

%% Sonic musle somadic index

SonicMuscle = readmatrix("SMSI.csv");
Winter = SonicMuscle(:,1); WinterMean = mean(Winter,'omitnan'); WinterSD = std(Winter,'omitnan');
Summer = SonicMuscle(:,2); SummerMean = mean(Summer,'omitnan'); SummerSD = std(Summer,'omitnan');

SMSI = [Winter' Summer'];
AvgSMSI = [WinterMean SummerMean]; StdSMSI = [WinterSD SummerSD];

figure(2); clf;
bar(x,AvgSMSI,'FaceColor',[0.5 0.5 0.5],'BarWidth',0.8,'LineWidth',1.5,'FaceAlpha',0.75);
hold on
er = errorbar(x',AvgSMSI',StdSMSI,'k','LineWidth',1.5);
er.LineStyle = 'none';
scatter(x1, SMSI,50,'ok','LineWidth',1,'jitter','on','jitterAmount',0.1);
yticks([0:0.5:2]);
set(gca,'tickdir','out','box','off','TickLength',[0.0125 0.0125],'FontName','Arial','fontsize',12,'LineWidth',1.5,'XMinorTick','off','YMinorTick','on');
ax = gca;
ax.YAxis.MinorTickValues = 0.25:0.5:1.75;
ylabel('SMSI','FontName','Arial','fontsize',12);

[h,p,ci,stats] = ttest2(Winter,Summer)

%% Normalized swim bladder horn length

HornLength = readmatrix("HornLength.csv");
Winter = HornLength(:,1); WinterMean = mean(Winter,'omitnan'); WinterSD = std(Winter,'omitnan');
Summer = HornLength(:,2); SummerMean = mean(Summer,'omitnan'); SummerSD = std(Summer,'omitnan');

HL = [Winter' Summer'];
AvgHL = [WinterMean SummerMean]; StdHL = [WinterSD SummerSD];

figure(3); clf;
bar(x,AvgHL,'FaceColor',[0.5 0.5 0.5],'BarWidth',0.8,'LineWidth',1.5,'FaceAlpha',0.75);
hold on
er = errorbar(x',AvgHL',StdHL,'k','LineWidth',1.5);
er.LineStyle = 'none';
scatter(x1, HL,50,'ok','LineWidth',1,'jitter','on','jitterAmount',0.1);
yticks([0:0.02:0.08]);
set(gca,'tickdir','out','box','off','TickLength',[0.0125 0.0125],'FontName','Arial','fontsize',12,'LineWidth',1.5,'XMinorTick','off','YMinorTick','on');
ax = gca;
ax.YAxis.MinorTickValues = 0.01:0.02:0.07;
ylabel('Normalized horn length','FontName','Arial','fontsize',12);

[h,p,ci,stats] = ttest2(Winter,Summer)

%% Normalized swim bladder width

width = readmatrix("NormalizedWidth.csv");
Winter = width(:,1); WinterMean = mean(Winter,'omitnan'); WinterSD = std(Winter,'omitnan');
Summer = width(:,2); SummerMean = mean(Summer,'omitnan'); SummerSD = std(Summer,'omitnan');

width = [Winter' Summer'];
AvgWidth = [WinterMean SummerMean]; StdWidth = [WinterSD SummerSD];

figure(4); clf;
bar(x,AvgWidth,'FaceColor',[0.5 0.5 0.5],'BarWidth',0.8,'LineWidth',1.5,'FaceAlpha',0.75);
hold on
er = errorbar(x',AvgWidth',StdWidth,'k','LineWidth',1.5);
er.LineStyle = 'none';
scatter(x1, width ,50,'ok','LineWidth',1,'jitter','on','jitterAmount',0.1);
yticks([0:0.02:0.12]);
set(gca,'tickdir','out','box','off','TickLength',[0.0125 0.0125],'FontName','Arial','fontsize',12,'LineWidth',1.5,'XMinorTick','off','YMinorTick','on');
ax = gca;
ax.YAxis.MinorTickValues = 0.01:0.02:0.11;
ylabel('Normalized width','FontName','Arial','fontsize',12);

[h,p,ci,stats] = ttest2(Winter,Summer)
