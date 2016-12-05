function [ dataset ] = feature_extraction( nist_data, im_size )
    % remove invalid observations
    a = nist_data*im_box([],0);
    % add a bounding box to the images to make it square.
    a = a*im_box([],0,1);
    % resample the images.
    method = 'bicubic';% nearest, bilinear and bicubic.
    a = a*im_resize([],[im_size, im_size], method);
    % dataset: suitable for handling
    dataset = prdataset(a, getlabels(a));
    dataset.prior = ones(10,1)/10; % uniform prior,
end

