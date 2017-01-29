%% ------ Benchmark

n = 100;
w = knnc([]);
e = nist_eval('extract_basic_feat', w, n);

%% ------ Local : Case 1
n = 200;
m = 1000/n;

err = zeros(m,1);
std = zeros(m,10);

for i = 1:m
    % setup classifier
    w = knnc([]);
    
    % split data
    diff = (i - 1) * n;
    data = prnist([0:9],[diff+1:diff+n]);

    % extract feature
    a = feature_extraction(data);

    % cross val
    [err(i), std(i,:)] = prcrossval(a,w,5,1);
end

mean(err)
mean(std)

%% ------ Local : Case 2
n = 10;
m = 1000/n;

err = zeros(m,1);
std = zeros(m,10);

for i = 1:m
    % setup classifier
    w = knnc([]);
    
    % split data
    diff = (i - 1) * n;
    data = prnist([0:9],[diff+1:diff+n]);

    % extract feature
    a = feature_extraction(data);

    % cross val
    [err(i), std(i,:)] = prcrossval(a,w,5,1);
end

mean(err)
mean(std)
