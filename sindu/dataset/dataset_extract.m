function [images, labels] = dataset_extract(im_data, width, height)
   labels = getlabels(im_data);
   pixels = +im_data;
   images = reshape(pixels,[],width,height);
end