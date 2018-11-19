function enhanced_image = imageEnhancement(image)
claheimg = adapthisteq(image);
medianimg = medfilt2(claheimg);
contrastimg = imadjust(medianimg,stretchlim(medianimg),[]);
enhanced_image = contrastimg;
end