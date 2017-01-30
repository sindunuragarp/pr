function dataset = extract_im_hog(a, cells)
    %% data info
    n = size(a,1);
    labels = getlabels(a);
    
    %% loop
    for i = 1:n
        im = data2im(a(i,:));
        hog = get_hog(im, cells);
        feat(i,:) = hog(:);
    end

    %% return
    dataset = prdataset(feat,labels);
    dataset = setprior(dataset, getprior(dataset, 0));
end