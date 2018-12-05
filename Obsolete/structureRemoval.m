function nlargeststructures = structureRemoval(img, nrofstructures)


% Get the complement of the image to be able to label the vessels (and
% noise spots)
BWc = imcomplement(img);

% Get the number of objects in the image, n, and the objects label in an
% image, L
[L, n] = bwlabel(BWc);

% Create an image matrix with the same size as the image
nlargeststructures = false(size(img));

% Create and empty array in which to store the size of the objects at the
% index corresponding to the objects label 
objectsize = zeros(n,1);

% Get the size of all the objects and store them in objectsize at the index
% corresponding to their label
for i=1:n
    [r,~] = find(L==i);
    objectsize(i) = length(r);
end

for i=1:nrofstructures
    [~, idx] = max(objectsize); % Get the largest object and it's label/index
    objectsize(idx) = 0;
    [r,c] = find(L==idx);
    for j = 1:size(r)
        nlargeststructures(r(j),c(j)) = 1;
    end
end

% Get the complement again to go back to the original color map
nlargeststructures = imcomplement(nlargeststructures);











