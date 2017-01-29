function [dataset] = extract_im_feat(a)

    % data info
    resized = +prdataset(im_resize(a, [50 50]));
    [n, ~] = size(resized);
    raw_out = zeros([n 14]);

    % extract basic features
    for i = 1:n
        image = reshape(resized(i, :), [50 50]);
        props = regionprops(image, 'Area', 'Perimeter', 'Centroid', 'Orientation', 'EulerNumber', 'Extrema');
        
        raw_out(i, 1) = props.Area;
        raw_out(i, 2) = props.Perimeter;
        raw_out(i, 3) = props.Centroid(1);
        raw_out(i, 4) = props.Centroid(2);
        raw_out(i, 5) = props.Orientation;
        raw_out(i, 6) = props.EulerNumber;
        raw_out(i, 7) = props.Extrema(1, 1); % x-coor top-left
        raw_out(i, 8) = props.Extrema(2, 1); % x-coor top-right
        raw_out(i, 9) = props.Extrema(3, 2); % y-coor right-top
        raw_out(i,10) = props.Extrema(4, 2); % y-coor right-bottom
        raw_out(i,11) = props.Extrema(5, 1); % x-coor bottom-right
        raw_out(i,12) = props.Extrema(6, 1); % x-coor bottom-left
        raw_out(i,13) = props.Extrema(7, 2); % y-coor left-bottom
        raw_out(i,14) = props.Extrema(8, 2); % y-coor left-top
    end

    % reconstruct prdataset
    dataset = prdataset(raw_out, getlabels(a));
    dataset = setprior(dataset, getprior(dataset, 0));
end
