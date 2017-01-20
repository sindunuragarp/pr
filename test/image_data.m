close all;
clear all;
prwaitbar off;

reps = 1;
fold = 10;

a = prnist(0:9, 1:1000); % all 1000 images per class
a = setprior(a,getprior(a,0));
b = im_box(a,0,1);

classifiers = {nmc([]), ldc([]), qdc([]), fisherc([]), loglc([]), knnc([], 3), parzenc([]), svc([])};

file = fopen('image_data.csv', 'w');
fprintf(file, 'size, NearestMean, Bayes-Normal-1, Bayes-Normal-2, Fisher, Logistic, 3-NN, ParzenC, SVC \n');

sizes = [50, 40, 30, 20, 10];

loading = 0;
fprintf('starting \n');
for size = sizes
    data = extract_basic_feat(b, size, size);
    error = prcrossval(data, classifiers, fold, reps);
    fprintf(file, '%ix%i, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f \n', size, size, error(1), error(2), error(3), error(4), error(5), error(6), error(7), error(8));
    loading = loading + 1;
    fprintf('Progress: %d \n', loading / length(sizes));
end
