function output = pixelAverage(img1, img2, img3, img4, img5, img6, img7, img8, img9, img10)


% Calculates the average binary pixel values
output = (img1+img2+img3+img4+img5+img6+img7+img8+img9+img10)/10;

% Make pixels that are black in majority of images 0
output(output < 0.9) = 0;

% Make the image logical, all values >0 will be 1
output=logical(output);
end





