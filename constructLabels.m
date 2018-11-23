function [labels,spotMeasurements,nbrSpots] = constructLabels(image,area)
BWcomp = imcomplement(image);
labeledImage = bwlabel(BWcomp, 8);

blobMeasurements = regionprops(labeledImage, image, 'all');

allBlobAreas = [blobMeasurements.Area];
allowableAreaIndexes = allBlobAreas > area;

keeperIndexes = find(allowableAreaIndexes);
keeperBlobsImage = ismember(labeledImage, keeperIndexes);

new_labeledImage = bwlabel(keeperBlobsImage, 8);

blobMeasurements = regionprops(new_labeledImage, image, 'all');
numberOfBlobs = size(blobMeasurements, 1);

labels = new_labeledImage;
spotMeasurements = blobMeasurements;
nbrSpots = numberOfBlobs;
end