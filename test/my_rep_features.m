function [ a ] = my_rep_features(m)
    a = prdataset(extract_im_feat(preprocess(m)));
end
