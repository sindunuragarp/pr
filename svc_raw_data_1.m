close all;
clear all;
prwaitbar off;
clc;

a = prnist(0:9, 1:1000);
%a = preprocess(a);
a = im_box(a, 0, 1);
a = im_rotate(a);
smoothing = 0.2:0.05:1;

smooth = 0;
error = 1;

w = svc([]);

sizes = [30, 25, 20, 15, 10, 5];
resize_methods = {'nearest', 'bilinear', 'bicubic'};

for x = sizes
   for method = resize_methods
        meth = cell2mat(method);
        data = im_resize(a, [x x], meth);
        data = im_box(data, 1, 0);
        data = prdataset(data);
        
        error = prcrossval(data, w, 5);
        disp(error)
   end
end