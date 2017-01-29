function [dataset,transfunc] = extract_pixel_pca(a)

    % pca reduction
    [transfunc,~] = pcam(a, 100);
    a = transfunc(a);
    
    % reconstruct prdataset
    dataset = prdataset(a, getlabels(a));
    dataset = setprior(dataset, getprior(dataset, 0));
end