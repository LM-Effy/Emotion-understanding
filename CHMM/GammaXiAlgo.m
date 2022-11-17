function [Gamma,Xi] = GammaXiAlgo(A,B,Pi,O)
% 函数功能：计算Baum-Welch算法公式中的gamma概率和xi概率
P1 = zeros();
A_size = size(A);
O_size = size(O);
N = A_size(1,1);
M = A_size(1,2);
K = O_size(1,1);

% 调用前向后向算法函数ForwardBackwardAlgo_1，计算得到alpha矩阵P1，beta矩阵P2和观测序列O的概率p1
[P1,P2,p1] = ForwardBackwardAlgo(A,B,Pi,O);

% t表示观测序列时间长度数，i表示状态数；
% -------------计算单个状态概率gamma = Gamma--------------
Gamma = zeros();
for t = 1:K
    for i = 1:M
        Gamma(i,t) = P1(i,t) * P2(i,t) / p1;
    end
end

% --------------计算两个状态概率xi = Xi-----------------
Xi = zeros();
for t = 1:K-1
    for i = 1:M
        for j = 1:N
           Xi(i,j,t) = P1(i,t) * A(i,j) * B(j,O(t+1,1)) * P2(j,t+1) / p1;
        end
    end
end