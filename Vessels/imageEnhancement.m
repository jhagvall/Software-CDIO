function enhanced_image = imageEnhancement(image)
%Function to enhance contrast in images. Returns the fully enhanced image.

claheimg = adapthisteq(image); %Histogram equalization
medianimg = medfilt2(claheimg); %Median filtering
contrastimg = imadjust(medianimg,stretchlim(medianimg),[]); %Contrast stretching
enhanced_image = contrastimg;
end