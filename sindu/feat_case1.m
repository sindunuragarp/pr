function a = feat_case1(raw_a)
    %% preprocess
    a = prepare_image(raw_a);
    a = extract_im_hog(a,6);
end