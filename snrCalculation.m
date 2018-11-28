function SNR = snrCalculation(img, sense, pixelremoval)
% Calculation of the signal to noise ratio
% SNR = µ/σ 
% µ is the mean of the image and σ the standard deviation

% Calculate the mean and standard deviation of the image and from that, the
% SNR
%img_double = double(img);
enhancedimg = imageEnhancement(img);
segmentedimg = segmentImage(enhancedimg, sense, pixelremoval);

% Get the pixels where the vessels are and put them im a matrix from which
% we can get the mean and standard deviation
[row, col] = find(segmentedimg == 0);

% If there are no vessels identified, set SNR to infinity
% Otherwise, calculate it as described below
if isempty(row)
    SNR = inf;
else
    for i = 1:length(row)
        vessels(i) = img(row(i), col(i));
    end
    % Make the image a double
    vessels = double(vessels);
    
    % Calculate the SNR as the mean of the signal divided by the standard
    % deviation of the signal (signal = the part of the image with vessels)
    mu = mean(vessels);
    sigma = std(vessels);
    SNR = 10*log10(mu/sigma);
end
end



