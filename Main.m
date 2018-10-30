% The main file for the software

%% Only one frame

%Using frame 100
%Extracting frame 100
stillimg = splitFrames('S2ST3306.MOV',100);

%Converting image to gray scale
grayimg = convert2gray(stillimg);

%Perfomering histogram equalization & bilinear interpolation
CLAHEimg = CLAHE(grayimg);

%Subploting the three images
figure(1)
subplot(1,3,1)
imshow(stillimg)
subplot(1,3,2)
imshow(grayimg)
subplot(1,3,3)
imshow(CLAHEimg)

%Noise removal using a median filter
medianimg = medfilt2(CLAHEimg);

%Contrast adjustment
contrastimg = imadjust(medianimg,stretchlim(medianimg),[]);

%Subploting 

