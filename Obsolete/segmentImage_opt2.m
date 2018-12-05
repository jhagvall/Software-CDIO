function segmentedimg = segmentImage(enhancedimg,sense, keepstructures)%,pixelremoval)

%pixelremoval = round(pixelremoval);
BW0 = makeBinary(enhancedimg, sense);
BWF0 = imfill(BW0, 'holes');

% Segment the image with the new function that keeps the "keepstructures"
% amount of structures remaining
segmentedimg = structureRemoval(BWF0, keepstructures);

end