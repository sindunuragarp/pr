function a = my_rep(raw_a)
    %% preprocess
    a = prepare_image(raw_a);
    a = extract_im_hog(a,6);
end