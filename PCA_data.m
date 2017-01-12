close all;
clear all;
prwaitbar off;

repetitions = 1;

a = prnist(0:9, 1:200); %200 images per class
a = setprior(a,getprior(a,0));
preproc = im_box([],0,1)*im_rotate*im_box([],1,0);
b = a * preproc;

features = [30, 25, 20, 15, 10, 5];
classifiers = {nmc([]), ldc([]), qdc([]), fisherc([]), loglc([]), knnc([], 3), parzenc([]), svc([])};

fileID = fopen('PCA_data.csv', 'w');
fprintf(fileID, 'size with resize method and mount of features, NearestMean, Bayes-Normal-1, Bayes-Normal-2, Fisher, Logistic, 3-NN, ParzenC, SVC\n');

sizes = [30, 25, 20, 15, 10];
resize_methods = {'nearest', 'bilinear', 'bicubic'};

loading = 0;
fprintf('starting \n');
for size = sizes
    for method = resize_methods
        for i = features
            c = b * im_resize([], [size, size]);
            c = prdataset(c);
            data = c * pcam(c, i);
            error = prcrossval(data, classifiers, 10);
            fprintf(fileID, '%i x %i %s, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f',size, size, strcat(int2str(i),' ', cell2mat(method), ' features'), error(1), error(2), error(3), error(4), error(5), error(6), error(7), error(8));
            fprintf(fileID, '\n');
            loading = loading + 1;
            fprintf('progress: %d \n', loading / (length(sizes) + length(resize_methods) + length(features)))
        end
    end
end
fclose(fileID);