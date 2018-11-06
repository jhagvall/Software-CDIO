function segmentedimg = segmentImage(enhancedimg,sense)

BW0 = makeBinary(enhancedimg, sense);
BWF0 = imfill(BW0, 'holes');

% Inverse the image so the black becomes white and vice versa
compimg = imcomplement(BWF0);

% Remove objects (groups of white pixels) that are less than 10 000 pixels
BWF0Rc = bwareaopen(compimg, 10000);

% Inverse it again to make it look like the original
segmentedimg = imcomplement(BWF0Rc);
end