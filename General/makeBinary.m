function output = makeBinary(img, sense)
%Creates a binary image using a gray scale image with adaptive threshold
%using the input sensitivity sense. 

output = imbinarize(img, 'adaptive', 'ForegroundPolarity', 'bright', 'Sensitivity', sense);
end