function [dataset,transfunc] = extract_dis_euclidean(a)
    
    % get dissimilarity from sampled data
    rep = gendat(a,ones(1,10)*5);
    transfunc = proxm(rep,'distance');
    a = transfunc(a);
    
    % reconstruct prdataset
    dataset = prdataset(a, getlabels(a));
    dataset = setprior(dataset, getprior(dataset, 0));
end