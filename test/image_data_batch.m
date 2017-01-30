close all;
clear all;
prwaitbar on;

reps = 1;
fold = 5;

batches = 10;

classifiers = {nmc, ldc, qdc, fisherc, loglc, knnc([], 3), parzenc, svc};

file = fopen('image_data_batch.csv', 'w');
fprintf(file, 'Batch range, Size, NearestMean, Bayes-Normal-1, Bayes-Normal-2, Fisher, Logistic, 3-NN, ParzenC, SVC \n');

sizes = [50, 40, 30, 20, 10];

fprintf('starting \n');
for i = 1:batches
    batch_end = i * 10;
    batch_start = batch_end - 9;
    a = prnist(0:9, batch_start:batch_end); % 10 batch objects
    a = setprior(a,getprior(a,0));
    b = im_box(a,0,1);
    loading = 0;
    for size = sizes
        data = extract_im_feat(b, size);
        error = prcrossval(data, classifiers, fold, reps);
        fprintf(file, '%i-%i, %ix%i, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f \n', batch_start, batch_end, size, size, error(1), error(2), error(3), error(4), error(5), error(6), error(7), error(8));
        loading = loading + 1;
        fprintf('Progress: %.2f/%i \n', i - 1 + loading / length(sizes), batches);
    end
end
fclose(file);
