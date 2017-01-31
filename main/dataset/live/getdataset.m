function gsnist = getdataset()
	
    datapath = dir('dataset');
    gsnist = prdataset();
                        
    for i=1:length(datapath)
       
        file = datapath(i); 
        if file.isdir == 1
            continue;
        end
        
        data = strsplit(file.name,'_');
        id = data{1};
        lab = data{2};
        
        label = [];
        for j=1:4
            label = [label; ['digit_' lab(j)] ];
        end
        
        img = im2set(fullfile('Dataset',file.name));
        img = setlabels(img,label);
        gsnist = [gsnist; img];
    end
end
