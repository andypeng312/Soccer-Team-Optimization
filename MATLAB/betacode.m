clear; close all; clc;



filename = {'Strikers.xlsx' 'Wingers.xlsx' 'CenterM.xlsx' 'SideM.xlsx' 'CenterB.xlsx' 'SideB.xlsx' 'GK1.xlsx'};

betar = [];
betav = [];

for i = 1:7

    C = xlsread(filename{i});

    if i == 7
        z = C(:,1).*0.2 + C(:,2).*0.25 + C(:,3).*0.5 + C(:,4).*0.05;
        C = [C z];
        betart = lsqlin(C(:,[5:9 12]),C(:,10),[],[],[],[],zeros(6,1),ones(6,1));
        betar = [betar;betart];
        temp = [(C(:,[5:9 12])*betart) C(:,11)];
    else
        betart = lsqlin(C(:,(1:6)),C(:,7),[],[],[],[],zeros(6,1),ones(6,1));
        betar = [betar;betart];
        temp = [(C(:,(1:6))*betart) C(:,8)];
        temp1 = temp;
    end

    temp = temp(all(temp,2),:);
%     X = [ones(size(temp,1),1) (temp(:,1)) (temp(:,1)).^2 (temp(:,1)).^3 (temp(:,1)).^4 (temp(:,1)).^5];
    X = [ones(size(temp,1),1) (temp(:,1)).^5];
    z1 = log(temp(:,end));
    betavt = lsqlin(X,z1,[],[]);
    betav = [betav;betavt];

%     values = [ones(size(temp1,1),1) (temp1(:,1)).^2]*betavt;
%     values = exp(values);
% 
%     figure(i);
%     plot(temp1(:,1),values,'bx')
%         hold on;
%     plot(temp1(:,1),C(:,8),'ro')

    values = [ones(size(temp,1),1) (temp(:,1)).^5]*betavt;
    values = exp(values);

    figure(i);
    plot(temp(:,1),values,'bx')
        hold on;
    plot(temp(:,1),temp(:,2),'ro')


end


save 'betaRating.mat' betar
save 'betaValue.mat' betav