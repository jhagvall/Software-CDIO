% The main file for the software

%% Splitting frames from video
% Removed output parameter "frames" since it is unused in the code
[movie,~,vidWidth, vidHeight,framerate] = splitFrames('S2ST3306.MOV');

%% Only one frame
%Using frame 50
%Extracting frame 50
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
imshow(grayimg)
title('Original grayscale image')
subplot(2,2,2)
imshow(CLAHEimg)
title('CLAHE image')
subplot(2,2,3)
imshow(medianimg)
title('Median image')
subplot(2,2,4)
imshow(contrastimg)
title('Contrast enhancement')



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


%% Segment Image

segmentimg = segmentImage(contrastimg,0.64,10000);

figure(5)
imshow(segmentimg)

% Calculate density of vessels

% Number of non-zero arguments in the image matrix divided by the total
% amount of pixels (number of pixels widdth* number of pixels height)
density = nnz(imcomplement(segmentimg))/(size(segmentimg,1)*size(segmentimg,2));


%% De Backers score

%Applying a grid to the image
applyGrid(segmentimg,3)
title('Contrast image with applied grid')

vessels_crossing_lines = autoCountVessels(segmentimg,3);
densityofvessels = DeBackers(segmentimg,3,vessels_crossing_lines,2); 
%Unit is number of vessels/mm 

%% All frames
%Averageing all frames 

%Number of frames to average
nbr_ave_frames = 10;

%Averaging all frames with the set number of frames
averaged_frames = struct('cdata',[]);

for j = 1:nbr_ave_frames:frames
    temp_ave = averageFrames(movie,j,10);
    averaged_frames(j).cdata = temp_ave;
end
%Deletes all empty cells in the struct
averaged_frames = averaged_frames(~cellfun(@isempty,{averaged_frames.cdata}));

%Enhance all averaged frames

enhanced_frames = struct('cdata',[]);

for k = 1:length(averaged_frames)
    temp_enh = imageEnhancement(averaged_frames(k).cdata);
    enhanced_frames(k).cdata = temp_enh;
end

%Segment all processed images

segmented_frames = struct('cdata',[]);
%Sensitivity for threshold segmentation
sense = 0.64;

for l = 1:length(averaged_frames)
    temp_seg = segmentImage(enhanced_frames(l).cdata,sense,10000);
    segmented_frames(l).cdata = temp_seg;
end


