function [ data ] = extract_basic_feat(A, x, y)
    resized = +prdataset(im_resize(A, [x y]));
    [M, ~] = size(resized);
    raw_out = zeros([M 14]);
    for i = 1:M
        image = reshape(resized(i, :), [x y]);
%       raw_out(i, 1) = mean(find(image(1,:)));
%       raw_out(i, 2) = mean(find(image(x,:)));
%       raw_out(i, 3) = mean(find(image(:,1)));
%       raw_out(i, 4) = mean(find(image(:,y)));
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
    data = prdataset(raw_out, getlab(A));
end
