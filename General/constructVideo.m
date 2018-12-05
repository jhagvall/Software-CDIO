function video = constructVideo(frames)
%Constructs a video from consecutive frames and returns a video

F(length(frames)) = struct('cdata',[],'colormap',[]);
for i = 1:length(frames)
    temp = frames(i).cdata; %Extracts the current frame from the struct 
    f = figure('visible', 'off');
    imshow(temp);
    F(i) = getframe(gca);
end

video = F;
end