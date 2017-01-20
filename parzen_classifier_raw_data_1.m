close all;
clear all;
prwaitbar off;
clc

a = prnist(0:9, 1:1000);
a = preprocess(a);
smoothing = 0:0.05:1;

smooth = 0;
error = 1;

for x = smoothing
   b = prdataset(a);
   w = parzenc([], x);
   err = prcrossval(b, w, 10);
   if err < error
      disp(error);
      smooth = x;
      error = err;
      disp(error);
   end
end