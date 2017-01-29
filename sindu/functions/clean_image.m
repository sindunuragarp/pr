function out = clean_image(im, dim)
    %% morphological opening
    se = strel('disk',1);
    im = imopen(im,se);

    %% slant correction
    moments = im_moments(im,'central');
    m1 = moments(1);
    m2 = moments(2);
    m3 = moments(3);
    alpha = atan(2*m3/(m1-m2));

    tform2 = affine2d([1 0 0; sin(0.5*pi-alpha) cos(0.5*pi-alpha) 0; 0 0 1]);
    im = imwarp(im,tform2);
    
    %% standardise
    im = im_box(im,0,1);
    im = imresize(im,[dim dim],'bilinear');
    im = imbinarize(im);
    
    %% return
    out = im;
end