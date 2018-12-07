function getCentroids(spot_img)
%Plots all centroids by centerpoints of detected pixel clusters in a
%segmented binary image

norm_img = normalizeImage(spot_img);

segment_img = segmentSpot(norm_img);

[labels, measurements, spotnbr] = constructLabels(segment_img,80);

[dist,mean_dist] = spotDistance(measurements);

allCentroids = [measurements.Centroid]; %Extract all centerpoints from labels
centroidsX = allCentroids(1:2:end-1); %Extracts x-position of centerpoints
centroidsY = allCentroids(2:2:end); %Extract y-position of centerpoints

f=figure('visible', 'off');
imshow(spot_img)
hold on;
for k = 1 : spotnbr  %Loop through all spots
    plot(centroidsX(k)', centroidsY(k)', 'bx', 'MarkerSize', 10, 'LineWidth', 2);
end
hold off;

saveas(gca, 'temp', 'png');