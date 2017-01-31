function set = im2set(path)
    img = imread(path);
    digits = cropdigits(img);
    set = nistify(digits);
end