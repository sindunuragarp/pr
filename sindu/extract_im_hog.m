function dataset = extract_im_hog(a)
    %% data info
    n = size(a,1);
    labels = getlabels(a);
    
    %% loop
    for i = 1:n
        im = data2im(a(i,:));
        hog = get_hog(im);
        feat(i,:) = hog(:);
    end

    %% return
    dataset = prdataset(feat,labels);
    dataset = setprior(dataset, getprior(dataset, 0));
end