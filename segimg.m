function segmentedimg = segimg(enhancedimg,sense,pixelremoval)

pixelremoval = round(pixelremoval);
BW0 = makeBinary(enhancedimg, sense);
%Find the edges of the structures
edges_vessel = edge(BW0,'Canny');
%Fill all the holes
BWF0 = imfill(edges_vessel, 'holes');
%Identify hole pixels
holes = BWF0 & ~BW0;
%Eliminate small holes from the hole image
bigholes = bwareaopen(holes, 200);
%Identify small holes
smallholes = holes & ~bigholes;
%Fill the small holes
new = BW0 | smallholes;
% Inverse the image so the black becomes white and vice versa
compimg = imcomplement(new);

% Remove objects (groups of white pixels) that are less than "pixelremoval" pixels
BWF0Rc = bwareaopen(compimg, pixelremoval);

% Inverse it again to make it look like the original
segmentedimg = imcomplement(BWF0Rc);

end