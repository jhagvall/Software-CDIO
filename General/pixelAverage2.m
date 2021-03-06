function output_img = pixelAverage2(image_struct,vidHeight,vidWidth,limit)
%Takes a struct with several segmented images and returns a binary image
%with pixels classified after what they appear as most frequently in each
%frame of the struct.

ave_img = zeros([vidHeight vidWidth]);
% Calculates the average binary pixel values
for i = 1:length(image_struct)
    ave_img = ave_img + image_struct(i).cdata;
end
output = ave_img/length(image_struct);

% Make pixels that are black in majority of images 0
output(output < limit) = 0;

% Make the image logical, all values >0 will be 1
output_img=logical(output);
end