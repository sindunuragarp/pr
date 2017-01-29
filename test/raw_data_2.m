close all;
clear all;
prwaitbar off;
clc;

repetitions = 1;

a = prnist(0:9, 1:10); %10 images per class
a = setprior(a,getprior(a,0));

sizes = [30, 25, 20, 15, 10, 5];
resize_methods = {'nearest', 'bilinear', 'bicubic'};

classifiers = {nmc, ldc, qdc, fisherc, loglc, knnc, parzenc, svc, randomforestc, bpxnc, lmnc, neurc, rnnc};

fileID = fopen('raw_data_2.csv', 'w');
fprintf(fileID, 'Image size and method, nmc, ldc, qdc, fisherc, loglc, knnc, parzenc, svc, randomforestc, bpxnc, lmnc, neurc, rnnc');
%without hyper parameters
index = 1;
for i = sizes
    for method = resize_methods
        meth = cell2mat(method);
        data = preprocess(a, i, meth);
        data = prdataset(data);
        error = prcrossval(data, classifiers, 10);
        fprintf(fileID, '%i x %i %s, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f', i, i, meth, error(1), error(2), error(3), error(4), error(5), error(6), error(7), error(8), error(9), error(10), error(11), error(12), error(13));
        fprintf(fileID, '\n');
        index = index + 1
        %fprintf('error: %f for nmc classifier with method %s for image sizes %f x %f \n', error, cell2mat(method), i, i);        
    end
end

fclose(fileID);