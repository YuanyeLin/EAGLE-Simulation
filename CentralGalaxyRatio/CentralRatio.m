 clc
clear
close all
A = xlsread('CGratio28.csv');
B= xlsread('MS.xlsx');
GalaxyID=A(:,1);
SFR=A(:,2);
StellarMass=A(:,3);
sub=A(:,5);
locx=A(:,6);
locy=A(:,7);
locz=A(:,8);
N=length(GalaxyID);
X=B(1,:);Y=B(2,:);



for i=1:N
    if SFR(i)==0
        sfr(i)=-10;
    elseif SFR(i)~=0
        sfr(i)=log10(SFR(i));
    end
    mstar(i)=log10(StellarMass(i));
end
        
dex=0.1;
for i=1:N                                  %Above,Below,Quench
    if interp1(X,Y,mstar(i),'v5cubic')-dex>sfr(i)
       z(i)=2;
    elseif interp1(X,Y,mstar(i),'v5cubic')-dex<sfr(i)&& sfr(i)<interp1(X,Y,mstar(i),'v5cubic')
       z(i)=1;
    elseif interp1(X,Y,mstar(i),'v5cubic')<sfr(i)
       z(i)=0;
    end
end
for i=1:N
    if locx(i)<50 && locy(i)<50 && locz(i)<50
        l(i)=1;
    elseif locx(i)<50 && locy(i)>50 && locz(i)<50
        l(i)=2;
    elseif locx(i)>50 && locy(i)<50 && locz(i)<50
        l(i)=3;
    elseif locx(i)>50 && locy(i)>50 && locz(i)<50
        l(i)=4;
    elseif locx(i)<50 && locy(i)<50 && locz(i)>50
        l(i)=5;
    elseif locx(i)<50 && locy(i)>50 && locz(i)>50
        l(i)=6;
    elseif locx(i)>50 && locy(i)<50 && locz(i)>50
        l(i)=7;
    elseif locx(i)>50 && locy(i)>50 && locz(i)>50
        l(i)=8;    
    end
end
bin=linspace(7.7,11,12);
for j=1:11
for k=1:8
for i=1:N
       if l(i)==k
           if sub(i)==0 && mstar(i)>bin(j) && mstar(i)<bin(j+1) && z(i)==0 
              ac(j,k,i)=1;
           elseif sub(i)~=0 && mstar(i)>bin(j) && mstar(i)<bin(j+1) && z(i)==0 
              as(j,k,i)=1;
           elseif sub(i)==0 && mstar(i)>bin(j) && mstar(i)<bin(j+1) && z(i)==1  
              bc(j,k,i)=1;
           elseif sub(i)~=0 && mstar(i)>bin(j) && mstar(i)<bin(j+1) && z(i)==1  
              bs(j,k,i)=1;
           end  
       end
    end

end
end

for j=1:11
    for k=1:8
        aC(j,k)=sum(ac(j,k,:));aA(j,k)=(sum(ac(j,k,:))+sum(as(j,k,:)));
        bC(j,k)=sum(bc(j,k,:));bA(j,k)=(sum(bc(j,k,:))+sum(bs(j,k,:)));
        C(j,k)=(sum(ac(j,k,:))+sum(bc(j,k,:)));All(j,k)=((sum(ac(j,k,:))+sum(as(j,k,:)))+(sum(bc(j,k,:))+sum(bs(j,k,:))));
    end
end

for i=1:11
    aC(i,9)=sum(aC(i,:));
    aA(i,9)=sum(aA(i,:));
    bC(i,9)=sum(bC(i,:));
    bA(i,9)=sum(bA(i,:));
    C(i,9)=sum(C(i,:));
    All(i,9)=sum(All(i,:));
end

for i=1:8
    AC(:,i)=aC(:,9)-aC(:,i);
    AA(:,i)=aA(:,9)-aA(:,i);
    BC(:,i)=bC(:,9)-bC(:,i);
    BA(:,i)=bA(:,9)-bA(:,i);
    CC(:,i)=C(:,9)-C(:,i);
    AAll(:,i)=All(:,9)-All(:,i);
end

ra=AC./AA;
rb=BC./BA;
r=CC./AAll;
for i=1:11
    mra(i)=mean(ra(i,:));
    mrb(i)=mean(rb(i,:));
    mr(i)=mean(r(i,:));
    erra(i)=std(ra(i,:))*sqrt(7);
    errb(i)=std(rb(i,:))*sqrt(7);
    err(i)=std(r(i,:))*sqrt(7);
end
RA=aC(:,9)./aA(:,9);RB=bC(:,9)./bA(:,9);R=C(:,9)./All(:,9);
xbin=linspace(7.8,10.8,11);
errorbar(xbin,mra,erra,'--or','LineWidth',1)
hold on
errorbar(xbin,mrb,errb,'--ob','LineWidth',1)
errorbar(xbin,mr,err,'--om','LineWidth',1)
plot(xbin,RA,'-r','LineWidth',1)
plot(xbin,RB,'-b','LineWidth',1)
plot(xbin,R,'-m','LineWidth',1)
hold off
grid on
legend('Above the MS','Below the MS','All')
xlabel('log(M_{Star})/M¡Ñ');
ylabel('Central Galaxies ratio');
title('Central Galaxies fraction within Active Galaxies at z=0') 

