%Takes a video and a wanted frame as input to return that certain frame of
%the input video
function [movie,frames] =  splitFrames(videoname)
vid = VideoReader(videoname);

vidWidth = vid.Width;
vidHeight = vid.Height;

mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

k = 1;
while hasFrame(vid)
    mov(k).cdata = readFrame(vid);
    k = k+1;
end
movie = mov;
frames = k-1;
end