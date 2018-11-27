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

%% Plot optical flow in every frame - VISA MARCUS

[video, frames] = splitFrames('testing2.MOV');

F_all = struct('cdata',[]);

opticFlow = opticalFlowHS;

figure(1)
for n = 1:length(video)
    video_frame = rgb2gray(video(n).cdata);

    flow = estimateFlow(opticFlow,video_frame); %Estimate the flow
    
    imshow(video_frame)
    hold on
    plot(flow,'ScaleFactor',70) 
    drawnow
    F = getframe;
    F_all(n).cdata = F.cdata;
    hold off
end

%% Construct movie

opflow_movie = constructVideo(F_all);

%% Save movie

save optical_flow.mat opflow_movie

%% Load movie

S = load('optical_flow.mat');
S = S.opflow_movie;

%%
hf = figure;
set(hf,'position',[480 640 640 480]);

movie(hf,S,1,15)
close all

%% Plot optical flow with stabilised video 

video = load('stab2.mat');
video = video.stabilised_video;

%%

opticFlow = opticalFlowHS; %('NoiseThreshold',0.009);
count = 0;

figure(1)
for n = 11:length(video)
    video_frame = im2double(rgb2gray(video(n).cdata));

    flow = estimateFlow(opticFlow,video_frame);
    
    count = count + 1;
    imshow(video_frame)
    hold on
    plot(flow,'ScaleFactor',70) 
    drawnow
    hold off
end

%% Plot optical flow in every frame, tried to play around a bit with flow matrix

[video, frames] = splitFrames('testing2.MOV');

opticFlow = opticalFlowHS;
count = 0;
flow_saved_Vx = zeros(size(video(50).cdata,1),size(video(50).cdata,2));
flow_saved_Vy = zeros(size(video(50).cdata,1),size(video(50).cdata,2));

figure(1)
for n = 1:20
    video_frame = rgb2gray(video(n).cdata);

    flow = estimateFlow(opticFlow,video_frame);
  
    for k = 1:size(flow.Vx,1)
        for j = 1:size(flow.Vx,2)
            if flow.Vx(k,j) > 0.1 && flow.Vy(k,j) > 0.1
                flow_saved_Vx(k,j) = flow.Vx(k,j);
                flow_saved_Vy(k,j) = flow.Vy(k,j);
            end
        end
    end
    
    imshow(video_frame)
    hold on
    plot(flow,'ScaleFactor',70) 
    drawnow
    hold off
end