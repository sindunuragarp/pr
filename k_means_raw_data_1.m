close all;
clear all;
prwaitbar off;
clc

a = prnist(0:9, 1:1000);
k = 1:9;

sizes = [20, 15, 10];
methods = {'bilinear', 'bicubic'};

for i = sizes
    for meth = methods
        arr = zeros(length(k), 1);
        index = 1;
        method = cell2mat(meth);
        data = preprocess(a, i, method);
        for x = k
           b = prdataset(data);
           w = knnc([], x);
           err = prcrossval(b, w, 10);
           arr(index) = err;
           index = index + 1;
        end
        disp(arr);
    end
end