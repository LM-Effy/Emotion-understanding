function [A_n,B_n,Pi_n] = BaumWelchAlgo_n(A,B,Pi,O,n)
% 函数功能：n次迭代的BaumWelchAlgo_n算法
for r = 1:n
     [A,B,Pi] = BaumWelchAlgo(A,B,Pi,O);
end
A_n = A;
B_n = B;
Pi_n = Pi;