%% Fig 4: Finite element modeling
%
%
% Written by: Loranzie S. Rogers
% email: loranzie@uw.edu
% Date: February 22, 2023
% 

%% Clear all and set directory

clear all; close all; clc;                                                  % clear and close everything
dir = uigetdir();                                                           % set directory 
cd(dir)


%% Load and extract relevant data from data file

FileLocation = dir;                                                         % Not really needed if all files are already in directory. If files are elsewhere, provide path to files.

ReproductiveFiles = 'rep*.txt';         repFreqs = 131;
NonreproductiveFiles = 'nr*.txt';       nrFreqs = 92;

[Reproductive, rep_names] = ExtractData(FileLocation,ReproductiveFiles,repFreqs);
[Nonreproductive, nr_names] = ExtractData(FileLocation,NonreproductiveFiles,nrFreqs);

RepnumNodes = length(unique(Reproductive.rep000(:,1)));
NRnumNodes = length(unique(Nonreproductive.nr000(:,1)));

rNF = readmatrix('repNatFreq_grouped.csv');
nrNF = readmatrix('nrNatFreq_grouped.csv');


%% Fig. 4b: Histogram of natural frequencies 

figure(1); clf;
bar(rNF(:,2),rNF(:,1),'FaceColor',[0.6 0.05 0.05],'EdgeColor','k','LineWidth',1.5)
hold on
bar(nrNF(:,2),nrNF(:,1),'FaceColor',[0.05 0.35 0.6],'EdgeColor','k','LineWidth',1.5)
set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',12,'TickLength',[0.015 0.015],'LineWidth',1.5,'XMinorTick','off','YMinorTick','off');
ylabel('Count')
yticks(0:1:3)
xlabel('Frequency (Hz)')
xticks(0:50:750)
xlim([-25 775])
xtickangle(45)


%% Calculations

% For each row, compute rms of x, y, and z displacements measurments such
% that we are left with the magnitude of displacement for each node at all
% test frequencies

[Reproductive] = displacementRMS(Reproductive,rep_names);
[Nonreproductive] = displacementRMS(Nonreproductive,nr_names);



% Restructure Nonreproductive and Reproductive data structs in order to
% make by frequency (bf) comparisons within and across all pressure
% incident angles

% Reproductive
for i = 1:length(rep_names)
    bf_rep.(rep_names(i,:)) = [Reproductive.(rep_names(i,:))(1:repFreqs,2)];
    for j = 1:RepnumNodes   
        bf_rep.(rep_names(i,:))(:,j+1) = [Reproductive.(rep_names(i,:))((1:repFreqs)+((j-1)*repFreqs),6)];
    end
    bf_rep.(rep_names(i,:))(:,end+1) = rms(bf_rep.(rep_names(i,:))(:,2:(RepnumNodes+1)),2);
end

% Nonreproductive
for i = 1:length(nr_names)
    bf_nr.(nr_names(i,:)) = [Nonreproductive.(nr_names(i,:))(1:nrFreqs,2)];
    for j = 1:NRnumNodes
        bf_nr.(nr_names(i,:))(:,j+1) = [Nonreproductive.(nr_names(i,:))((1:nrFreqs)+((j-1)*nrFreqs),6)];
    end
    bf_nr.(nr_names(i,:))(:,end+1) = rms(bf_nr.(nr_names(i,:))(:,2:(NRnumNodes+1)),2);
end



% RELATIVE DISPLACEMENT: Here, we are going to compute the 
% frequency-specific swim bladder displacement (rms). Because the swim
% bladder is thought to provide directional information, we are going to
% determine the rms swim bladder displacement by collapsing across 
% all pressure incident angles. So, here we will pull the last row of the
% by frequency (bf) data structure from each incident angle and compute the
% rms, which leaves us with the composite swim bladder displacement. We
% will then normalize this value to the greatest displacement since all
% that we really care about is whether the nonreproductive and reproductive
% swim bladders are equally excited.

% Nonreproductive
nr_frf = [bf_nr.(nr_names(1,:))(:,1)];
for i = 1:length(nr_names)
    nr_frf(:,i+1) = bf_nr.(nr_names(i,:))(:,end);
end
nr_frf_rms = rms(nr_frf(:,2:end),2);
nr_frf_normalized = nr_frf_rms ./ max(nr_frf_rms);

