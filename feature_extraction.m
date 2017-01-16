function [dataset] = feature_extraction(im_data)

    % add a bounding box to the images to make it square
    a = im_data*im_box([],0,1);
    
    % resample the images (nearest / bilinear / bicubic)
    im_size = 10;
    method = 'bicubic';
    a = a*im_resize([],[im_size, im_size], method);
    
    % reconstruct prdataset
    dataset = prdataset(a, getlabels(a));
    dataset.prior = ones(10,1)/10; % uniform prior
end