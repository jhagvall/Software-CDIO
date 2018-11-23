function [distance,mean_distance] = spotDistance(measurements)
allCentroids = [measurements.Centroid];
centroidsX = allCentroids(1:2:end-1);
centroidsY = allCentroids(2:2:end);
center_cord = [centroidsX' centroidsY'];

dist_nn = ipdm(center_cord,'Subset','NearestNeighbor','result','struct');
mean_distance = mean(dist_nn.distance);

distance = dist_nn;

end