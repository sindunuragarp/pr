function [dataset] = dataset_create(images,labels,width,height)
   flat_images = images(:,:);
   dataset = prdataset(flat_images,labels);
   dataset.featsize = [widht height];
end