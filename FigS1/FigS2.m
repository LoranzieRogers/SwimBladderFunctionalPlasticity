%% Fig S2: Acoustic characteristics of the experimental speaker and tank
% 
% Electrophysiology experimental tank Acoustics
% 
% The following file will take in acoustic data files and compute:
% background SPL +/- s.d. (dB re: 1 uPa)
% particle acceleration (dB re: 1 ms^-2)
% impedance (dB re: 1.5597 MRayl)
% delta phase
% 
% written by: Loranzie S. Rogers
% email: loranzie@uw.edu
% Date: March 4, 2022 
% 

uigetdir();
%% Background SPL

files = dir('background*.txt');
nfiles = length(files);
background  = zeros(nfiles,18);

% import data into matrix: if data files are labeled using the format
% above, all data will load by increasing sound amplitude for increasing
% frequencies
for i = 1 : nfiles
    dat = importdata(files(i,1).name);
    background(i,:) = dat;
end

% Compute background sound amplitude (dB re: 1 uPa)
BackdB = zeros(length(background(:,5)),1);
for i = 1:length(background(:,5))
    BackdB(i,1) = 20*log10(background(i,5)*20000000);
end

% compute background mean +/- sd (dB re: 1 uPa) and display information
meanBackground = mean(BackdB);
sdBackground = std(BackdB);
fprintf('Background sound pressure level is %4.4f +/- %4.4f (dB re: 1 uPa; mean+/-s.d.)',meanBackground,sdBackground)

%% Load and clean acoustic meaurement data

% get all file names and create matrix for data import
% file names adhear to following format: PM-f0-dB, where
% PM = particle motion; f0 is freq as three digits; dB = sound amplitude
files = dir('PM-*.txt');
nfiles = length(files);
data  = zeros(nfiles,18);

% import data into matrix: if data files are labeled using the format
% above, all data will load by increasing sound amplitude for increasing
% frequencies
for i = 1 : nfiles
    dat = importdata(files(i,1).name);
    data(i,:) = dat;
end

% round f0 in column 1
for i = 1:length(data(:,1))
    roundF0 = round(data(i,1));
    data(i,1) = roundF0;
end

% Compute sound amplitude (dB re: 1 uPa)
dB = zeros(length(data(:,5)),1);
for i = 1:length(data(:,5))
    dB(i,1) = 20*log10(data(i,5)*20000000);
end

% Add sound amplitude to data matrix, clean matrix, convert to table 
% (i.e., remove columns that will be unused during analysis)
data = [data(:,1) dB data(:,[5 7 9:11 13:15 17 18])];
ColNames = {'f0','dB','Pressure','pmX','dpX','dpXsd','pmY','dpY','dpYsd','pmZ','dpZ','dpZsd'};
dataTable = array2table(data,'VariableNames',ColNames);

%% Calculations


% Calculate amplitude Pa: 
% Input dataTable.Pressure is the Pa as Vpk. We need to convert to Vpk-pk
% and correct our value for the sensitivity of the hydrophone (100mV/Pa)
% The equation below is an abbreviated calculation, but calc is as follows:
% 
% Pa = (((Vpk*2)*1000)/100)
%          1  2    3    4
% 
% 1: Vpk is input from dataTable.Pressure(i,1)
% 2: Convert Vpk to Vpk-pk
% 3: Convert Vpk-pk to mVpk-pk
% 4: Correct for sensitivity of hydrophone (100mV/Pa)
% Following this equation we are left with Pa
Pa = zeros(length(dataTable.Pressure(:,1)),1);
for i = 1:length(dataTable.Pressure(:,1))
    Pa(i,:) = (dataTable.Pressure(i,:)*20);    
end


% Calc amplitude particle acceleration (ms^-2):
% Input axis-specific particle motion data (pm/Axis/), which is as Vpk.
% We need to convert to Vpk-pk, correct for the gain of the accelerometer
% amplifier, convert to mV, and correct for the axis-specific sensitivity 
% of the accelerometer. Calc below is abbrev, but full calc is as follows:
% 
% ms^2 = (((Vpk*2)/100)*1000)/sens
%            1  2   3    4     5
% 
% 1: Vpk in input from dataTable.pm/Axis/(i,1)
% 2: Convert Vpk to Vpk-pk
% 3: Correct for gain of accelerometer amplifier
% 4: Convert Vpk-pk to mVpk-pk
% 5: Correct for axis-specific sensitivity of the accelerometer
% Following this equation we are left with amp. paricle accel (ms^-2)
dataTable.paX = zeros(length(dataTable.pmX(:,1)),1);
for i = 1:length(dataTable.pmX(:,1))
    dataTable.paX(i,:) = (dataTable.pmX(i,:)*20)/11.02;
end

dataTable.paY = zeros(length(dataTable.pmY(:,1)),1);
for i = 1:length(dataTable.pmY(:,1))
    dataTable.paY(i,:) = (dataTable.pmY(i,:)*20)/10.03;
end 

dataTable.paZ = zeros(length(dataTable.pmZ(:,1)),1);
for i = 1:length(dataTable.pmZ(:,1))
    dataTable.paZ(i,:) = (dataTable.pmZ(i,:)*20)/10.37;
end


