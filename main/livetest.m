%% sort data + preprocess

labels = getlabels(lvdata);
len = size(lvdata,1);

count = zeros(10,1);
clear data;

for i = 1:len
    num = labels(i);
    
    im = data2im(lvdata(i,:));
    im = imresize(im,[60 60]);
    im = clean_image(im,30);
    
    count(num+1) = count(num+1) + 1;
    data(num+1,count(num+1),:) = im(:);
end

clear newdata;
clear newlabels;

acc = 0;
for i = 1:10
    for j = 1:count(i)
        acc = acc + 1;
        
        newdata(acc,:) = data(i,j,:);
        newlabels(acc,:) = ['digit_' num2str(i-1)];
    end
end

dataset = prdataset(newdata,newlabels);
dataset.featsize = [30 30];
lvdata = dataset;

%% ------ Live Test Case 1
w = parzenc(h);
test = extract_im_hog(lvdata, 6);

% check prediction here

%% ------ Live Test Case 2
sh = h(1:100:10000,:);
m = pcam(sh,0.73);
w = nmc(sh*m);

test = extract_im_hog(lvdata, 6);
test = m(test);

% check prediction here