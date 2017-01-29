function histograms = get_hog(im)
    %% vars
    
    % number of HOG windows per bound box
    nwin_x = 4;
    nwin_y = 4;
    
    % number of histogram bins
    bins = 9;
    
    %% setup
    
    im=double(im);
    [length,width] = size(im);
    
    histograms = zeros(nwin_x * nwin_y * bins, 1);
    m = sqrt(length/2);
    
    if width==1
        %verify the size of image, e.g. 25x50
        im = im_recover(im, m, 2*m);
        length = 2*m;
        width = m;
    end
    
    step_x = floor(width / (nwin_x + 1));
    step_y = floor(length / (nwin_y + 1));
    
    hx = [-1,0,1];
    hy = -hx';
    
    grad_xr = imfilter(double(im), hx);
    grad_yu = imfilter(double(im), hy);
    
    angles = atan2(grad_yu, grad_xr);
    magnit = ((grad_yu.^2)+(grad_xr.^2)).^.5;
    
    %% build histogram
    count = 0;
    
    for n = 0 : nwin_y-1
        for m = 0 : nwin_x-1
            count = count+1;
            
            angles2 = angles(n*step_y+1 : (n+2)*step_y , m*step_x+1 : (m+2)*step_x);
            magnit2 = magnit(n*step_y+1 : (n+2)*step_y , m*step_x+1 : (m+2)*step_x);
            
            v_angles = angles2(:);
            v_magnit = magnit2(:);
            
            k = max(size(v_angles));
            
            % assembling the histogram with 9 bins (range of 20 degrees per bin)
            bin = 0;
            h = zeros(bins,1);
            for ang_lim = -pi+2*pi/bins : 2*pi/bins : pi
                bin = bin+1;
                for k = 1:k
                    if v_angles(k) < ang_lim
                        v_angles(k) = 100;
                        h(bin) = h(bin) + v_magnit(k);
                    end
                end
            end

            h = h/(norm(h)+0.01);
            histograms((count-1)*bins+1 : count*bins,1) = h;
        end
    end
end