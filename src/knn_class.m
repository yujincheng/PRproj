function [ result ] = knn_class( distance, group, kvalue)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    A = distance;
    B = [];
    for i = 1:kvalue
        [~,minPos] = min(A);
        B = [B,group(minPos)];
        A(minPos) = inf;
    end
    result = mode(B);
end

