clc;
clear all;
addpath(genpath('../libsvm-3.22/matlab'))
addpath(genpath('../vlfeat'))
my_dir = '../data/';

train_set = cell(1,10);
train_group = zeros(1,360);
cellSize = 8;

for in_class = 1:10
    str_folder = num2str(in_class);
    tmp_train_set = [];
    for i = 1:36
        train_group(i+(in_class - 1)*36) = in_class;
        str_file = num2str(i);
        if(length(str_file) < 2)
            str_pre = ['0',str_file];
        else 
            str_pre = str_file;
        end
        name = [str_pre,'_flower',str_folder,'.jpg'];
        tmp_image = imread([my_dir,str_folder,'/train/',name]);
        tmp_image = rgb2gray(tmp_image);
        tmp_image = single(tmp_image);
        tmp_feature = vl_hog(tmp_image,cellSize,'verbose');
        tmp_feature = reshape(tmp_feature,1,[]);
        tmp_train_set = [tmp_train_set,tmp_feature'];
    end
    train_set{in_class} = tmp_train_set;
end
train_group = train_group';

train_matrix = [];
for i = 1:10 
    %train_matrix = [train_matrix,train_set{i}];
    train_matrix = [train_matrix;transpose(train_set{i})];
end
 train_matrix = double(train_matrix);
 
SVM_STR = svmtrain(train_group,train_matrix);

test_set = cell(1,10);
test_group = zeros(1,240);
for in_class = 1:10
    str_folder = num2str(in_class);
    tmp_test_set = [];
    for i = 37:60
        test_group(i-36+(in_class - 1)*24) = in_class;
        str_file = num2str(i);
        if(length(str_file) < 2)
            str_pre = ['0',str_file];
        else 
            str_pre = str_file;
        end
        name = [str_pre,'_flower',str_folder,'.jpg'];
       tmp_image = imread([my_dir,str_folder,'/test/',name]);
        tmp_image = rgb2gray(tmp_image);
        tmp_image = single(tmp_image);
        tmp_feature = vl_hog(tmp_image,cellSize,'verbose');
        tmp_feature = reshape(tmp_feature,1,[]);
        tmp_test_set = [tmp_test_set,tmp_feature'];
    end
    test_set{in_class} = tmp_test_set;
end
test_group = test_group';
test_matrix = [];
for i = 1:10 
    %train_matrix = [train_matrix,train_set{i}];
    test_matrix = [test_matrix;transpose(test_set{i})];
end
test_matrix = double(test_matrix);
[predict_label, accuracy, dec_values] = svmpredict(test_group, test_matrix, SVM_STR);