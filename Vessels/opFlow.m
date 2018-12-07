function output_video = opFlow(video, startframe, endframe)
%Calculates the optical flow object for each frame and displayes it on top
%of the video, saves all the video frames with the displayed flow as a
%struct

opticFlow = opticalFlowHS; %Horn-Schunk method

figure(1)
for n = startframe:endframe
    video_frame = rgb2gray(video(n).cdata);

    flow = estimateFlow(opticFlow,video_frame); %Estimate the flow
    
    imshow(video_frame)
    hold on
    plot(flow,'ScaleFactor',70) 
    drawnow
    F = getframe;
    F_all(n).cdata = F.cdata; %Saves all frames in a struct
    hold off
end

% Construct movie
output_video = constructVideo(F_all);

end