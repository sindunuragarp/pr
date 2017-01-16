%% ------ Benchmark

e = nist_eval('feature_extraction', knnc);

%% ------ Test

% split data
data = prnist([0:9],[1:200]); % max 1000

% extract feature
a = feature_extraction(data);
w = knnc(a,4);

% cross val
[err, std] = prcrossval(a,w,10,5);

%% ------- Prev (Sebastian)

clear all;

% iterator values, not implemented
nb_training_data = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8];
feature_size = [5 6 7 8 9 10 11 12 13];
classifiers = {ldc, qdc, fisherc,nmc, knnc, parzenc, svc, loglc};

% data loading and cleaning
load_interval = 10; 
nist_data = prnist([0:9],[1:load_interval:1000]);

% TODO loop these variables
im_size = 10;
classifier = knnc;
frac_train = .8;

% feature_extraction is parameterized for cross-validation. Deliverable
% should not be parameterized.
dataset = feature_extraction(nist_data, im_size);

% split testing and training set %TODO replace by leave-k-out
[train_data, test_data, ~, ~] = gendat(dataset, frac_train, 'default');

% classify.
w = train(train_data, classifier);

% evaluate
testc(test_data*w, 'crisp');