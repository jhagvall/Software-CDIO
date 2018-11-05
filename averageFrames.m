function averimg = averageFrames(movie, startframe, nrframes)

% I0 = im2double(rgb2gray(splitFrames(movie,200)));
sumimg = im2double(rgb2gray(splitFrames(movie,200)));

for n = startframe : startframe+nrframes
img = rgb2gray(splitFrames(movie,n));
sumimg = sumimg + im2double(img);
end

averimg = sumimg/nrframes;

end