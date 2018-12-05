function normalizedimg = normalizeApexes(image)

A=fft2(double(image)); 
A1=fftshift(A); 

[M N]=size(A); 
R=10; % filter size parameter 
X=0:N-1;
Y=0:M-1;
[X Y]=meshgrid(X,Y);
Cx=0.5*N;
Cy=0.5*M;
Lo=exp(-((X-Cx).^2+(Y-Cy).^2)./(2*R).^2);

J=A1.*Lo;
J1=ifftshift(J);
B1=ifft2(J1);

temp_img = double(image)./double(B1);
normalizedimg = real(temp_img);
end