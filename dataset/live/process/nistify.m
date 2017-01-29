function set = nistify(dig)

    set = prdataset();
    set.name = 'LIVE';
    
    for d=1:length(dig)
        
        img = dig{d};
        
        % eliminate red 
        for i=1:size(img,1)
            for j=1:size(img,2)
                color = img(i,j,:);
                
                if isred(color)
                    img(i,j,:) = [255 255 255];
                end
            end
        end
        
        img = rgb2gray(img);
        img = im2bw(img,0.5);
        img = imcomplement(img);
        
        img = imresize(img, [68 68]);
        set = [set; double(img(:)')];
    end
    
    set.featsize = [68 68];
end