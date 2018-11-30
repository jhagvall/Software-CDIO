%% Software Tests
%Test number 4
close all
clear all

[video,frames,vidWidth, vidHeight,framerate] = splitFrames('S2ST3306.MOV');

frame_100 = video(100).cdata;

remove_channel = removeChannel(frame_100);
grayscale = rgb2gray(remove_channel);
normalize = normalizeVessels(grayscale);
enhanced = imageEnhancement(normalize);
segmented = segmentImage(enhanced,0.64,10000);

size = sizeCalculation(segmented);

%% Test 29 vessles

close all
clear all

[video,frames,vidWidth, vidHeight,framerate] = splitFrames('S2ST3306.MOV');
frame_100 = video(100).cdata;

figure,imshow(frame_100)

remove_channel = removeChannel(frame_100);
grayscale = rgb2gray(remove_channel);
normalize = normalizeVessels(grayscale);
enhanced = imageEnhancement(normalize);
segmented = segmentImage(enhanced,0.64,10000);

figure,imshow(segmented)


%% Test 29 apexes
close all
clear all
spot_img = imread('dots2_cropped.png');
figure,imshow(spot_img)

grayscale = rgb2gray(spot_img);
normalize = normalizeApexes(grayscale);
segmented = segmentSpot(normalize);

figure,imshow(segmented)

%% Test 23 vessels
close all
clear all
[video,frames,vidWidth, vidHeight,framerate] = splitFrames('S2ST3306.MOV');
frame_100 = video(100).cdata;

remove_channel = removeChannel(frame_100);
grayscale = rgb2gray(remove_channel);
normalize = normalizeVessels(grayscale);
enhanced = imageEnhancement(normalize);

figure,imshowpair(frame_100,enhanced,'montage')

%% Test 23 own images
close all
clear all
img = imread('Fiber_NewCamera_0.png');

remove_channel = removeChannel(img);
grayscale = rgb2gray(remove_channel);
normalize = normalizeVessels(grayscale);
enhanced = imageEnhancement(normalize);

figure,imshowpair(img,enhanced,'montage')

%% Test 31 own images
close all
clear all
img = imread('Fiber_NewCamera_0.png');

figure,imshow(img)

remove_channel = removeChannel(img);
grayscale = rgb2gray(remove_channel);
normalize = normalizeVessels(grayscale);
enhanced = imageEnhancement(normalize);
segmented = segmentImage(enhanced,0.64,1000);

figure,detectBoundaries(enhanced,segmented)

%% Test 2
close all
clear all
img = imread('test_12_frame200.png');

remove_channel = removeChannel(img);
grayscale = rgb2gray(remove_channel);
normalize = normalizeVessels(grayscale);
enhanced = imageEnhancement(normalize);
segmented = segmentSpot(enhanced);

figure,imshowpair(segmented,img,'montage')

%%
