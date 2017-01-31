function [dataset] = extract_pixel(a, dim, method)

    if strcmp(method,'pca')
        % pca reduction
        [transfunc,~] = pcam(a, dim);
        a = transfunc(a);
    else
        % pca reduction
        a = im_resize(a, dim, method);
    end
    
    % reconstruct prdataset
    dataset = prdataset(a, getlabels(a));
    dataset = setprior(dataset, getprior(dataset, 0));
end