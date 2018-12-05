function SNR = snrCalculation(segmentedimg, grayimg)
%Calculates the signal to noise ratio for detected objects in a binary
%image
% SNR = µ/σ 
% µ is the mean of the image and �the standard deviation

% Get the pixels where the vessels are and put them im a matrix from which
% we can get the mean and standard deviation
[row, col] = find(segmentedimg == 0);

% If there are no vessels identified, set SNR to infinity
% Otherwise, calculate it as described below
if isempty(row)
    SNR = inf;
else
    for i = 1:length(row)
        vessels(i) = grayimg(row(i), col(i));
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



