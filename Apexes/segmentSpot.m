function segment_spot = segmentSpot(image)
%Segment the input image by multi grayscale thresholds and image quantization and
%returns the segmented image.

thresh = multithresh(image,2);
valuesMax = [thresh max(image(:))];
[quant_spot, index] = imquantize(image,thresh, valuesMax);

BW = makeBinary(quant_spot,0.64);
BW = bwareaopen(BW,70);

segment_spot = BW;
end