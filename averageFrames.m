function averimg = averageFrames(movie, startframe, nrframes)

% I0 = im2double(rgb2gray(splitFrames(movie,200)));
sumimg = im2double(rgb2gray(movie(startframe).cdata));
movie_length = length(movie);

for n = startframe : startframe+nrframes
    if startframe+nrframes > movie_length
        averimg = []; 
    else
        img = rgb2gray(movie(n).cdata);
        sumimg = sumimg + im2double(img);
        averimg = sumimg/nrframes;
    end
end

end