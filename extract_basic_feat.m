function [ data ] = extract_basic_feat(raw_in, x, y)
    resized = +prdataset(im_resize(raw_in, [x y]));
    [M, ~] = size(resized);
    raw_out = zeros([M 10]);
    for i = 1:M
        image = reshape(resized(i, :), [x y]);
%       raw_out(i, 1) = mean(find(image(1,:)));
%       raw_out(i, 2) = mean(find(image(x,:)));
%       raw_out(i, 3) = mean(find(image(:,1)));
%       raw_out(i, 4) = mean(find(image(:,y)));
        props = regionprops(image, 'Area', 'Centroid', 'Extrema');
        raw_out(i, 1) = props.Area;
        raw_out(i, 2) = props.Centroid;
        % TODO: Access props.Extrema values
    end
    data = prdataset(raw_out, getlab(raw_in));
end
