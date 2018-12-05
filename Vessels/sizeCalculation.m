function averagediameter = sizeCalculation(image)
%Calculate the average diameter in µm of the objects in the binary 
%input image and returns the average diameter

% The calculation will only be correct if the field of view is 1 mm^2


% Calculate the euclidean distance transform of the binary image
D = bwdist(image);
% Extract the skeleton of the binary image
skeleton = bwmorph(imcomplement(image), 'skel', inf);

% Remove the spurs from the skeleton (the small branch points) which is not
% actually part of the diameter of the vessels
minSpurs = bwmorph(skeleton,'spur',Inf);


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

% Get the average diameter in pixels. The image should be 1x1 millimieter
% which means that pixeldiameter/(mean of the height and width) should give
% the diameter in mm. Multiply by 1000 to get the unit Âµm
averagediameter = pixeldiameter/((size(image,1)+size(image,2))/2)*1000;

end


