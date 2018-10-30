vid = VideoReader('test2_new.mov');

vidWidth = vid.Width;
vidHeight = vid.Height;

mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'greyscale',[]);

k = 1;
while hasFrame(vid)
    mov(k).cdata = readFrame(vid);
    k = k+1;
end

% stillimg = mov.cdata;
% stillimg = stillimg(100,100,:);

figure(1)
stillimg = mov(100).cdata;
image(stillimg)

y=1;