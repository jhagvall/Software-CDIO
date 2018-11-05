% The main file for the software

%% Only one frame

%Using frame 100
%Extracting frame 100
stillimg = splitFrames('S2ST3306.MOV',50);

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
original_image = rgb2gray(splitFrames('test2_new.mov',200));
averaged_image = averageFrames('test2_new.mov',200,5);

figure(3)
imshow(original_image)
figure(4)
imshow(averaged_image)

%Applying a grid to the image
applyGrid(contrastimg,3)
title('Contrast image with applied grid')