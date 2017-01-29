close all;
clear all;
prwaitbar off;
clc;

a = prnist(0:9, 1:1000);
a = setprior(a,getprior(a,0));

sizes = [30];
resize_methods = {'nearest', 'bilinear', 'bicubic'};

lmnc_err = zeros(length(sizes)*length(resize_methods), 1);
rbnc_err = zeros(length(sizes)*length(resize_methods), 1);
neurc_err = zeros(length(sizes)*length(resize_methods), 1);
rnnc_err = zeros(length(sizes)*length(resize_methods), 1);

index = 1;

for x = sizes
    for method = resize_methods
        meth = cell2mat(method);
        data = preprocess(a, x, meth);
        data = prdataset(data);
        lmnc_err(index) = prcrossval(data, lmnc, 5);
        %error = prcrossval(data, rbnc, 5);
        %disp(error);
        neurc_err(index) = prcrossval(data, neurc, 5);
        rnnc_err(index) = prcrossval(data, rnnc, 5);
        index = index + 1
    end
end