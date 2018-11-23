% Optical flow from one frame to another

vidReader = VideoReader('test2_new.mov');

opticFlow = opticalFlowLK('NoiseThreshold',0.009);

figure(1)
while hasFrame(vidReader)
    frameRGB = readFrame(vidReader);
    frameGray = rgb2gray(frameRGB);
    
    flow = estimateFlow(opticFlow,frameGray);

    imshow(frameRGB)
    hold on
    plot(flow, 'DecimationFactor',[5 5],'ScaleFactor',70)
    hold off
end

%%
figure(1)
imshow(frameRGB)
hold on
plot(flow, 'ScaleFactor',70)

%%

%[video, frames] = splitFrames('S2ST3306.MOV');

video = load('stabilised_IMT8.mat');
video = video.registered_video;

%%

hf = figure;
set(hf,'position',[480 640 640 480]);

movie(hf,video,1,50)

%%

opticFlow = opticalFlowLK('NoiseThreshold',0.009);
count = 0;

figure(1)
for n = 1:100
    video_frame = rgb2gray(video(n).cdata);

    flow = estimateFlow(opticFlow,video_frame);
    
    count = count + 1;
    imshow(video_frame)
    hold on
    plot(flow,'ScaleFactor',70)
    hold off
end


