function [A_n,B_n,Pi_n] = BaumWelchAlgo_n(A,B,Pi,O,n)
% �������ܣ�n�ε�����BaumWelchAlgo_n�㷨
for r = 1:n
     [A,B,Pi] = BaumWelchAlgo(A,B,Pi,O);
end
A_n = A;
B_n = B;
Pi_n = Pi;