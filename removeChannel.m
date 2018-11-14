function removed_image = removeChannel(image)
%Removes the red channel from the input image

red = image(:,:,1); % Red channel
a = zeros(size(frame_100, 1), size(frame_100, 2));
red_channel = cat(3, red, a, a);

removed_image = imsubtract(image,red_channel);
end