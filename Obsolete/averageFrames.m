function averimg = averageFrames(video, startframe, nrframes)

% I0 = im2double(rgb2gray(splitFrames(movie,200)));
sumimg = im2double(rgb2gray(video(startframe).cdata));
video_length = length(video);

for n = startframe : startframe+nrframes
    if startframe+nrframes > video_length
        averimg = []; 
    else
        img = rgb2gray(video(n).cdata);
        sumimg = sumimg + im2double(img);
        averimg = sumimg/nrframes;
    end
end

end