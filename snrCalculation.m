function SNR = snrCalculation(img)
% Calculation of the signal to noise ratio
% SNR = µ/σ 
% µ is the mean of the image and σ the standard deviation

% Calculate the mean and standard deviation of the image and from that, the
% SNR
mu = mean(img(:));
sigma = std(img(:));
SNR = 10*log10(mu/sigma);




