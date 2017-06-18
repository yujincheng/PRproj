function [ result ] = knn_class( distance, group, kvalue)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    A = distance;
    B = [];
    for i = 1:kvalue
        [~,minPos] = min(A);
        B = [B,group(minPos)];
        A(minPos) = inf;
    end
    result = mode(B);
end

