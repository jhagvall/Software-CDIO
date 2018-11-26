function registered_frame = imageStabilisation(video,frame1,frame2)

% Choose the frames to be registered
moving = rgb2gray(video(frame1).cdata);
fixed = rgb2gray(video(frame2).cdata);
count = 0;

[optimizer,metric] = imregconfig('monomodal');

% The transform
tform = imregtform(moving, fixed, 'affine', optimizer, metric);
temp = tform.T; %Transform matrix
if temp(3,1) < 7 && temp(3,2) < 7 && temp(3,1) > -7 && temp(3,2) > -7
    movingRegistered = imregister(moving, fixed, 'affine', optimizer,metric);
else
    movingRegistered = moving;
    count = 1;
end

registered_frame = movingRegistered;

end