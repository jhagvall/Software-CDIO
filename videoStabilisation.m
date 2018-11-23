function [output_video, count] = videoStabilisation(video,startframe,step,endframe)

registered_frames = struct('cdata',[]);

%Count how many frames that fails to registered
count = 0;

for m = startframe:step:endframe
    for n = 1:step 
        % Define the fixed frame, will be moved to every step-frame
        fixed = imageEnhancement(rgb2gray(video(m).cdata));
        % Define the moving frame
        moving = imageEnhancement(rgb2gray(video(m+n).cdata));
        [optimizer,metric] = imregconfig('monomodal');
        % The transform
        tform = imregtform(moving, fixed, 'affine', optimizer, metric);
        temp = tform.T; %Transform matrix
        if temp(3,1) < 7 && temp(3,2) < 7 && temp(3,1) > -7 && temp(3,2) > -7
            movingRegistered = imregister(moving, fixed, 'affine', optimizer,metric);
        else
            movingRegistered = moving;
            count = count + 1; 
        end
        registered_frames(m+n).cdata = movingRegistered;
    end
end

% Construct a video
output_video = constructVideo(registered_frames);

end