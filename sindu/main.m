%% ------ Benchmark
n = 100;
w = knnc([]);
e = nist_eval('my_rep_features', w, n);

%% ------ Load All Data
prdata_raw = prnist([0:9],[1:1000]);

sample = gendat(prdata_raw,ones(1,10)*10);
processed = prepare_image(sample);

%% ------ Run Preprocess (takes a long time if used for all data)
prdata = prepare_image(prdata_raw);

%% ------ Case 1
rep = 3;
n = 200;

clear err

a = prdata(1:10000,:);
a = extract_dis(a,'distance');

for i = 1:rep
    
    % setup
    w = {nmc, fisherc, qdc, loglc, knnc, parzenc};
    wlen = size(w,2);

    % cross val
    [res,~] = prcrossval(a,w,5,1)
    err(1:wlen,i) = res;
end

mean(err,2)

%% ------ Case 2
rep = 10;
n = 200;

clear err

for i = 1:rep
    
    a = prdata(i:100:10000,:);
    a = extract_dis(a,'distance');
    
    % setup
    w = {nmc, fisherc, qdc, loglc, knnc, parzenc};
    wlen = size(w,2);

    % cross val
    [res,~] = prcrossval(a,w,5,1)
    err(1:wlen,i) = res;
end

mean(err,2)

%% ------ Test Case 1 : Extract Feature
rep = 1;
n = 200;

a = prdata(1:10000,:);
p = extract_pixel(a,[10 10],'bilinear');
h = extract_im_hog(a,6);
d = extract_dis(a,'cosine');

%% ------ Test Case 1 : Testing Classifier
clear errp
clear errh
clear errd

% Pixel

w = {nmc, qdc, parzenc, bpxnc};
errp = prcrossval(p,w,5,1)

% HOG

w = {nmc, qdc, parzenc, bpxnc};
errh = prcrossval(h,w,5,1)

% Dissimilarity

w = {nmc, qdc, parzenc, bpxnc};
errd = prcrossval(d,w,5,1)
