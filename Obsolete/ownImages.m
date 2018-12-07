%% Read frames
[video,frames,vidWidth, vidHeight,framerate] = splitFrames('SDF_test1.mov');

frame_100 = video(79).cdata;

figure,imshow(frame_100)

removed_img = removeChannel(frame_100);
gray_img = rgb2gray(removed_img);

%% Low pass 
ideal = IdealLowPass(gray_img,0.008);

A=fft2(double(image)); 
A1=fftshift(A); 

[M N]=size(A); 
R=3; % filter size parameter 
X=0:N-1;
Y=0:M-1;
[X Y]=meshgrid(X,Y);
Cx=0.5*N;
Cy=0.5*M;
Lo=exp(-((X-Cx).^2+(Y-Cy).^2)./(2*R).^2);

J=A1.*Lo;
J1=ifftshift(J);
B1=ifft2(J1);

norm_img1 = double(gray_img)./double(B1);
norm_img1 = real(norm_img1);

norm_img2 = double(gray_img)./double(ideal);
norm_img2 = real(norm_img2);

figure, imshowpair(norm_img1, norm_img2, 'montage')
title('Nbr 1 & 2')

%% Enhancement & Segmentation

%Norm image 1
enhanced_img1 = imageEnhancement(norm_img1);
thresh1 = multithresh(enhanced_img1,4);
valuesMax1 = [thresh1 max(enhanced_img1(:))];
[quant_spot1, index] = imquantize(enhanced_img1,thresh1, valuesMax1);
segmented_img1 = segmentImage(quant_spot1,0.64,10000);

%Norm image 2
enhanced_img2 = imageEnhancement(norm_img2);
thresh2 = multithresh(enhanced_img2,4);
valuesMax2 = [thresh2 max(enhanced_img2(:))];
[quant_spot2, index] = imquantize(enhanced_img2,thresh2, valuesMax2);
segmented_img2 = segmentImage(quant_spot2,0.64,10000);

figure, imshowpair(enhanced_img1,enhanced_img2 ,'montage')
title('Nbr 1 & 2 enhanced')
figure, imshowpair(segmented_img1,segmented_img2 ,'montage')
title('Nbr 1 & 2 segmented')