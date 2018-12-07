function [video,frames,vidWidth, vidHeight, framerate] =  splitFrames(videoname)
%Takes a video and a wanted frame as input to return that certain frame of
%the input video, the total number of frames, the width and height of the
%video and the frame rate.
vid = VideoReader(videoname);

vidWidth = vid.Width;
vidHeight = vid.Height;

mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

k = 1;
while hasFrame(vid)
    mov(k).cdata = readFrame(vid);
    k = k+1;
end
video = mov;
frames = k-1;
framerate = vid.FrameRate;
end