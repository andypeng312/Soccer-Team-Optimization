%%
function skillist = mainn2(budget,off_def,wid_cen)
%%
% close all; clc; clear;
load 'betaRating.mat'
load 'betaValue.mat'

%%
x = sym('x', [1 42]);

w_l = [(0.5 - 0.35*off_def);0.25;(0.15 + 0.3*off_def);(0.10 + 0.05*off_def)];
w_w = [(0.2 + 0.6*wid_cen),(0.8 - 0.6*wid_cen),(0.4 + 0.2*wid_cen),(0.6 - 0.2*wid_cen),(0.2 + 0.6*wid_cen),(0.8 - 0.6*wid_cen)];

beta = betar;
theta = betav;

temp2 = [repmat(w_l(1)*w_w(1),[6 1]);
    repmat(w_l(1)*w_w(2),[6 1]);
    repmat(w_l(2)*w_w(3),[6 1]);
    repmat(w_l(2)*w_w(4),[6 1]);
    repmat(w_l(3)*w_w(5),[6 1]);
    repmat(w_l(3)*w_w(6),[6 1]);
    repmat(w_l(4),[6 1]);];

%%
ofun = @(x) -(beta'.*x')*temp2;

x0 = randi([10 70], 42, 1);
A = [beta(1:6)' zeros(1,36);
    zeros(1,6) beta(7:12)' zeros(1,30);
    zeros(1,12) beta(13:18)' zeros(1,24);
    zeros(1,18) beta(19:24)' zeros(1,18);
    zeros(1,24) beta(25:30)' zeros(1,12);
    zeros(1,30) beta(31:36)' zeros(1,6);
    zeros(1,36) beta(37:42)';
    -beta(1:6)' zeros(1,36);
    zeros(1,6) -beta(7:12)' zeros(1,30);
    zeros(1,12) -beta(13:18)' zeros(1,24);
    zeros(1,18) -beta(19:24)' zeros(1,18);
    zeros(1,24) -beta(25:30)' zeros(1,12);
    zeros(1,30) -beta(31:36)' zeros(1,6);
    zeros(1,36) -beta(37:42)'];
b = [100;100;100;100;100;100;100;
    -45; -45; -45; -45; -45; -45; -45];

Aeq = [];
beq = [];
lb = zeros(42,1);
ub = ones(42,1)*100;

%%
c = vpa(zeros(7,1));

for i = 1:7
    OverallRating(i,1) = x(i*6-5:6*i)*beta(i*6-5:6*i);
    c(i,1) = exp(theta((2*i)-1) + theta(2*i)*(OverallRating(i,1))^5);
end

z = c(1) + 2*c(2) + c(3) + 2*c(4) + 2*c(5) + 2*c(6) + c(7) - budget;

das = matlabFunction(z,'Vars',{x});
ceq = [];

%%
opts = optimset('Display','iter','Algorithm','interior-point', 'MaxIter', 1000000, 'MaxFunEvals', 1000000);
skil_optimum = fmincon(ofun, x0, A, b, Aeq, beq, lb, ub,@(x) deal(ceq,das(x')), opts);

% aa = -1* ofun(skil_optimum)

%%
for i = 1:7
    skill(i) = beta(i*6-5:6*i)'*skil_optimum(i*6-5:6*i);
end
skill = skill';

%%
for i = 1:7
    skillist(i,:) = skil_optimum(6*i-5:6*i);
end
skillist(:,7) = skill;
%%
values = [ones(size(skill,1),1) (skill(:,1)).^5];
for i = 1:size(theta,1)/2
values(i,:) = values(i,:)*[theta(i*2-1:i*2)];

end
values = exp(values);
z = vpa(sum(values(:,1)))