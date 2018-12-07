function [output_video, count] = videoStabilisation(video,startframe,step,endframe)
%Performs registration for all frames in a video with a certain step.
%Returns the fully registered video.

registered_frames = struct('cdata',[]);

%Count how many frames that fails to be registered
count = 0;

for m = startframe:step:endframe
    for n = 1:step 
        % Define the fixed frame, will be moved to every step-frame
        fixed = rgb2gray(video(m).cdata);
        % Define the moving frame
        moving = imageEnhancement(rgb2gray(video(m+n).cdata));
        [optimizer,metric] = imregconfig('monomodal');
        % The transform
        tform = imregtform(moving, fixed, 'affine', optimizer, metric);
        temp = tform.T; %Transform matrix
        %If transform matrix is to large, use the untransformed frame
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