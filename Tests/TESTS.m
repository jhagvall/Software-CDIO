%% TEST SCRIPT

%% Test nr 25 - Density of vessels, DeBackers

im = splitFrames('S2ST3306.MOV');
im = im(100).cdata;

remove_channel = removeChannel(im);
gray_image = rgb2gray(remove_channel);
normalised_image = normalizeVessels(gray_image);
enhanced_image = imageEnhancement(normalised_image);
segment_image = segmentImage(enhanced_image,0.64,10000);

%Manually
applyGrid(enhanced_image,4);
title('Manually calculated, number of vessels crossing grid lines = 38')
%%
%Automatic
auto_nr = autoCountVessels(segment_image,4);
applyGrid(segment_image,4);
title('Automatically calculated, number of vessels crossing grid lines = 36')
% De backers

auto_density = DeBackers(enhanced_image,4,auto_nr,2);
manual_density = DeBackers(enhanced_image,4,38,2);

%% Test 24 - De Backer on acquired image

im = imread('test_5_nailfold_littlefinger_OF_12.png');

remove_channel = removeChannel(im);
gray_image = rgb2gray(remove_channel);
normalised_image = normalizeVessels(gray_image);
enhanced_image = imageEnhancement(normalised_image);
segment_image = segmentImage(enhanced_image,0.64,10000);

figure,imshowpair(enhanced_image,segment_image,'montage')
%%
% Extract the skeleton of the binary image
skeleton = bwmorph(imcomplement(segment_image), 'skel', inf);

% Remove the spurs from the skeleton (the small branch points) which is not
% actually part of the diameter of the vessels
minSpurs = bwmorph(skeleton,'spur',Inf);
%%
figure, imshow(minSpurs)
%%

%Manually
applyGrid(enhanced_image,4);
title('Manually calculated, number of vessels crossing grid lines = 19')
%%
%Automatic
auto_nr = autoCountVessels(segment_image,4);
applyGrid(segment_image,4);
title('Automatically calculated, number of vessels crossing grid lines = 65')


%% Test nr 32

im = splitFrames('S2ST3306.MOV');
im = im(100).cdata;

remove_channel = removeChannel(im);
gray_image = rgb2gray(remove_channel);
normalised_image = normalizeVessels(gray_image);
enhanced_image = imageEnhancement(normalised_image);
segment_image = segmentImage(enhanced_image,0.64,10000);

detectBoundaries(enhanced_image,segment_image)

figure, imshow(im)

%% Test nr 32 - second occasion

im = imread('test_5_nailfold_littlefinger_OF_12.png');

remove_channel = removeChannel(im);
gray_image = rgb2gray(remove_channel);
normalised_image = normalizeVessels(gray_image);
enhanced_image = imageEnhancement(normalised_image);
segment_image = segmentImage(enhanced_image,0.64,10000);

detectBoundaries(enhanced_image,segment_image)

figure, imshow(im)

%% Test 12 

im = splitFrames('test_12_video2.avi');
im = im(200).cdata;

figure, imshow(im)

%% Test 26 - Density of vessels, segmentation acquired image

im = imread('test_5_nailfold_littlefinger_OF_12.png');

remove_channel = removeChannel(im);
gray_image = rgb2gray(remove_channel);
normalised_image = normalizeVessels(gray_image);
enhanced_image = imageEnhancement(normalised_image);
segment_image1 = segmentImage(enhanced_image,0.64,10000);

density_result = densityCalculation(segment_image);

figure, imshowpair(im,segment_image1,'montage')
%title('Calculated density of vessels is 13.1276 %')

%% Test 27 - Density of vessels, segmentation given image

im = splitFrames('S2ST3306.MOV');
im = im(100).cdata;

remove_channel = removeChannel(im);
gray_image = rgb2gray(remove_channel);
normalised_image = normalizeVessels(gray_image);
enhanced_image = imageEnhancement(normalised_image);
segment_image2 = segmentImage(enhanced_image,0.64,10000);

density_result = densityCalculation(segment_image);

figure, imshowpair(im, segment_image2, 'montage')
%title('Calculated density of vessels is 19.3988 %')



