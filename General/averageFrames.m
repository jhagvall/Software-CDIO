function averimg = averageFrames(video, startframe, nrframes)
%Average concecutive frames decided by nrframes in input video from 
%startframe. Returns the average frame.  

sumimg = im2double(rgb2gray(video(startframe).cdata)); %Sets start image
video_length = length(video);

for n = startframe : startframe+nrframes
    if startframe+nrframes > video_length %If frames exceed length of video
        averimg = []; 
    else
        img = rgb2gray(video(n).cdata);
        sumimg = sumimg + im2double(img);
        averimg = sumimg/nrframes;
    end
end

end