%% ------ Load All Data
prdata_raw = prnist([0:9],[1:1000]);

%% ------ Run Preprocess (takes a long time if used for all data)
prdata = prepare_image(prdata_raw);

%% ------ Case 1
rep = 3;
n = 200;

clear err

a = prdata(1:10000,:);
a = extract_pixel(a,64,'pca');

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

w = {nmc, qdc, parzenc, bpxnc, vpc, dtc, adaboostc([],weakc)};
errp = prcrossval(p,w,5,1)

% HOG

w = {nmc, qdc, parzenc, bpxnc, vpc, dtc, adaboostc([],weakc)};
errh = prcrossval(h,w,5,1)

% Dissimilarity

w = {nmc, qdc, parzenc, bpxnc, vpc, dtc, adaboostc([],weakc)};
errd = prcrossval(d,w,5,1)

%% ------ Test Case 1 : Parameter Tuning

smoothing = 0:0.05:1;
len = size(smoothing,2);
rep = 10;

clear err

for i = 1:rep    
    for j = 1:len
        w = parzenc([],smoothing(j));
        [res,~] = prcrossval(m,w,5,1);
        err(j, i) = res
    end
end

mean(err,2)

%% ------ Test Case 1 : Feature Reduction

info = 0.5:0.05:0.9;
rep = 5;

clear err

for i = 1:rep    
    for j = 1:size(info,2)
        w = parzenc;
        m = pcam(h,info(j));
        mh = m(h);
        [res,~] = prcrossval(mh,w,5,1);
        err(j, i) = res
    end
end

mean(err,2)

%% ------ Test Case 2 : Testing Classifier
clear errp
clear errh
clear errd

rep = 10;
n = 200;

for i = 1:rep
    
    % extract data
    a = prdata(i:100:10000,:);
    p = extract_pixel(a,[6 6],'bilinear');
    h = extract_im_hog(a,6);
    d = extract_dis(a,'cosine');
    
    % pixel
    w = {nmc, qdc, parzenc, bpxnc, vpc, dtc, adaboostc([],weakc)};
    wlen = size(w,2);
    [res,~] = prcrossval(p,w,5,1);
    errp(1:wlen,i) = res
    
    % hog
    w = {nmc, qdc, parzenc, bpxnc, vpc, dtc, adaboostc([],weakc)};
    wlen = size(w,2);
    [res,~] = prcrossval(h,w,5,1);
    errh(1:wlen,i) = res
    
    % dissimilarity
    w = {nmc, qdc, parzenc, bpxnc, vpc, dtc, adaboostc([],weakc)};
    wlen = size(w,2);
    [res,~] = prcrossval(d,w,5,1);
    errd(1:wlen,i) = res
end

mean(errp,2)
mean(errh,2)
mean(errd,2)

%% ------ Test Case 2 : Compare parzenc and nmc
clear err

rep = 30;
n = 200;

for i = 1:rep
    
    sh = h(i:100:10000,:);
    w = {nmc, parzenc([],0.65)};
    wlen = size(w,2);
    
    [res,~] = prcrossval(sh,w,5,1);
    err(1:wlen,i) = res
end

mean(err,2)

%% ------ Test Case 2 : Parameter Tuning

smoothing = 0:0.05:1;
len = size(smoothing,2);
rep = 10;

clear err

for i = 1:rep    
    for j = 1:len
        sh = h(i:100:10000,:);
        w = parzenc([],smoothing(j));
        [res,~] = prcrossval(sh,w,5,1);
        err(j, i) = res
    end
end

mean(err,2)

%% ------ Test Case 2 : Feature Reduction

info = 0.5:0.01:0.99;
rep = 10;

clear err

for i = 1:rep    
    for j = 1:size(info,2)
        w = parzenc([],0.65);
        
        sh = h(i:100:10000,:);
        m = pcam(sh,info(j));
        mh = m(sh);
        
        [res,~] = prcrossval(mh,w,5,1);
        err(j, i) = res
    end
end

mean(err,2)

%% ------ Benchmark Case 1
w = parzenc(h);
e = nist_eval('my_rep', w, 100)

%% ------ Benchmark Case 2
sh = h(1:100:10000,:);
m = pcam(sh,0.73);
w = nmc(sh*m);
e = nist_eval('my_rep', m*w, 100)