%% ------ Benchmark

e = nist_eval('feature_extraction', knnc);

%% ------ Test

% split data
data = prnist([0:9],[1:200]); % max 1000

% extract feature
a = feature_extraction(data);
w = knnc([],4);

% cross val
[err, std] = prcrossval(a,w,10,5);