function [ data ] = preprocess(a, size)
    if nargin < 2
        size = 20;
    end
    a = im_box(a, 0, 1);
    a = im_rotate(a);
    a = im_resize(a, [size size], 'bicubic');
    data = im_box(a, 1, 0);
end

