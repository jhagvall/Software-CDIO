function averagediameter = sizeCalculation(image)
%%%%%%% Calculate the size of the objects
% 
% Input is an image. This will be changed to a function later
%
%%%%%%%

% Right now, this is a script and not a function, the code just below will
% make the user chose a file. Then it will enhance and segment the image.
% To open a video file
% [filename, pathname] = uigetfile( ...
%     {'*.mov;*.MOV;*.avi;*.mpg;*.mpeg','Video Files (*.mov,*.MOV,*.avi*.mpg,*.mpeg)';
%      '*.*',  'All Files (*.*)'}, ...
%      'Select a video file');
%  
% 
% [movie,frames] = splitFrames(filename);
% img = movie(100).cdata;
% grayimg = convert2gray(img);
% enhancedimg = imageEnhancement(grayimg);
% BW = segmentImage(enhancedimg, 0.64, 10000);


%% Calculate the euclidean distance between a pixel and the nearest nonzero 
% pixel in the binary image
% Calculate the euclidean distance transform of the binary image
D = bwdist(image);
% Extract the skeleton of the binary image
skeleton = bwmorph(imcomplement(image), 'skel', inf);

% Show the skeleton and the binary image
% figure(1)
% imshowpair(skeleton, BW, 'montage')

% Remove the spurs from the skeleton (the small branch points) which is not
% actually part of the diameter of the vessels
minSpurs = bwmorph(skeleton,'spur',Inf);

% Show the skeleton with removed spurs and the binary image
% figure(2)
% imshowpair(minSpurs, BW, 'montage')
% title('Skeleton (center of the vessel) and original image')

% Show skeleton with min spurs and original skeleton
% figure(3)
% imshowpair(minSpurs, skeleton, 'montage')

% Find the pixels of the spur of the skeleton
[row, col] = find(minSpurs);

% The skeleton is the middle point of the structure (vessels). Extract the
% value of the EDT at the pixels where the skeleton is at. That is the
% distance from the middle of the vessels to the boundary. Multiply it by
% two to get the diameter
diameter = zeros(size(D));
for i = 1:size(row)
    diameter(row(i),col(i)) = 2*D(row(i),col(i));
end

% Calculate the average diameter (in pixels) of the vessels and show it in
% the image
[~,~, diameterValues] = find(diameter);
pixeldiameter = mean(diameterValues);

averagediameter = pixeldiameter/((size(image,1)+size(image,2))/2)*1000;

% figure(4)
% imshow(BW)
% txt = ['Average diameter of the vessels: ' num2str(averageDiameter) ' pixels'];
% text(4, 0.5, txt)

end


