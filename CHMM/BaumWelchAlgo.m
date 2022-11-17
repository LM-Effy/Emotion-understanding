function [A_1,B_1,Pi_1] = BaumWelchAlgo(A,B,Pi,O)
A_size = size(A);
B_size = size(B);
O_size = size(O);
N = A_size(1,1);%״̬������
M = A_size(1,2);
Y = B_size(1,2);%B�����������۲⼯����
K = O_size(1,1);

% ----����GammaXiAlgo����������Gamma�����Xi����----
[Gamma,Xi] = GammaXiAlgo(A,B,Pi,O);

% ---------------����ת�Ƹ��ʾ���A_1---------------
A_1 = zeros();
f = sum(Gamma,2);%����Gamma��ÿһ��֮�ͣ���ʾ�ڹ۲�ʱ�����е�����ʱ�̶�����ĳһ��״̬�ĸ��ʺ�
for i = 1:M
    for j = 1:N
        A_1(i,j) = sum(sum(Xi(i,j,:))) / (f(i,1) - Gamma(i,K));
    end
end

% ---------------����۲���ʾ���B_1---------------
B_1 = zeros();
G = zeros();
c = 0;
for y = 1:Y
    for j = 1:N
        for t = 1:K
            if O(t,1) == y % ���ڱȽ�����Ĺ۲�ֵ�Ƿ��ɶ�Ӧ��״ֵ̬�����������ot = vk;
                c = c + 1;
                G(c,1) = Gamma(j,t);
            end
        end
         B_1(j,y) = sum(G) / f(j,1);
         c = 0;
         G = zeros();
    end
end

% ---------------�����ʼ����pi_1---------------
Pi_1 = zeros();
for i = 1:M
    Pi_1(i,1) = Gamma(i,1);
end

