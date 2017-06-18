clc;clear all;
mydir='../neg/';
temp1=dir([mydir,'*.jpg']);
num_temp1=length(temp1);

neg_index = 1;

for i1=1:num_temp1
    filename=[mydir,temp1(i1).name];
    
    filename
    img = imread(filename);
    img = imresize(img,[288,288]);
    if (ndims(img) ~= 3)
        continue;
    end
    imwrite(img,['../data/neg_self/',num2str(neg_index),'.jpg']);
    neg_index = neg_index+ 1;
end

