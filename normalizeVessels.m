function normalizedimg = normalizeVessels(image)
cim=double(image);

[r,c]=size(image);
cim=cim+1;

% natural log
lim=log(cim);
fim=fft2(lim);

lowg=0.9; %(lower gamma threshold, must be lowg < 1)
highg=1.1; %(higher gamma threshold, must be highg > 1)

him=homomorph(fim,lowg,highg);
ifim=ifft2(him);
eim=exp(ifim);
eim = uint8(real(eim));
normalizedimg = eim;
end