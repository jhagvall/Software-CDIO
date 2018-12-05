function [labels,spotMeasurements,nbrSpots] = constructLabels(image,area)
%Conctructs labels of each segmented pixel cluster in a binary image with an area
%larger than input area. Returns the label image, measurements of the
%detected pixel clusters and number of clusters.

BWcomp = imcomplement(image);
labeledImage = bwlabel(BWcomp, 8);

Measurements = regionprops(labeledImage, image, 'all'); %Extracts measurements form binary image

allAreas = [Measurements.Area]; %Extracts area
allowableAreaIndexes = allAreas > area;

keeperIndexes = find(allowableAreaIndexes);
keeperImage = ismember(labeledImage, keeperIndexes); %Extracts all labels with chosen area

new_labeledImage = bwlabel(keeperImage, 8);

Measurements = regionprops(new_labeledImage, image, 'all');
nbr = size(Measurements, 1);

labels = new_labeledImage;
spotMeasurements = Measurements;
nbrSpots = nbr;
end