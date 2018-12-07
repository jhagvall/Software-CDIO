clc; close all; clear all;

% this script calculates the absorption coefficient, reduce scattering
% coefficient and anisotropy of the tissue layer in the model. We use a 6
% model for our simulation: 
% 1 - stratum corneum
% 2 - living epidermis
% 3 - papillary dermis
% 4 - upper blood net plexux
% 5 - reticular dermis
% 6 - deep blood net plexus
% Each of these layers is characterized by a water fraction, blood fraction
% (Oxy and Deoxy hemo fractions) and melanin fractions
% In orted to compute this, we need the absorption spectra of HbO, HB, H2O.
% Melanin absorption contribution is not wavelength dependat, but obtained
% as for the seminar in class. 

addpath('Data elaboration');

ST = [0.05, 0, 0]; % stratum corneus
LE = [0.2, 0, 0.11]; % living epidermis
PD = [0.5, 0.04, 0]; % papillary dermis
UBD = [0.6, 0.3, 0]; % upper blood net plexus
RD = [0.7,0.04, 0]; % reticular dermis
DBP = [0.7, 0.05, 0]; % deep blood net plexus

S = 0.45; % blood oxigenation in order to consider HbO and Hb fractions

muaST = muaComp(ST, S);
muaLE = muaComp(LE, S);
muaPD = muaComp(PD, S);
muaUBD = muaComp(UBD, S);
muaRD = muaComp(RD, S);
muaDBP = muaComp(DBP, S);

muaT = muaST +muaLE + muaPD + muaUBD + muaRD + muaDBP;



nm = [400:1100];

figure;
plot(nm,muaST); hold on;
plot(nm,muaLE); hold on;
plot(nm,muaPD); hold on;
plot(nm,muaUBD); hold on;
plot(nm,muaRD); hold on;
plot(nm,muaDBP); grid on;
legend('stratus corneus', 'living epidermis', 'papillary dermis', 'upper blood net plexus', 'recitular dermis', 'deep blood net plexus');
title('Skin model layers absorption coefficients')
xlabel('wavelength [nm]');
ylabel('\mu_a [mc^-1]')


figure;
plot(nm, muaT); grid on;
title('Skin model absorption coefficient')
xlabel('wavelength [nm]');
ylabel('\mu_a [mc^-1]')

%% reduced scatering coefficient is considered constant for the differen layers

musp = 2e5*nm.^-1.5 + 2e12*nm.^-4; % the summ of both Mie scattering and Rayleigh scattering
% using the power law.

%% anisotropy 

g = 0.825; % costant as a mean between the different layers

% therefor mus can be calculated as

mus = musp./(1-g);

%% for a specific wavelength 

Lambda = 940; % wavelength in which I want to have the coefficient
xnm = round(Lambda)-nm(1,1); % find the index of lambda in the nm matrix

muaSTx = muaST(xnm)
muaLEx = muaLE(xnm)
muaPDx = muaPD(xnm)
muaUBDx = muaUBD(xnm)
muaRDx = muaRD(xnm)
muaDBPx = muaDBP(xnm)

muspX = musp(xnm)
musX = mus(xnm)

g

% save everything in one vector, the order is: ST, LE, PD, UBD,RD,DBP, mus,
% musp, g. Unit in mm^-1
coeff = zeros(9, 1);
coeff(1) = muaSTx/10;
coeff(2) = muaLEx/10;
coeff(3) = muaPDx/10;
coeff(4) = muaUBDx/10;
coeff(5) = muaRDx/10;
coeff(6) = muaDBPx/10;
coeff(7) = musX/10;
coeff(8) = muspX/10;
coeff(9) = g;









