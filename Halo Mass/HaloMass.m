% clear
% clc
% close all
% A = xlsread('CentralGalaxy28.csv');  %��ȡGalaxy����
% B = xlsread('Halo28.csv');           %��ȡHalo����
% C= xlsread('MS.xlsx');
% GalaxyID=A(:,1);
% SFR=A(:,2);
% StellarMass=A(:,3);
% GID=A(:,6);
% N1=numel(StellarMass);
% X=C(1,:);
% Y=C(2,:);
% 
% ID=B(:,1);
% Mh=log10(B(:,2));
% N2=numel(ID);
% % 
% % % 
% % k=[0.837590231 0.861641922 0.893124949 0.896923699 0.957228369 1.075691923];
% % b=[-8.625410893  -8.743123103 -8.752557819 -8.499791355 -8.704632751 -9.306867114];
% % c=[0.918 0.85 1.064 0.724 1.0205 2];            % MS and Quench Cut 
% 
% s=1;
% for i=1:N1                              %ȥ��������ϵ
%   if SFR(i)~=0;
%      x1(s)=log10(StellarMass(i));
%      y1(s)=log10(SFR(i));
%      GID1(s)=GID(i);
%      s=s+1;
%   end
% end
% % 
% % 
% for i=1:s-1                             %2:above 1:below 0:quench
%     if y1(i)>interp1(X,Y,x1(i),'v5cubic')
%         z(i)=2;
%     elseif y1(i)<interp1(X,Y,x1(i),'v5cubic') && y1(i)>interp1(X,Y,x1(i),'v5cubic')-1
%         z(i)=1;
%     elseif y1(i)<interp1(X,Y,x1(i),'v5cubic')-1
%         z(i)=0;
%     end
% end
% 
% % for i=1:s-1                             %2:above 1:below 0:quench
% %     if y1(i)>k(1)*x1(i)+b(1)
% %         z(i)=2;
% %     elseif y1(i)<k(1)*x1(i)+b(1) && y1(i)>k(1)*x1(i)+b(1)-c(1)
% %         z(i)=1;
% %     elseif y1(i)<k(1)*x1(i)+b(1)-c(1)
% %     end
% % end
% 
% xbin=linspace(7.7,11,12);
% sd=1;
% % for q=1:length(xbin)-1
% for i=1:s-1                             %�ڹ̶�������MS���µ���ϵ�ֿ�
%     if  xbin(1)<x1(i) && x1(i)<xbin(12)          
%         xd(sd)=x1(i);
%         yd(sd)=y1(i);
%         GIDd(sd)=GID1(i);
%         zd(sd)=z(i);
%         sd=sd+1;
%     end
% end
% sa=1;sb=1;
% for i=1:sd-1                             %�ڹ̶�������MS���µ���ϵ�ֿ�
%     if  zd(i)==2      
%         xa(sa)=xd(i);
%         ya(sa)=yd(i);
%         GIDa(sa)=GIDd(i);
%         sa=sa+1;
%     elseif  z(i)==1
%         xb(sb)=xd(i);
%         yb(sb)=yd(i);
%         GIDb(sb)=GIDd(i);
%         sb=sb+1;
%     end
% end
% 
% for i=1:sa-1                         %Above the MS Halomass
%     m=find(ID==GIDa(i));
%     Ma(i)=Mh(m);  
% end
% 
% for i=1:sb-1                         %Below the MS Halomass
%     m=find(ID==GIDb(i));
%     Mb(i)=Mh(m);  
% end
% 
plot(xa,Ma,'r.')  
hold on
plot(xb,Mb,'b.')
hold off
legend('Galaxies above MS','Galaxies below MS')
xlabel('log(M_{Stellar})/M��');
ylabel('log(M_{Halo})/M��');
title('Central Galaxy:StellarMass vs HaloMass at z=0') 
text(10,10.5,{['N_{Above}=' num2str(sa-1) '' ]},'FontSize',10,'FontWeight','bold');
text(10,10.2,{['N_{Below}=' num2str(sb-1) '' ]},'FontSize',10,'FontWeight','bold');


% xmin=10;                      %���ļ�����Դ������HaloMass.m
% xmax=15;                      %����������Ϸ�Χ       
% 
% width=0.2;                     %����bin width
% n=(xmax-xmin)*(1/width)+1;            
% xbins=linspace(xmin,xmax,n);
% [n1,C1]=hist(Ma,xbins);
% [n2,C2]=hist(Mb,xbins);
% meana=mean(Ma);               %����Above MSƽ��ֵ
% meanb=mean(Mb);               %����Below MSƽ��ֵ
% Man=length(Ma);
% Mbn=length(Mb);
% erra=std(Ma)/sqrt(Man);
% errb=std(Mb)/sqrt(Mbn);
% 
% table(q,:)=[meana meanb erra errb] ;  %����ֲ���������ֵ
% % end
% Meana=table(:,1);
% Meanb=table(:,2);
% Erra=table(:,3);
% Errb=table(:,4);
% axis1=linspace(7.8,10.8,11);
% axis2=linspace(7.9,10.9,11);
% errorbar(axis1,Meana,Erra,'-ob','LineWidth',1)
% grid on
% hold on
% errorbar(axis2,Meanb,Errb,'-or','LineWidth',1)
% legend('HaloMass of Galaxies above the MS','HaloMass of Galaxies below the MS')
% xlabel('log(M_{*})/M��');
% ylabel('log(M_{halo})/M��');
% title('Stellar Mass vs Halo Mass Function at z=0') 
% % text(8,11,{['cutdex =' num2str(0.3) '' ]},'FontSize',10,'FontWeight','bold');
% hold off
