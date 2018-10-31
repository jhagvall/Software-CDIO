% Applies a grid to the image
function gridimg = applyGrid(image,n)
 figure(100)
 imshow(image)
axis on;
[rows, columns, numberOfColorChannels] = size(image);
hold on;
for row = 1 : round(size(image,1)/n) : rows
  line([1, columns], [row, row], 'Color', 'r');
end
for col = 1 : round(size(image,2)/n) : columns
  line([col, col], [1, rows], 'Color', 'r');
end
end