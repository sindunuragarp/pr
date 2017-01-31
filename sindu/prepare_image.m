function dataset = prepare_image(a)
    dim = 30;
    
    %% data info
    n = size(a,1);
    labels = getlabels(a);
    
    a = im_box(a,0,1);
    a = im_resize(a,[dim+10 dim+10], 'bilinear');

    %% loop
    for i = 1:n
        im = data2im(a(i));
        im = clean_image(im,dim);

        data(i,:) = im(:);
    end

    %% return
    dataset = prdataset(data,labels);
    dataset.featsize = [dim dim];
end