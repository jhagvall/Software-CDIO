% CLAHE


[img] = splitFrames('eye6.avi.MOV', 100);

img_grey = rgb2gray(img);

CLAHE_img = adapthisteq(img_grey, 'NumTiles', [8 8], 'clipLimit', 0.03);

figure(1)
imshow(CLAHE_img)
