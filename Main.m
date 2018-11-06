% The main file for the software

%% Only one frame

%Using frame 100
%Extracting frame 100
[movie, frames] = splitFrames('S2ST3306.MOV');
stillimg = movie(50).cdata;

%Converting image to gray scale
grayimg = convert2gray(stillimg);

%Perfomering histogram equalization & bilinear interpolation
CLAHEimg = CLAHE(grayimg);

%Subploting the three images
figure(1)
subplot(1,3,1)
imshow(stillimg)
title('Origianl image')
subplot(1,3,2)
imshow(grayimg)
title('Grayscale image')
subplot(1,3,3)
imshow(CLAHEimg)
title('CLAHE image')

%Noise removal using a median filter
medianimg = medfilt2(CLAHEimg);

%Contrast adjustment
contrastimg = imadjust(medianimg,stretchlim(medianimg),[]);

%Subploting of three figures
figure(2)
subplot(2,2,1)
imshow(CLAHEimg)
title('CLAHE image')
subplot(2,2,2)
imshow(medianimg)
title('Median image')
subplot(2,2,3)
imshow(contrastimg)
title('Contrast enhancement')
subplot(2,2,4)
imshow(grayimg)
title('Original grayscale image')

%Average of frames
[rgbMovie, frames] = splitFrames('test2_new.mov');
original_image = rgb2gray(rgbMovie(200).cdata);
averaged_image = averageFrames(rgbMovie, 200,5);

figure(3)
imshow(original_image)
figure(4)
imshow(averaged_image)

%% Optional 

averaged_frames = averageFrames(rgbMovie,1,10);
enhanced_image = imageEnhancement(averaged_frames);

figure(4)
subplot(1,2,1)
imshow(averaged_frames)
title('Original averaged image')
subplot(1,2,2)
imshow(enhanced_image)
title('Enhanced averaged image')

%% De Backers score

%Applying a grid to the image
applyGrid(enhanced_image,3)
title('Contrast image with applied grid')

vessels_crossing_lines = 15; %Calculated manually and entered here
densityofvessels = DeBackers(enhanced_image,3,vessels_crossing_lines,2); 
%Unit is number of vessels/mm 

%% Segment Image

segmentimg = segmentImage(contrastimg,0.64);

figure(5)
imshow(segmentimg)

% Calculate density of vessels

% Number of non-zero arguments in the image matrix divided by the total
% amount of pixels (number of pixels widdth* number of pixels height)
density = nnz(imcomplement(segmentimg))/(size(segmentimg,1)*size(segmentimg,2));
