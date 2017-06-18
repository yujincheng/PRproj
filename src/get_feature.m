function [ feature ] = get_feature( input_img )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
img_224 = imresize(input_img,[56,56]);
img_gray = rgb2gray( img_224);
img_gray = double(img_gray);
feature = reshape(img_gray,1,[]);

end

