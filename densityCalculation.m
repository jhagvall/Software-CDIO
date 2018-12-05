function density = densityCalculation(segmentedimage)
% Takes a segmented image as input argument and calculates the amount of 
% black pixels as a percentage of all pixels. Returns the density of
% vessels, the percentage of black pixels.

density = 100*nnz(imcomplement(segmentedimage))/(size(segmentedimage,1)*size(segmentedimage,2));
end