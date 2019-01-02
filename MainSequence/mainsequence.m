clear
clc
close all
A = xlsread('Galaxy28.csv');  %读取红移为0处Galaxy数据
GalaxyID=A(:,1);
SFR=A(:,2);
StellarMass=A(:,3);
N=numel(StellarMass);
d=1;
d=1;
for i=1:N                                      %去除SFR=0的星系
  if SFR(i)~=0;
     x(d)=log10(StellarMass(i));
     y(d)=log10(SFR(i));
     z(d)=y(d)-x(d);
     d=d+1;
  end
end

                                         %Set the Bin Width
[n C]=hist3([x(:) z(:)],'Ctrs',{6.7:0.3:12.4 -13:0.1:-7});

for j=1:20
    nn(j,:)=n(j,:)/max(n(j,:));          %等比例放缩设置Bin中最大值为1       
end
mm=nn';

for i=1:20
    [p(i) q(i)]=max(n(i,:));
    X(i)=C{1}(i);
    Y(i)=C{2}(q(i));
end
x11=linspace(7.7,11.3);
y11=interp1(X,Y,x11,'v5cubic');


fig=contourf(C{1},C{2},mm);
hold on
plot(X,Y,'.','markersize',20) 
plot(x11,y11,'b','LineWidth',4)
xlabel('log(M_{*})/M⊙');
ylabel('log(sSFR)/yr^{-1}')
title('RefL0100N1504, All Galaxies,SnapNum=28')   %4
grid on
hold off
% for i=1:20
%     [p(i) q(i)]=max(n(i,:));
%     X(i)=C{1}(i);
%     Y(i)=C{2}(q(i));
% end
% 
% plot(X,Y,'.')


% for j=1:q                                      %Normalization
%     nnn(j,:)=n(j,:)/sum(n(j,:));
% end
% 
% s=1;
% for i=4:1:15                                  %Select Data Range(Stellar Mass between 7-11)
%     [max_nnn(i),index(i)]=max(nnn(i,:));
%      X(s)=C{1}(i);
%      Y(s)=C{2}(index(i));
%      s=s+1;
% end
% 
% pp=polyfit(X,Y,1);
% x1=linspace(6.5,11.5);
% y11=interp1(X,Y,x1,'v5cubic');
% y1=polyval(pp,x1);
% 
% 
% [n C]=hist3([x(:) y(:)],[30 30]);
% 
% for j=1:30
%     nn(j,:)=n(j,:)/max(n(j,:));          %等比例放缩设置Bin中最大值为1       
% end
% 
% mm=nn';
% 
% 
% % 绘制子图：Find the Active Galaxies Ratio at fixed StellarMass
% B = xlsread('Starformating SnapNum=28.csv');  %
% 
% GalaxyIDD=B(:,1);
% SFRR=B(:,2);
% StellarMasss=B(:,3);
% NN=numel(StellarMasss);
% xx=log10(StellarMasss);
% for i=1:NN                      %设置MainSequence & Quench Cut
%   if SFRR(i)==0;
%      yy(i) = -5;
%   else yy(i)=log10(SFRR(i));
%   end
% end
% k=[0.837590231 0.861641922 0.893124949 0.896923699 0.957228369 1.075691923];
% b=[-8.625410893  -8.743123103 -8.752557819 -8.499791355 -8.704632751 -9.306867114];
% c=[0.918 0.85 1.064 0.724 1.0205 2];
% 
% qq=20;
% [n1 C1]=hist3([xx(:) yy(:)],[qq qq]);
% 
% x2=linspace(7.65,12.18);
% cut=[pp(1),pp(2)-c(1)];     % 线性拟合MS & Quench Cut
% y2=polyval(cut,x2);
% 
% above=zeros(1,qq);
% below=zeros(1,qq);
% xx1=linspace(6,13);
% yy1=k(4).*xx1+b(4);
% 
% % plot(x,y,'.',x1,y1)
% for i=1:qq
%     yy2(i)=k(1)*C1{1}(i)+b(1)-c(1);    %Deviede the Galaxies into Above MS and Below MS
%     nn1(i,:)=n1(i,:)/sum(n1(i,:));
%     if C1{2}(i)>yy2(i)
%         for j=i:1:qq
%         above(i)=above(i)+nn1(i,j);
%         end
%     end
% end
% 
% 
% [y0 index]=max(above);             %Draw out the Actual Sequence
% x0=C1{1}(index);
% x00=roundn(x0,-3);
% y00=roundn(y0,-3);
% % above(index:qq)=smooth(above(index:qq),(qq-index+1));
% 
% 
% fig=contourf(C{1},C{2},mm);
% xlabel('log(M_{*})/M⊙');
% ylabel('log(SFR)/M⊙yr^{-1}')
% title('RefL0100N1504,Central Galaxies,SnapNum=28')   %4
% grid on
% colormap jet
% colorbar
% hold on 
% plot(X,Y,'.','markersize',20) 
% plot(x1,y1,'m','LineWidth',4)
% plot(x1,y11,'b','LineWidth',4)
% % hold off
% plot(x2,y2,'r','LineWidth',2)
% % legend('Distribution Contour','Maximum points','Linear MS','Actual MS')
% 
% legend('Distribution Contour','Maximum points','Main Sequence','Actual Sequence','quiescence cut')
% 
% hold off
