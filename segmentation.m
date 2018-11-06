%% Try averaging binary images

%Using frame 100
%Extracting frame 100 to 109
[movie,frames] = splitFrames('sampleimg (Converted).mov');
stillimg0 = movie(100).cdata;
stillimg1 = movie(101).cdata;
stillimg2 = movie(102).cdata;
stillimg3 = movie(103).cdata;
stillimg4 = movie(104).cdata;
stillimg5 = movie(105).cdata;
stillimg6 = movie(106).cdata;
stillimg7 = movie(107).cdata;
stillimg8 = movie(108).cdata;
stillimg9 = movie(109).cdata;

%Converting image to gray scale
grayimg0 = convert2gray(stillimg0);
grayimg1 = convert2gray(stillimg1);
grayimg2 = convert2gray(stillimg2);
grayimg3 = convert2gray(stillimg3);
grayimg4 = convert2gray(stillimg4);
grayimg5 = convert2gray(stillimg5);
grayimg6 = convert2gray(stillimg6);
grayimg7 = convert2gray(stillimg7);
grayimg8 = convert2gray(stillimg8);
grayimg9 = convert2gray(stillimg9);

% Enhance the image
enhancedimg0 = imageEnhancement(grayimg0);
enhancedimg1 = imageEnhancement(grayimg1);
enhancedimg2 = imageEnhancement(grayimg2);
enhancedimg3 = imageEnhancement(grayimg3);
enhancedimg4 = imageEnhancement(grayimg4);
enhancedimg5 = imageEnhancement(grayimg5);
enhancedimg6 = imageEnhancement(grayimg6);
enhancedimg7 = imageEnhancement(grayimg7);
enhancedimg8 = imageEnhancement(grayimg8);
enhancedimg9 = imageEnhancement(grayimg9);

%%
% Make image binary
sense = 0.64;

BW0 = makeBinary(enhancedimg0, sense);
BW1 = makeBinary(enhancedimg1, sense);
BW2 = makeBinary(enhancedimg2, sense);
BW3 = makeBinary(enhancedimg3, sense);
BW4 = makeBinary(enhancedimg4, sense);
BW5 = makeBinary(enhancedimg5, sense);
BW6 = makeBinary(enhancedimg6, sense);
BW7 = makeBinary(enhancedimg7, sense);
BW8 = makeBinary(enhancedimg8, sense);
BW9 = makeBinary(enhancedimg9, sense);



% Fill holes
BWF0 = imfill(BW0, 'holes');
BWF1 = imfill(BW1, 'holes');
BWF2 = imfill(BW2, 'holes');
BWF3 = imfill(BW3, 'holes');
BWF4 = imfill(BW4, 'holes');
BWF5 = imfill(BW5, 'holes');
BWF6 = imfill(BW6, 'holes');
BWF7 = imfill(BW7, 'holes');
BWF8 = imfill(BW8, 'holes');
BWF9 = imfill(BW9, 'holes');


%% Remove connected pixels

% Inverse the image so the black becomes white and vice versa
compimg = imcomplement(BWF0);
% Remove objects (groups of white pixels) that are less than 10 000 pixels
BWF0Rc = bwareaopen(compimg, 10000);

% Inverse it again to make it look like the original
BWF0R = imcomplement(BWF0Rc);

% Show the images next to eachother to see the difference
figure(2)
imshowpair(BWF0, BWF0R, 'montage')

%%
% Count in how many images the pixel is black or white
binaryAve = pixelAverage(BWF0,BWF1,BWF2,BWF3,BWF4,BWF5,BWF6,BWF7,BWF8,BWF9);

% Show images of original, binary image, binary with filled and the with
% removed connected pixels
figure(1)
subplot(2,2,1)
imshow(grayimg0)
subplot(2,2,2)
imshow(BW0)
subplot(2,2,3)
imshow(BWF0)
subplot(2,2,4)
imshow(BWF0R)




%% Calculate density

<<<<<<< HEAD
 
=======
% Number of non-zero arguments in the image matrix divided by the total
% amount of pixels (number of pixels widdth* number of pixels height)
>>>>>>> 2a172fef99b4223b775512e676e7310a6c936d14
density = nnz(imcomplement(BWF0R))/(size(BWF0R,1)*size(BWF0R,2))








