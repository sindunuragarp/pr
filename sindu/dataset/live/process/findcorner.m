function [row,column] = findcorner(img, lim, pos)

    h = size(img,1);
    w = size(img,2);
    min_i = 1e6;
    min_j = 1e6;
    
    for i=1:h    
        box = 0;
        
        for j=lim:w
            color = img(i,j,:);
            
            if isRed(color)
                    for k=1:20
                        color = img(i,j+k,:);
                            if isred(color)
                                box = 1;
                            else
                                box = 0;
                                break;
                            end
                    end
            
                    for k=1:20
                        color = img(i+k,j,:);
                            if isred(color)
                                box = 1;
                            else
                                box = 0;
                                break;
                            end
                    end
            end
            
            if box == 1
                break;
            end
        end
        
        if box == 1
            if pos == 't'
                if j < min_j-20 && j>lim
                    min_i = i;
                    min_j = j;
                end
            end
            
            if pos == 'b'
                if j < min_j+20 && j>lim
                    min_i = i;
                    min_j = j;
                end
            end
        end
        
    end
    
    row = min_i;
    column = min_j;
end