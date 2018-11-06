%% Try averaging binary images

%Using frame 100
%Extracting frame 100 to 109
stillimg0 = splitFrames('sampleimg (Converted).mov',100);
stillimg1 = splitFrames('sampleimg (Converted).mov',101);
stillimg2 = splitFrames('sampleimg (Converted).mov',102);
stillimg3 = splitFrames('sampleimg (Converted).mov',103);
stillimg4 = splitFrames('sampleimg (Converted).mov',104);
stillimg5 = splitFrames('sampleimg (Converted).mov',105);
stillimg6 = splitFrames('sampleimg (Converted).mov',106);
stillimg7 = splitFrames('sampleimg (Converted).mov',107);
stillimg8 = splitFrames('sampleimg (Converted).mov',108);
stillimg9 = splitFrames('sampleimg (Converted).mov',109);

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


%Perfomering histogram equalization & bilinear interpolation
CLAHEimg0 = CLAHE(grayimg0);
CLAHEimg1 = CLAHE(grayimg1);
CLAHEimg2 = CLAHE(grayimg2);
CLAHEimg3 = CLAHE(grayimg3);
CLAHEimg4 = CLAHE(grayimg4);
CLAHEimg5 = CLAHE(grayimg5);
CLAHEimg6 = CLAHE(grayimg6);
CLAHEimg7 = CLAHE(grayimg7);
CLAHEimg8 = CLAHE(grayimg8);
CLAHEimg9 = CLAHE(grayimg9);


%Noise removal using a median filter
medianimg0 = medfilt2(CLAHEimg0);
medianimg1 = medfilt2(CLAHEimg1);
medianimg2 = medfilt2(CLAHEimg2);
medianimg3 = medfilt2(CLAHEimg3);
medianimg4 = medfilt2(CLAHEimg4);
medianimg5 = medfilt2(CLAHEimg5);
medianimg6 = medfilt2(CLAHEimg6);
medianimg7 = medfilt2(CLAHEimg7);
medianimg8 = medfilt2(CLAHEimg8);
medianimg9 = medfilt2(CLAHEimg9);

%Contrast adjustment
contrastimg0 = imadjust(medianimg0,stretchlim(medianimg0),[]);
contrastimg1 = imadjust(medianimg1,stretchlim(medianimg1),[]);
contrastimg2 = imadjust(medianimg2,stretchlim(medianimg2),[]);
contrastimg3 = imadjust(medianimg3,stretchlim(medianimg3),[]);
contrastimg4 = imadjust(medianimg4,stretchlim(medianimg4),[]);
contrastimg5 = imadjust(medianimg5,stretchlim(medianimg5),[]);
contrastimg6 = imadjust(medianimg6,stretchlim(medianimg6),[]);
contrastimg7 = imadjust(medianimg7,stretchlim(medianimg7),[]);
contrastimg8 = imadjust(medianimg8,stretchlim(medianimg8),[]);
contrastimg9 = imadjust(medianimg9,stretchlim(medianimg9),[]);
%%
% Make image binary
sense = 0.64;

BW0 = makeBinary(contrastimg0, sense);
BW1 = makeBinary(contrastimg1, sense);
BW2 = makeBinary(contrastimg2, sense);
BW3 = makeBinary(contrastimg3, sense);
BW4 = makeBinary(contrastimg4, sense);
BW5 = makeBinary(contrastimg5, sense);
BW6 = makeBinary(contrastimg6, sense);
BW7 = makeBinary(contrastimg7, sense);
BW8 = makeBinary(contrastimg8, sense);
BW9 = makeBinary(contrastimg9, sense);

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
compimg = imcomplement(BWF0);
BWF0Rc = bwareaopen(compimg, 10000);

BWF0R = imcomplement(BWF0Rc);
figure(2)
imshowpair(BWF0, BWF0R, 'montage')

%%
% Count in how many images the pixel is black or white
binaryAve = pixelAverage(BWF0,BWF1,BWF2,BWF3,BWF4,BWF5,BWF6,BWF7,BWF8,BWF9);

figure(1)
subplot(2,2,1)
imshow(grayimg0)
subplot(2,2,2)
imshow(BW0)
subplot(2,2,3)
imshow(BWF0)
subplot(2,2,4)
imshow(BWF0R)

figure(2)
imshowpair(BWF0, binaryAve, 'montage')




%% Calculate density

 
density = nnz(imcomplement(BWF0R))/(size(BWF0R,1)*size(BWF0R,2))








