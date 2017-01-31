function digits = cropdigits(img)
    lim = 1;
    for i=1:4
        [i1,j1] = findcorner(img,lim,'t');
        [i2,j2] = findcorner(img,j1+20,'b');
        digits{i} = img(i1:i2,j1:j2,:);
        lim = j1+20;
    end
end
        