% Calc magnitude of particle acceleration in dB scale (dB re: 1 ms^-2):
% Particle motion thresholds are reported as the combined magnitude vector
% of all three axes. Inputs for this calculation are the axis-specific
% particle accelerations, which we calculated above. Axis-specific particle
% acceleration were then used to determine the magnitude of particle
% acceleration and converted to dB scale. Calc is as follows:
% 
% dB re: 1 ms^-2 = 20*log10(sqrt((paX(i,:).^2)+(paY(i,:).^2)+(paZ(i,:).^2)))
%                     1            2             3             4 
% 
% 1: Conversion to dB scale
% 2: x-axis amplitude particle acceleration (ms^-2)
% 3: y-axis amplitude particle acceleration (ms^-2)
% 4: z-axis amplitude particle acceleration (ms^-2)
% Following this equation we are left with the compbine magintude of
% particle acceleration in dB scale. 
dataTable.paMag = zeros(length(dataTable.paZ(:,1)),1);
for i = 1:length(dataTable.paMag(:,1))
    dataTable.paMag(i,:) = 20*log10(sqrt((dataTable.paX(i,:).^2)+(dataTable.paY(i,:).^2)+(dataTable.paZ(i,:).^2)));
end


% Calc amplitude particle velocity (ms^-1):
% Input is particle acceleration (ms^-2). We then use the axis-specific
% particle acceleration and frequency info in calculation. Detailes for
% particle velocity (ms^-1) can be found in Nedelec et al., 2016, but the
% axis-specific equation is as follows:
% 
% ms^-1 = (pa/axis/)/(2*pi*f0)
%             1             2
% 
% 1: axis-specific particle acceleration (paX, paY, and paZ; ms^-2)
% 2: sound stimulus frequency (Hz) from dataTable.f0
% Following this equation we are left with particle velocity (ms^-1)
dataTable.pvX = zeros(length(dataTable.paX(:,1)),1);
for i = 1:length(dataTable.paX(:,1))
    dataTable.pvX(i,:) = dataTable.paX(i,:)/(2*pi*dataTable.f0(i,:));
end

dataTable.pvY = zeros(length(dataTable.paY(:,1)),1);
for i = 1:length(dataTable.paY(:,1))
    dataTable.pvY(i,:) = dataTable.paY(i,:)/(2*pi*dataTable.f0(i,:));
end

dataTable.pvZ = zeros(length(dataTable.paZ(:,1)),1);
for i = 1:length(dataTable.paZ(:,1))
    dataTable.pvZ(i,:) = dataTable.paZ(i,:)/(2*pi*dataTable.f0(i,:));
end



% Calc for impedance in dB scale (dB re: 1.5597 MRayl)
% Input is axis-specific pressure (Pa) and particle velocity (ms^-2). We
% then express the ratio of these two values, which is impedance 
% (Pa*s)*ms^-1, logrithmically relative to he acoustic impedance in
% free-field of seawater at 15 degC and 35 ppt (Z = 1.559 MRayl). MRayl is
% expressed as [1*10^6*(Pa*s)*m^-1]. The equation and temperature- and
% salinity-dependent value can be found in Bradley and Wilson, 1966 and
% Erbe, 2011. The calc for this equation is as follows:
% 
% dB re: 1.559 MRayl = 20*log10((Pa(i,:)/(pv/Axis/)(i,:)))/(1.5597*(10^6)))
%                         1       2        3                      4
% 
% 1: Conversion to dB scale
% 2: frequency-specific pressure amplitude (Pa)
% 3: frequency-specific particle velocity amplitude (ms^-1)
% 4: temperature- and salinity-dependent impedance reference value
% Following this equation we are left with axis-specific impedance in dB
% scale (dB re: 1.5597 MRayl)
dataTable.impX = zeros(length(dataTable.pvX(:,1)),1);
for i = 1:length(dataTable.pvX(:,1))
    dataTable.impX(i,:) = 20*log10((Pa(i,:)/dataTable.pvX(i,:))/(1.5597*(10^6)));
end

dataTable.impY = zeros(length(dataTable.pvY(:,1)),1);
for i = 1:length(dataTable.pvY(:,1))
    dataTable.impY(i,:) = 20*log10((Pa(i,:)/dataTable.pvY(i,:))/(1.5597*(10^6)));
end

dataTable.impZ = zeros(length(dataTable.pvZ(:,1)),1);
for i = 1:length(dataTable.pvZ(:,1))
    dataTable.impZ(i,:) = 20*log10((Pa(i,:)/dataTable.pvZ(i,:))/(1.5597*(10^6)));
end


% Calc Impedance as combined magnitude vector similar to particle motion
dataTable.impMag = zeros(length(dataTable.impZ(:,1)),1);
for i = 1:length(dataTable.impZ(:,1))
    dataTable.impMag(i,:) = sqrt((dataTable.impX(i,:)^2)+(dataTable.impY(i,:)^2)+(dataTable.impZ(i,:)^2));
end



% Calc delta phase velocity for each axis
dataTable.dpXv = dataTable.dpX + 90;
dataTable.dpYv = dataTable.dpY + 90;
dataTable.dpZv = dataTable.dpZ + 90;

for i = 1:length(dataTable.dpZv(:,1))
    dataTable.dpMagv(i,:) = sqrt((dataTable.dpXv(i,:)^2)+(dataTable.dpYv(i,:)^2)+(dataTable.dpZv(i,:)^2));
end

%% Plot data

plotTankAcoustics(dataTable.f0,dataTable.impX,dataTable.impY,dataTable.impZ,dataTable.impMag,dataTable.dpXv,dataTable.dpYv,dataTable.dpZv,dataTable.dpMagv)
