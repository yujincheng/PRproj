clc;
clear all;
my_dir = '../data/';

train_set = cell(1,10);
train_group = zeros(1,360);

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
        tmp_iamge = imread([my_dir,str_folder,'/train/',name]);
        tmp_feature = get_feature(tmp_iamge);
        tmp_train_set = [tmp_train_set,tmp_feature'];
    end
    train_set{in_class} = tmp_train_set;
end

train_matrix = [];
for i = 1:10 
    %train_matrix = [train_matrix,train_set{i}];
    train_matrix = [train_matrix;transpose(train_set{i})];
end
    
k = 50;

[coeff,score,latent] = pca(train_matrix);
train_matrix_low = train_matrix*coeff(:,1:k);

test_set = cell(1,10);
for in_class = 1:10
    str_folder = num2str(in_class);
    tmp_test_set = [];
    for i = 37:60
        str_file = num2str(i);
        if(length(str_file) < 2)
            str_pre = ['0',str_file];
        else 
            str_pre = str_file;
        end
        name = [str_pre,'_flower',str_folder,'.jpg'];
        tmp_iamge = imread([my_dir,str_folder,'/test/',name]);
        tmp_feature = get_feature(tmp_iamge);
        tmp_test_set = [tmp_test_set,tmp_feature'];
    end
    test_set{in_class} = tmp_test_set;
end

test_matrix = [];
for i = 1:10 
    %train_matrix = [train_matrix,train_set{i}];
    test_matrix = [test_matrix;transpose(test_set{i})];
end
test_matrix_low = test_matrix*coeff(:,1:k);

test_group = zeros(1,240);
valid_group = zeros(1,240);
for i = 1:240
    distance = [];
    for j = 1:360
        distance = [distance,norm(test_matrix_low(i,:) - train_matrix_low(j,:))];
    end
    m = knn_class(distance,train_group,1);
    test_group(i) = m;
    valid_group(i) = floor((i-1)/24) + 1;
end

hitrate  = sum(valid_group==test_group)/240


