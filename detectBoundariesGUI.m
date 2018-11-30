function detectBoundariesGUI(image,BW)
captionFontSize = 14;
imshow(image);
imshow(image, 'parent', app.Extraaxis)
title('Boundaries', 'FontSize', captionFontSize); 
axis image; 
hold on;
boundaries = bwboundaries(BW,'holes');
nbr_boundaries = size(boundaries, 1);
for k = 1 : nbr_boundaries
	temp_boundary = boundaries{k};
	plot(temp_boundary(:,2), temp_boundary(:,1), 'r', 'LineWidth', 2);
end
hold off;
end