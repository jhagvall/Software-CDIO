% CLAHE
function CLAHE_img = CLAHE(varargin)

CLAHE_img = adapthisteq(varargin{1:nargin});

end
