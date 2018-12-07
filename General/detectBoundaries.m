function detectBoundaries(image,BW)
%Takes a gray scale image and a binary image and detects the boundaries of
%objects. Plots the detected boundaries in a figure.
captionFontSize = 14;
imshow(image);
title('Boundaries', 'FontSize', captionFontSize); 
axis image; 
hold on;
boundaries = bwboundaries(BW,'holes'); %Extracts the boundaries from the binary image
nbr_boundaries = size(boundaries, 1);
for k = 1 : nbr_boundaries
	temp_boundary = boundaries{k};
	plot(temp_boundary(:,2), temp_boundary(:,1), 'r', 'LineWidth', 2);
end
hold off;
end