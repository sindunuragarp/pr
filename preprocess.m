function [ data ] = preprocess( a )
    a = im_box(a, 0, 1);
    a = im_rotate(a);
    a = im_resize(a, [20 20]);
    data = im_box(a, 1, 0);
end

