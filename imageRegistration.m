%% Performing image registration using control points

[video, frames] = splitFrames('sampleimg (Converted).mov');
moving = video(50).cdata;
fixed = video(72).cdata;

%Select point to be mapped to each other
cpselect(moving, fixed)

tform = fitgeotrans(movingPoints,fixedPoints,'NonreflectiveSimilarity');

moving_registered = imwarp(moving,tform,'OutputView',imref2d(size(fixed)));
figure
imshowpair(fixed,moving_registered)

%% Automatic image registration

[video, frames] = splitFrames('S2ST3306.MOV');
% Choose the frames to be registered
moving = rgb2gray(video(50).cdata);
fixed = rgb2gray(video(550).cdata);

figure(1)
imshowpair(moving,fixed)

[optimizer,metric] = imregconfig('monomodal')

% Parameters to be changed to optimize the registration

%optimizer.GradientMagnitudeTolerance = 1*10^(-5);
%optimizer.MinimumStepLength = 1.5e-4;
%optimizer.MaximumStepLength = 0.07;
%optimizer.MaximumIterations = 800;
% optimizer.RelaxationFactor = 0.5;

% Registers the moving image to the fixed image
tform = imregtform(moving, fixed, 'affine', optimizer, metric)
movingRegistered = imregister(moving, fixed, 'affine', optimizer, metric);

figure(2)
imshowpair(fixed, movingRegistered)

%% Image registration for entire video, in progress

[video, frames] = splitFrames('S2ST3306.MOV');

%Select start frame and perform image enhancement
fixed = imageEnhancement(rgb2gray(video(6).cdata));
%Create struct to store the registered frames
registered_frames = struct('cdata',[]);

for n = 7:30 %frames
    moving = imageEnhancement(rgb2gray(video(n).cdata));
    [optimizer,metric] = imregconfig('monomodal');
    tform = imregtform(moving, fixed, 'affine', optimizer, metric)
    temp = tform.T;
    if temp(3,1) < 20 && temp(3,2) < 20
        movingRegistered = imregister(moving, fixed, 'affine', optimizer,metric);
    else
        movingRegistered = moving;
    end
    %fixed = movingRegistered; %Another idea
    registered_frames(n).cdata = movingRegistered;
end

% Remove empty frames
registered_frames = registered_frames(~cellfun(@isempty,{registered_frames.cdata}));

% Construct a video
registered_video = constructVideo(registered_frames);

%%
%Play stabilised video
hf = figure;
set(hf,'position',[480 640 640 480]);

movie(hf,registered_video,1,5)
