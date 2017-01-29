close all;
clear all;
prwaitbar off;
clc;

repetitions = 1;

a = prnist(0:9, 1:40:1000); %200 images per class
a = setprior(a,getprior(a,0));
c = Preprocess(a);

sizes = [30, 25, 20, 15, 10, 5];
resize_methods = {'nearest', 'bilinear', 'bicubic'};

classifiers = {nmc([]), ldc([]), qdc([]), fisherc([]), loglc([]), knnc([], 3), parzenc([]), svc([])};

fileID = fopen('raw_data.csv', 'w');
fprintf(fileID, 'Image size and method, NearestMean, Bayes-Normal-1, Bayes-Normal-2, Fisher, Logistic, 3-NN, ParzenC, SVC\n');
%without hyper parameters
for i = sizes
    for method = resize_methods
        data = c;
        data = data * im_resize([], [i i]);
        error = prcrossval(data, classifiers, 10);
        fprintf(fileID, '%i x %i %s, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f', i, i, cell2mat(method), error(1), error(2), error(3), error(4), error(5), error(6), error(7), error(8));
        fprintf(fileID, '\n');
        %fprintf('error: %f for nmc classifier with method %s for image sizes %f x %f \n', error, cell2mat(method), i, i);        
    end
end

fclose(fileID);