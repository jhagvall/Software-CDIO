%% Read frames
close all
[video,frames,vidWidth, vidHeight,framerate] = splitFrames('SDF_test1.mov');

frame_100 = video(79).cdata;

figure,imshow(frame_100)

removed_img = removeChannel(frame_100);
gray_img = rgb2gray(removed_img);

%% Enhancement

enhanced_img = imageEnhancement(gray_img);
segmented_img = segmentImage(enhanced_img,0.64,500);

figure, imshowpair(enhanced_img,segmented_img ,'montage')
title('Enhanced and segmented image')