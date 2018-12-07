function [distance,mean_distance] = spotDistance(measurements)
%Takes label measurements and returns the average distance between the
%nearest neighbor label between all labels.

allCentroids = [measurements.Centroid];
centroidsX = allCentroids(1:2:end-1);
centroidsY = allCentroids(2:2:end);
center_cord = [centroidsX' centroidsY'];

%Extracts the distance to the nearest neighbor for each data point
dist_nn = ipdm(center_cord,'Subset','NearestNeighbor','result','struct');
mean_distance = mean(dist_nn.distance);

distance = dist_nn;
end