% Reproductive
rep_frf = [bf_rep.(rep_names(1,:))(:,1)];
for i = 1:length(rep_names)
    rep_frf(:,i+1) = bf_rep.(rep_names(i,:))(:,end);
end
rep_frf_rms = rms(rep_frf(:,2:end),2);
rep_frf_normalized = rep_frf_rms ./ max(nr_frf_rms);



% RELATIVE POWER: Here we are going to determine relative power by 
% integrating the frequency-specifc displacement for each incident angle 
% and then normalizing the outputs to determine the relative power. For
% this integration, we will be using the trapezoidal rule. Yes, I know that
% matlab has a funciton for this, trapz(); however, I chose to work it out
% the long way. If you want to confirm that the built-in function and my
% results are the same, run the following line and compare to nr_power:
% for k = 1:length(rep_names)
%     trapz((2 .* pi .* bf_nr.(nr_names(k,:))(:,1)), (bf_nr.(nr_names(k,:))(:,end) .^ 2))
% end

% Nonreproductive
nr_power = [];
for k = 1:length(rep_names)
    freqRad = 2 .* pi .* bf_nr.(nr_names(k,:))(:,1);
    ampSquared = bf_nr.(nr_names(k,:))(:,end) .^ 2;
    for l = 1:length(bf_nr.(nr_names(k,:))(:,end))-1
        tmp(l,1) = ((ampSquared(l,1) + ampSquared(l+1,1)) ./ 2) .* (freqRad(l+1,1) - freqRad(l,1));
    end
    nr_power(:,k) = tmp;
end
nr_power = sum(nr_power);
nr_power_norm = nr_power ./ max(max(nr_power));

% Reproductive
rep_power = [];
for k = 1:length(rep_names)
    freqRad = 2 .* pi .* bf_rep.(rep_names(k,:))(:,1);
    ampSquared = bf_rep.(rep_names(k,:))(:,end) .^ 2;
    for l = 1:length(bf_rep.(rep_names(k,:))(:,end))-1
        tmp(l,1) = ((ampSquared(l,1) + ampSquared(l+1,1)) ./ 2) .* (freqRad(l+1,1) - freqRad(l,1));
    end
    rep_power(:,k) = tmp;
end
rep_power = sum(rep_power);
rep_power_norm = rep_power ./ max(max(nr_power));


% Difference between reproductive and nonreproductive normalized power
% measurments. Shows that the reproductive swim bladder does not generate
% as much output (in our context this could be local particle motion) as 
% nonreproductive male fish.

diff_power = rep_power_norm - nr_power_norm;


%% Fig. 4c: Normalized frequency response function.

% Relative displacement vs. freq
figure(2); clf
plot(rep_frf(1:111,1),rep_frf_normalized(1:111,:),'Color',[0.6 0.05 0.05],'LineWidth',2)
hold on
plot(nr_frf(1:74,1),nr_frf_normalized(1:74,:),'Color',[0.05 0.35 0.6],'LineWidth',2)
set(gca,'tickdir','out','box','off','FontName','Arial','fontsize',12,'TickLength',[0.015 0.015],'LineWidth',1.5,'XMinorTick','on','YMinorTick','off');
ylabel('Relative displacement')
yticks(0:0.2:1)
xlabel('Frequency (Hz)')
xticks(0:150:750)
xlim([0 750])
xtickangle(0)
ax=gca;
ax.XAxis.MinorTickValues = 75:150:675;
legend('Reproductive','Nonreproductive','box','off')
set(gcf,'Position',[171,346,257,173])


%% Fig. 4d: Difference in reproductive and nonreproductive normalized power

deg = [0:45:315]';
deggorad=pi/180;
theta = deggorad*deg;
r = ones(8,1);


figure(3); clf;
polarscatter(theta, r, 400, diff_power, 'filled','MarkerEdgeColor','k') 
colormap(redblue(50))
c = colorbar;
set(gca,"CLim",[-1 1]) 
grid off
% thetaticks(0:45:315)
thetaticks([]);
rlim([0 1.25])
rticks([])
c.Label.String = '\Delta Relative power';
c.Label.Rotation = 270; % to rotate the text
c.Label.Position = [4.25,0,0]; % to rotate the text
c.Ticks = [-1:0.5:1];
set(gcf,'Position',[476,727,288,139])

