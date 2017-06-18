clc;
clear all;

my_dir = '../data/';
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
    end
end

