function [ data ] = preprocess(a, size, method)     
    if nargin < 3
        method = 'nearest';
    end   
    if nargin < 2
        size = 20;
    end
    a = im_box(a, 0, 1);
    a = im_rotate(a);
    a = im_resize(a, [size size], method);
    data = im_box(a, 1, 0);
end

