clc;
clear all;

my_dir = '../data/';
fidtrain = fopen('train_set.txt','w');
fidval = fopen('valid_set.txt','w');

pos_index = 1;

for in_class = 1:10
    str_folder = num2str(in_class);
    mkdir([my_dir, str_folder,'/train'])
    mkdir([my_dir, str_folder,'/test'])
    for i = 1:36
        str_file = num2str(i);
        if(length(str_file) < 2)
            str_pre = ['0',str_file];
        else 
            str_pre = str_file;
        end
        name = [str_pre,'_flower',str_folder,'.jpg'];
        copyfile([my_dir,str_folder,'/',name],[my_dir,str_folder,'/train']);
        fprintf(fidtrain,[my_dir,str_folder,'/train/',name,' \t ',str_folder,'\n']);
        
        copyfile([my_dir,str_folder,'/',name],[my_dir,'/pos/',num2str(pos_index),'.jpg']);
        pos_index = pos_index + 1;
    end
    for i = 37:60
        str_file = num2str(i);
        if(length(str_file) < 2)
            str_pre = ['0',str_file];
        else 
            str_pre = str_file;
        end
        name = [str_pre,'_flower',str_folder,'.jpg'];
        copyfile([my_dir,str_folder,'/',name],[my_dir,str_folder,'/test']);
        fprintf(fidval,[my_dir,str_folder,'/test/',name,' \t ',str_folder,'\n']);
        copyfile([my_dir,str_folder,'/',name],[my_dir,'/pos/',num2str(pos_index),'.jpg']);
        pos_index = pos_index + 1;
    end
end
fclose(fidtrain);
fclose(fidval);

