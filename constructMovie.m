function movie = constructMovie(frames)

F(length(frames)) = struct('cdata',[],'colormap',[]);
for i = 1:length(frames)
    temp = frames(i).cdata;
    f = figure('visible', 'off');
    imshow(temp);
    F(i) = getframe(gca);
end

movie = F;
end