function output = makeBinary(img, sense)

output = imbinarize(img, 'adaptive', 'ForegroundPolarity', 'bright', 'Sensitivity', sense);