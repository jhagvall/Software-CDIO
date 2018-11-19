spot_img = imread('dots2.png');

spot_img = rgb2gray(spot_img);

A = fft2(double(spot_img)); % compute FFT of the grey image
A1=fftshift(A); % frequency scaling


% Gaussian Filter Response Calculation

[M N]=size(A); % image size
R=10; % filter size parameter 
X=0:N-1;
Y=0:M-1;
[X Y]=meshgrid(X,Y);
Cx=0.5*N;
Cy=0.5*M;
Lo=exp(-((X-Cx).^2+(Y-Cy).^2)./(2*R).^2);
Hi=1-Lo; % High pass filter=1-low pass filter

% Filtered image=ifft(filter response*fft(original image))

% K=A1.*Hi;
% K1=ifftshift(K);
% B2=ifft2(K1);

J=A1.*Lo;
J1=ifftshift(J);
B1=ifft2(J1);

new_img = double(spot_img)./double(B1);
new_img = real(new_img);

thresh = multithresh(new_img,2);
valuesMax = [thresh max(new_img(:))];
[quant_spot, index] = imquantize(new_img,thresh, valuesMax);

BW = makeBinary(quant_spot,0.64);

figure(3)
imshow(BW)

figure(2)
imshow(spot_img)

figure(5)
imshow(new_img)
figure, imshowpair(spot_img, BW, 'montage')