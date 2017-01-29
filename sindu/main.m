%% ------ Benchmark
n = 100;
w = knnc([]);
e = nist_eval('extract_basic_feat', w, n);

%% ------ Load All Data
prdata_raw = prnist([0:9],[1:1000]);

sample = gendat(prdata_raw,ones(1,10)*10);
processed = prepare_image(sample);

%% ------ Run Preprocess (takes a long time)
prdata = prepare_image(prdata_raw);

%% ------ Local
rep = 5;
n = 200;

err = zeros(rep,1);
std = zeros(rep,10);

for i = 1:rep
    % setup
    a = gendat(prdata, ones(1,10)*n);
    w = knnc([]);

    % extract feature
    a = extract_im_hog(a);

    % cross val
    [err(i), std(i,:)] = prcrossval(a,w,5,1);
end

mean(err)
mean(std)

%% ------ Test

im = data2im(prdata(3,:));
hog = get_hog(im);
