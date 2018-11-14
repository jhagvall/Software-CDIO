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

[video, frames] = splitFrames('sampleimg (Converted).mov');
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
optimizer.MaximumIterations = 800;
% optimizer.RelaxationFactor = 0.5;

% Registers the moving image to the fixed image
movingRegistered = imregister(moving, fixed, 'affine', optimizer,metric);

figure(2)
imshowpair(fixed, movingRegistered)
