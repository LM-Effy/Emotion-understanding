function [Gamma,Xi] = GammaXiAlgo(A,B,Pi,O)
% �������ܣ�����Baum-Welch�㷨��ʽ�е�gamma���ʺ�xi����
P1 = zeros();
A_size = size(A);
O_size = size(O);
N = A_size(1,1);
M = A_size(1,2);
K = O_size(1,1);

% ����ǰ������㷨����ForwardBackwardAlgo_1������õ�alpha����P1��beta����P2�͹۲�����O�ĸ���p1
[P1,P2,p1] = ForwardBackwardAlgo(A,B,Pi,O);

% t��ʾ�۲�����ʱ�䳤������i��ʾ״̬����
% -------------���㵥��״̬����gamma = Gamma--------------
Gamma = zeros();
for t = 1:K
    for i = 1:M
        Gamma(i,t) = P1(i,t) * P2(i,t) / p1;
    end
end

% --------------��������״̬����xi = Xi-----------------
Xi = zeros();
for t = 1:K-1
    for i = 1:M
        for j = 1:N
           Xi(i,j,t) = P1(i,t) * A(i,j) * B(j,O(t+1,1)) * P2(j,t+1) / p1;
        end
    end
end