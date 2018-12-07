function segmentedimg = segmentImage(enhancedimg,sense,pixelremoval)
%Creates a binary segmented image, fill holes and removes objects smaller than
%the input pixelremoval. Returns the segmented image.  

pixelremoval = round(pixelremoval);
BW0 = makeBinary(enhancedimg, sense);
BWF0 = imfill(BW0, 'holes');

% Inverse the image so the black becomes white and vice versa
compimg = imcomplement(BWF0);

% Remove objects (groups of white pixels) that are less than "pixelremoval" pixels
BWF0Rc = bwareaopen(compimg, pixelremoval);

% Inverse it again to make it look like the original
segmentedimg = imcomplement(BWF0Rc);
end