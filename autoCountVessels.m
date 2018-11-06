function nrVessels = autoCountVessels(image, gridsize)

[thelength thewidth] = size(image);
nrVessels=0;

%Vertical lines
for n = round(thewidth/gridsize):round(thewidth/gridsize):round(thewidth/gridsize)*(gridsize-1)
    for m = 1:thelength
        if m == 1
            continue
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
            continue
        end  
        
        if image(n,m-1) == 0 && image(n,m) == 1
            nrVessels = nrVessels+1;
        end
    end
end

end