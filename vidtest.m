% Testing the videoread function to see what we get when importing
% Det här avsnittet tar en .mov-fil och "segmenterar" den till massa olika 
% frames där varje frame består av en matris i matlab
% Filen jag har använt är den första som finns i test dataset på driven
% men ni kan ta vilken .mov-fil eller .mp4- ni vill. Ni som har Mac kommer,
% om ni använder en .mov-fil, troligtvis behöva spela upp den först genom
% att dubbelklicka på filnamnet så filen konverteras lite. Sen kan ni
% importera filen som nedan


vid = VideoReader('sampleimg (Converted).mov');

vidWidth = vid.Width;
vidHeight = vid.Height;

mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

k = 1;
while hasFrame(vid)
    mov(k).cdata = readFrame(vid);
    k = k+1;
end

hf = figure;
set(hf,'position',[150 150 vidWidth vidHeight]);

movie(hf,mov,1,vid.FrameRate)
%% Still images - grayscale testing
% Här tar jag först fram frame 100 ur filen via mov(100).cdata och visar
% den. Därefter gör jag om den till grayscale och visar den. I den sista
% bilden har jag smetat ut gråskalan till hela spektrumet och sedan visar 
% jag den

n=2;
figure(n)
n=n+1;
stillimg = mov(100).cdata;
image(stillimg)

figure(n)
n=n+1;
grayimg = rgb2gray(stillimg);
imshow(grayimg)

figure(n)
n=n+1;
modgrayimg = histeq(grayimg);
imshow(modgrayimg)

%% Averaging of sequential images
% Här lekte jag bara runt med att köra average av några på varandra följade
% frames. Sen displayar jag både frame 100 och ett average av frame 100 till
% 104

clear avimg
for i = 100:104
    if exist('avimg')
        temp = mov(i).cdata;
        avimg = imadd(avimg/2, temp/2);
    else
        avimg = mov(i).cdata;
    end
end

figure(n)
n=n+1;
image(avimg)

figure(n)
n=n+1;
image(stillimg)

%% Make it binary and segment it - smeared out image
% I den här sektionen har jag använt den gråskalade versionen av frame 100
% som jag har smetat ut. Först låter jag graythresh räkna fram vad den tror
% är optimalt threshold. Därefter anväder jag det thresholdet och gör om
% bilden till binär och visar binära och den icke-binära bilden bredvid
% varandra

% modgrayim is the image where where it has been smeared out over entire
% spectrum

tLevelmod = graythresh(modgrayimg)
BWmod = imbinarize(modgrayimg, tLevelmod);
figure(n)
n=n+1;
imshowpair(modgrayimg, BWmod, 'montage')

%% Original gray scale image
% Samma som sektionen ovan men jag använder den gråskalebilden som jag inte
% har smetat ut

tLevelorg = graythresh(grayimg)
BWorg = imbinarize(grayimg, 0.5);
figure(n)
n=n+1;
imshowpair(grayimg, BWorg, 'montage')

%% Test of red extraction from image
% Här tar jag fram frame 100 (i färg) och utifrån den delar jag
% upp bilden i rött, grönt och blått för att sedan merga ihop dem igen.
% Alla bilder visar i ordning. Gjordes lite för att testa att senare leka
% runt med thresholds men även för att jag inte vet om vi kommer få en
% RGB-film eller en svartvit från kameran.

img = mov(100).cdata;
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel
a = zeros(size(img, 1), size(img, 2));
just_red = cat(3, red, a, a);
just_green = cat(3, a, green, a);
just_blue = cat(3, a, a, blue);
back_to_original_img = cat(3, red, green, blue);

figure(n)
n=n+1;
imshow(img)
title('Original image')

figure(n)
n=n+1;
imshow(just_red)
title('Red channel')

figure(n)
n=n+1;
imshow(just_green)
title('Green channel')

figure(n)
n=n+1;
imshow(just_blue)
title('Blue channel')

figure(n)
n=n+1;
imshow(back_to_original_img)
title('Back to original image')

greengray = rgb2gray(just_green);
imshow(greengray)




