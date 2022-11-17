function [A_1,B_1,Pi_1] = BaumWelchAlgo(A,B,Pi,O)
A_size = size(A);
B_size = size(B);
O_size = size(O);
N = A_size(1,1);%状态集个数
M = A_size(1,2);
Y = B_size(1,2);%B的列数，即观测集个数
K = O_size(1,1);

% ----调用GammaXiAlgo函数，计算Gamma矩阵和Xi矩阵----
[Gamma,Xi] = GammaXiAlgo(A,B,Pi,O);

% ---------------计算转移概率矩阵A_1---------------
A_1 = zeros();
f = sum(Gamma,2);%计算Gamma的每一行之和，表示在观测时间序列的所有时刻都处于某一个状态的概率和
for i = 1:M
    for j = 1:N
        A_1(i,j) = sum(sum(Xi(i,j,:))) / (f(i,1) - Gamma(i,K));
    end
end

% ---------------计算观测概率矩阵B_1---------------
B_1 = zeros();
G = zeros();
c = 0;
for y = 1:Y
    for j = 1:N
        for t = 1:K
            if O(t,1) == y % 用于比较输出的观测值是否由对应的状态值输出，即条件ot = vk;
                c = c + 1;
                G(c,1) = Gamma(j,t);
            end
        end
         B_1(j,y) = sum(G) / f(j,1);
         c = 0;
         G = zeros();
    end
end

% ---------------计算初始概率pi_1---------------
Pi_1 = zeros();
for i = 1:M
    Pi_1(i,1) = Gamma(i,1);
end

