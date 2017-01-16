function [dataset] = dataset_create(images,labels)
   flat_images = images(:,:);
   dataset = prdataset(images,labels);
end