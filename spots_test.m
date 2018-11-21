close all
spot_img = imread('dots2.png');

spot_img = rgb2gray(spot_img);

% spot_img = imadjust(spot_img,stretchlim(spot_img),[]);
%%


A = fft2(double(spot_img)); % compute FFT of the grey image
A1=fftshift(A); % frequency scaling


% Gaussian Filter Response Calculation

[M N]=size(A); % image size
R=20; % filter size parameter 
X=0:N-1;
Y=0:M-1;
[X Y]=meshgrid(X,Y);
Cx=0.5*N;
Cy=0.5*M;
Lo=exp(-((X-Cx).^2+(Y-Cy).^2)./(2*R).^2);
Hi=1-Lo; % High pass filter=1-low pass filter

% Filtered image=ifft(filter response*fft(original image))

% K=A1.*Hi;
% K1=ifftshift(K);
% B2=ifft2(K1);

J=A1.*Lo;
J1=ifftshift(J);
B1=ifft2(J1);

% ideal = IdealLowPass(spot_img,0.006);



new_img = double(spot_img)./double(B1);
new_img = real(new_img);

new_img = imageEnhancement(new_img);

thresh = multithresh(new_img,2);
valuesMax = [thresh max(new_img(:))];
[quant_spot, index] = imquantize(new_img,thresh, valuesMax);

BW = makeBinary(quant_spot,0.64);
BW_new = bwareaopen(BW,50);



BWcomp = imcomplement(BW);

labeledImage = bwlabel(BWcomp, 8);
figure(1)
imshow(labeledImage, []);
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
figure(2)
imshow(coloredLabels);

blobMeasurements = regionprops(labeledImage, spot_img, 'all');
numberOfBlobs = size(blobMeasurements, 1);

figure, imshowpair(coloredLabels, spot_img, 'montage')
%%
captionFontSize = 14;
imshow(spot_img);
title('Outlines, from bwboundaries()', 'FontSize', captionFontSize); 
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
hold on;
boundaries = bwboundaries(BW,'holes');
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
	plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;
%%

% Now I'll demonstrate how to select certain blobs based using the ismember() function.
% Let's say that we wanted to find only those blobs
% with an intensity between 150 and 220 and an area less than 2000 pixels.
% This would give us the three brightest dimes (the smaller coin type).
allBlobIntensities = [blobMeasurements.MeanIntensity];
allBlobAreas = [blobMeasurements.Area];
% Get a list of the blobs that meet our criteria and we need to keep.
% These will be logical indices - lists of true or false depending on whether the feature meets the criteria or not.
% for example [1, 0, 0, 1, 1, 0, 1, .....].  Elements 1, 4, 5, 7, ... are true, others are false.
allowableIntensityIndexes = (allBlobIntensities > 10) & (allBlobIntensities < 220);
allowableAreaIndexes = allBlobAreas > 100; % Take the small objects.
% Now let's get actual indexes, rather than logical indexes, of the  features that meet the criteria.
% for example [1, 4, 5, 7, .....] to continue using the example from above.
keeperIndexes = find(allowableIntensityIndexes & allowableAreaIndexes);
% Extract only those blobs that meet our criteria, and
% eliminate those blobs that don't meet our criteria.
% Note how we use ismember() to do this.  Result will be an image - the same as labeledImage but with only the blobs listed in keeperIndexes in it.
keeperBlobsImage = ismember(labeledImage, keeperIndexes);
% Re-label with only the keeper blobs kept.
labeledDimeImage = bwlabel(keeperBlobsImage, 8);     % Label each blob so we can make measurements of it
% Now we're done.  We have a labeled image of blobs that meet our specified criteria.

imshow(labeledDimeImage, []);
axis image;
title('"Keeper" blobs', 'FontSize', captionFontSize);