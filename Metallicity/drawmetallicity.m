clc
clear
close all
A = xlsread('Metallicity.xlsx');  %读取distribution，
ameana=A(:,2)' ;       %平均值
aerra=A(:,3)'  ;
ameanb=A(:,4)'   ;     
aerrb=A(:,5)'  ;
cmeana=A(:,6)'   ;     
cerra=A(:,7)'  ;
cmeanb=A(:,8)'    ;    
cerrb=A(:,9)'  ;
smeana=A(:,10)' ;       
serra=A(:,11)'  ;
smeanb=A(:,12)'   ;     
serrb=A(:,13)'  ;

x1=linspace(7.8,10.8,11);
x2=linspace(7.9,10.9,11);
errorbar(x1,ameana,aerra,'-or','LineWidth',1)
grid on
hold on
errorbar(x2,ameanb,aerrb,'-ob','LineWidth',1)
errorbar(x1,cmeana,cerra,'--xr','LineWidth',1)
errorbar(x2,cmeanb,cerrb,'--xb','LineWidth',1)
errorbar(x1,smeana,serra,'-.*r','LineWidth',1)
errorbar(x2,smeanb,serrb,'-.*b','LineWidth',1)

legend('All Above Galaxies','All Below Galaxies','Central Above','Central Below','Satellite Above','Satellite Below')
xlabel('log(M_{*})/M⊙');
ylabel('Metal Fraction');
title('SteallarMass-Metal Fraction Relation at z=0') 
hold off