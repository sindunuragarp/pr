a = prnist(0:9, 1:1000);
smoothing = 0:0.05:1;

sizes = [20, 15, 10];
methods = {'bilinear', 'bicubic'};

for i = sizes
    for meth = methods
        arr = zeros(length(smoothing), 1);
        index = 1;
        method = cell2mat(meth);
        data = preprocess(a, i, method);
        for x = smoothing
           b = prdataset(data);
           w = parzenc([], x);
           err = prcrossval(b, w, 10);
           arr(index) = err;
           index = index + 1;
        end
        disp(arr);
    end
end