clc
clear
close all
A = xlsread('met.xlsx');  %∂¡»°distribution£¨
A(:,13)=[];A(:,12)=[];
s=61;
meanas=A(s,:);
meanbs=A(s+1,:);
erras=A(s+2,:);
errbs=A(s+3,:);
meanac=A(s+4,:);
meanbc=A(s+5,:);
errac=A(s+6,:);
errbc=A(s+7,:);
meanaa=A(s+8,:);
meanba=A(s+9,:);
erraa=A(s+10,:);
errba=A(s+11,:);
% 
x1=linspace(7.8,10.8,11);
x2=linspace(7.9,10.9,11);
% x3=linspace(9.05,10.85,7);
errorbar(x1,meanaa,erraa,'-or','LineWidth',1)
grid on
hold on
errorbar(x1,meanac,errac,'--xr','LineWidth',1)
errorbar(x1,meanas,erras,'-.*r','LineWidth',1)
errorbar(x2,meanba,errba,'-ob','LineWidth',1)
errorbar(x2,meanbc,errbc,'--xb','LineWidth',1)
errorbar(x2,meanbs,errbs,'-.*b','LineWidth',1)
% errorbar(x3,meana,erra,'-k','LineWidth',2)

legend('All Above Galaxies','Central Above','Satellite Above','All Below Galaxies','Central Below','Satellite Below')
xlabel('log(M_{*})/M°—');
ylabel('SF_{gas} 12+log10(O/H)');
title('EAGLE Ref-L100N1504 at z=0') 
hold off