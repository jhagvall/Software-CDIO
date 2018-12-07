function density_of_vessels = DeBackers(image, gridsize, nr_crossing_vessels, width)
%- Image is the image on where the density of vessels should be calculated
%- Gridsize is the number n where the grid nxn is used to calculate the
%density of vessels
%- nr_crossing_vessels is the total number of vessels crossing the lines in
%the image
%- sixe_of_pixel is the physical size of one pixel in mm

[thelength thewidth] = size(image);
size_of_pixel = width/thewidth;
pixelsize = size_of_pixel; % How large is one pixel (in mm), will depend on camera and resolution

length_of_lines_pix = (gridsize-1)*thelength + (gridsize-1)*thewidth;
length_of_lines = length_of_lines_pix * pixelsize;

density_of_vessels = nr_crossing_vessels / length_of_lines;
end