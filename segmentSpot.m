function segment_spot = segmentSpot(image)

thresh = multithresh(image,2);
valuesMax = [thresh max(image(:))];
[quant_spot, index] = imquantize(image,thresh, valuesMax);

BW = makeBinary(quant_spot,0.64);
BW = bwareaopen(BW,70);

segment_spot = BW;
end