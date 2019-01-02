clear
clc
close all
A = xlsread('28.csv');  %读取Galaxy数据
B= xlsread('MS.xlsx');
GalaxyID=A(:,1);
SFR=A(:,2);
StellarMass=A(:,3);
sub=A(:,4);
met=A(:,8);
N1=numel(StellarMass);
X=B(1,:);Y=B(2,:);


s=1;
for i=1:N1                              %去除死亡星系
  if SFR(i)~=0 
     x1(s)=log10(StellarMass(i));
     y1(s)=log10(SFR(i));
     met1(s)=log10(met(i));
     sub1(s)=sub(i);
     s=s+1;
  end
end
dex=0.3;
for i=1:s-1                             %2:above 1:below 0:quench
    if y1(i)>interp1(X,Y,x1(i),'v5cubic')
        z(i)=0;
    elseif y1(i)<interp1(X,Y,x1(i),'v5cubic') && y1(i)>interp1(X,Y,x1(i),'v5cubic')-dex
        z(i)=1;
    elseif y1(i)<interp1(X,Y,x1(i),'v5cubic')-dex
        z(i)=2;
    end
end


xbin=linspace(7.7,11,12);
for q=1:11 

sd=1;
for i=1:s-1                             %选出在某个Bin内的星系
    if  xbin(q)<x1(i) & x1(i)<xbin(q+1)          
        xd(sd)=x1(i);
        yd(sd)=y1(i);
        metd(sd)=met1(i);
        subd(sd)=sub1(i);
        zd(sd)=z(i);
        sd=sd+1;
    end
end
sac=1;sas=1;sbc=1;sbs=1;
for i=1:sd-1                             %在固定质量将MS上下的星系分开
    if  zd(i)==0&& subd(i)==0     
        xac(sac)=xd(i);
        yac(sac)=yd(i);
        metac(sac)=metd(i);
        sac=sac+1;
    elseif  zd(i)==0 && subd(i)~=0
        xas(sas)=xd(i);
        yas(sas)=yd(i);
        metas(sas)=metd(i);
        sas=sas+1;
    elseif  zd(i)==1 && subd(i)==0
        xbc(sbc)=xd(i);
        ybc(sbc)=yd(i);
        metbc(sbc)=metd(i);
        sbc=sbc+1;
    elseif  zd(i)==1 && subd(i)~=0
        xbs(sbs)=xd(i);
        ybs(sbs)=yd(i);
        metbs(sbs)=metd(i);
        sbs=sbs+1;    
    end
end
% plot(xac,yac,'b.')
% hold on
% plot(xas,yas,'b.')
% plot(xbc,ybc,'r.')
% plot(xbs,ybs,'r.')

xmin=-2.5;                      
xmax=1.5;                      %设置sfr拟合范围       

width=0.2;                     %设置bin width
n=(xmax-xmin)*(1/width)+1;            
xbins=linspace(xmin,xmax,n);
[n1,C1]=hist(yac,xbins);
[n2,C2]=hist(yas,xbins);
[n3,C3]=hist(ybc,xbins);
[n4,C4]=hist(ybs,xbins);
meanac(q)=mean(yac);               %计算Above MS平均值
meanas(q)=mean(yas);               %计算Below MS平均值
meanbc(q)=mean(ybc);               %计算Above MS平均值
meanbs(q)=mean(ybs);               %计算Below MS平均值
yacn=length(yac);
yasn=length(yas);
ybcn=length(ybc);
ybsn=length(ybs);
errac(q)=std(yac)/sqrt(yacn);
erras(q)=std(yas)/sqrt(yasn);
errbc(q)=std(ybc)/sqrt(ybcn);
errbs(q)=std(ybs)/sqrt(ybsn);
clear sd xd yd metd subd zd
clear sac xac yac metac
clear sas xas yas metas
clear sbc xbc ybc metbc
clear sbs xbs ybs metbs
clear n1 n2 n3 n4 C1 C2 C3 C4
clear yacn yasn ybcn ybsn
end
close 
x1=linspace(7.8,10.8,11);

errorbar(x1,meanac-meanas,sqrt(errac.^2+erras.^2),'-or','LineWidth',1.5)
grid on
hold on
errorbar(x1,meanbc-meanbs,sqrt(errbc.^2+errbs.^2),'-ob','LineWidth',1.5)
plot(xlim,[0 0],'k-','LineWidth',2)
legend('Above SFR_{Central}-SFR_{Satellite}','Below SFR_{Central}-SFR_{Satellite}')
xlabel('log(M_{*})/M⊙');
ylabel('\Delta log(SFR)/M⊙yr^{-1}');
axis([7.5 11 -0.3 0.3])
text(9.4,0.15,{['SFR_{Central}>SFR_{Satellite}' ]},'FontSize',20,'FontWeight','bold');
text(9.4,-0.15,{['SFR_{Central}<SFR_{Satellite}' ]},'FontSize',20,'FontWeight','bold');
title('SFR_{Central}-SFR_{Satellite} at z=0')

axes('Position',[0.14,0.61,0.3,0.3])
errorbar(x1,meanac,errac,'-o','LineWidth',1.2)
grid on
hold on
errorbar(x1,meanas,erras,'-*','LineWidth',1.2)
errorbar(x1,meanbc,errbc,'-o','LineWidth',1.2)
errorbar(x1,meanbs,errbs,'-*','LineWidth',1.2)
set(gca,'yaxislocation','right');


legend('Above Central','Above Satellite','Below Central','Below Satellite')
xlabel('log(M_{*})/M⊙');
ylabel('log(SFR)/M⊙yr^{-1}');
title('Central/Satellite Galaxies SFR above/below MS at z=0') 
hold off

% table(1,:)=meanac;table(2,:)=meanas;table(3,:)=meanbc;table(4,:)=meanbs;
% table(5,:)=errac;table(6,:)=erras;table(7,:)=errbc;table(8,:)=errbs;
% n11=n1'./sum(n1);
% n22=n2'./sum(n2);
% n33=n3'./sum(n3);
% n44=n4'./sum(n4);
% n=n11;
% n(:,2)=n22;
% n(:,3)=n33;
% n(:,4)=n44;
% b=bar(n);                     %以柱状图绘图
% grid on
% set(gca,'XTickLabel',{'-2.5','-1.5','-0.5','0.5','1.5','2.5'})
% legend('Central Galaxy Above','Satellite Galaxy Above','Central Galaxy Below','Satellite Galaxy Below');
% xlabel('log(SFR)/M⊙yr^{-1}');
% ylabel('Ratio');
% text(1.5,0.18,{['Number_{AC}=' num2str(yacn) '' ]},'FontSize',10,'FontWeight','bold');
% text(1.5,0.15,{['Number_{AS}=' num2str(yasn) '' ]},'FontSize',10,'FontWeight','bold');
% text(1.5,0.12,{['Number_{BC}=' num2str(ybcn) '' ]},'FontSize',10,'FontWeight','bold');
% text(1.5,0.09,{['Number_{BS}=' num2str(ybsn) '' ]},'FontSize',10,'FontWeight','bold');
% title('M_{star} =[10.7,11.0] at z=0 ')
% saveas(gcf, '098', 'png')