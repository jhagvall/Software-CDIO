%Takes a video and a wanted frame as input to return that certain frame of
%the input video
function movie =  splitFrames(videoname,frame)
vid = VideoReader(videoname);

vidWidth = vid.Width;
vidHeight = vid.Height;

mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'greyscale',[]);

k = 1;
while hasFrame(vid)
    mov(k).cdata = readFrame(vid);
    k = k+1;
end
movie = mov(frame).cdata;
end