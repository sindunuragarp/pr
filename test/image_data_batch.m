close all;
clear all;
prwaitbar on;

reps = 1;
fold = 5;

batches = 10;

classifiers = {nmc, ldc, qdc, fisherc, loglc, knnc([], 3), parzenc, svc};

file = fopen('image_data_batch.csv', 'w');
fprintf(file, 'Batch range, NearestMean, Bayes-Normal-1, Bayes-Normal-2, Fisher, Logistic, 3-NN, ParzenC, SVC \n');

fprintf('starting \n');
for i = 1:batches
    batch_end = i * 10;
    batch_start = batch_end - 9;
    a = prnist(0:9, batch_start:batch_end); % 10 batch objects
    b = preprocess(a);
    data = extract_im_feat(b);
    error = prcrossval(data, classifiers, fold, reps);
    fprintf(file, '%i - %i, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f \n', batch_start, batch_end, error(1), error(2), error(3), error(4), error(5), error(6), error(7), error(8));
    fprintf('Progress: %d/%d \n', i, batches);
end
fclose(file);
