function nrVessels = autoCountVessels(image, gridsize)
% Performs automatic calculation of the number of vessels crossing grid
% lines in the binary image "image"

[thelength thewidth] = size(image); % The length and width of the image in pixels
nrVessels = 0;

%Vertical lines
for n = round(thewidth/gridsize):round(thewidth/gridsize):round(thewidth/gridsize)*(gridsize-1)
    for m = 1:thelength
        if m == 1
            if image(m,n) == 0 && image(m+1,n) == 1
            nrVessels = nrVessels+1;
            continue
            else continue
            end
        end
        
        if image(m-1,n) == 0 && image(m,n) == 1
            nrVessels = nrVessels+1;
        end
    end
end

%Horisontal lines
for n = round(thelength/gridsize):round(thelength/gridsize):round(thelength/gridsize)*(gridsize-1)
    for m = 1:thewidth
        if m == 1
            if image(m,n) == 0 && image(m+1,n) == 1
            nrVessels = nrVessels+1;
            continue
            else continue
            end
        end
        
        if image(n,m-1) == 0 && image(n,m) == 1
            nrVessels = nrVessels+1;
        end
    end
end

end