clear
clc
close all
A = xlsread('CentralGalaxy28.csv');
B= xlsread('MS.xlsx');
C= xlsread('Halo28.csv');

GalaxyID=A(:,1);
SFR=A(:,2);
StellarMass=A(:,3);
GID=A(:,6);
N1=numel(StellarMass);
X=B(1,:);Y=B(2,:);

ID=C(:,1);
mh=log10(C(:,2));
N2=numel(ID);
for i=1:N1                            %È¥³ýËÀÍöÐÇÏµ
  if SFR(i)~=0  
     y1(i)=log10(SFR(i));
  elseif SFR(i)==0      
     y1(i)=-10;
  end   
     x1(i)=log10(StellarMass(i));
end

dex=1;    %set cut dex
for i=1:N1                          %2:above 1:below 0:quench   
    if y1(i)>interp1(X,Y,x1(i),'v5cubic')
        z(i)=2;
    elseif y1(i)<interp1(X,Y,x1(i),'v5cubic') && y1(i)>interp1(X,Y,x1(i),'v5cubic')-dex
        z(i)=1;
    elseif y1(i)<interp1(X,Y,x1(i),'v5cubic')-dex
        z(i)=0;
    end
end
xbin=linspace(7.7,11,12);
for q=1:11

sa=1;sb=1;
for i=1:N1
    if x1(i)>xbin(q) && x1(i)<xbin(q+1) && z(i)==2
        xa(sa)=x1(i);
        ya(sa)=y1(i);
        gida(sa)=GID(i);
        sa=sa+1;
    elseif x1(i)>xbin(q) && x1(i)<xbin(q+1) && z(i)==1
        xb(sb)=x1(i);
        yb(sb)=y1(i);
        gidb(sb)=GID(i);
        sb=sb+1;
    end
end

for i=1:sa-1
    ma(i)=mh(find(ID==gida(i)));
end

for i=1:sb-1
    mb(i)=mh(find(ID==gidb(i)));
end

meana(q)=mean(ma);
meanb(q)=mean(mb);
erra(q)=std(ma)/sqrt(length(ma));
errb(q)=std(mb)/sqrt(length(mb));
clear ma mb sa sb xa ya xb yb gida gidb
end

axis1=linspace(7.8,10.8,11);
axis2=linspace(7.9,10.9,11);
errorbar(axis1,meana,erra,'-or','LineWidth',1)
grid on
hold on
errorbar(axis2,meanb,errb,'-ob','LineWidth',1)
legend('HaloMass of Galaxies above the MS','HaloMass of Galaxies below the MS')
xlabel('log(M_{*})/M¡Ñ');
ylabel('log(M_{halo})/M¡Ñ');
title('Stellar Mass vs Halo Mass Function at z=0') 