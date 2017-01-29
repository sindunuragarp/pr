function [dataset] = extract_pixel_basic(a)

    % pca reduction
    a = im_resize(a,[10 10], 'bilinear');
    
    % reconstruct prdataset
    dataset = prdataset(a, getlabels(a));
    dataset = setprior(dataset, getprior(dataset, 0));
end