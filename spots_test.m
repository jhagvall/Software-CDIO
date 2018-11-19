%% PNG

spot_img = imread('dots2.png');
spot_gray = rgb2gray(spot_img);

enhanced_spot = imageEnhancement(spot_gray);
% enhanced_spot = medfilt2(enhanced_spot);

thresh = multithresh(spt_gray,2);
valuesMax = [thresh max(spot_gray(:))];
[quant_spot, index] = imquantize(spot_gray,thresh, valuesMax);
quant_med = medfilt2(quant_spot);

% segmentedimg = structureRemoval(quant_spot, 4);
% segmentedimg = uint8(255 * segmentedimg);
% 
% new_spot = imsubtract(quant_spot, segmentedimg);
% 
% compimg = imcomplement(quant_spot);

% % Remove objects (groups of white pixels) that are less than "pixelremoval" pixels
% BWF0Rc = bwareaopen(compimg, pixelremoval);
% 
% % Inverse it again to make it look like the original
% segmentedimg = imcomplement(BWF0Rc);

% 
% bw_spot = makeBinary(spot_gray,0.64);
% bw_spot_comp = imcomplement(bw_spot);
% 
% mask = zeros(size(enhanced_spot));
% mask(25:end-25,25:end-25) = 1;
% 
% bw = activecontour(enhanced_spot,mask,1000);

% gradient = imgradient(spot_gray);
% 
% se = strel('disk',10);
% Io = imopen(enhanced_spot,se);
% figure(1)
% imshow(Io)
% title('Opening')
% 
% 
% segment_spot = segmentImage(spot_gray, 0.55, 100);
% 
figure, imshowpair(spot_gray,enhanced_spot,'montage')
figure, imshowpair(spot_gray, quant_spot, 'montage')
figure, imshowpair(quant_spot, quant_med, 'montage')