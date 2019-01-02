clear
clc
close all
A = xlsread('Galaxy28.csv');
B= xlsread('MS.xlsx');
A(1,:)=[];
GalaxyID=A(:,1);
SFR=A(:,2);
StellarMass=A(:,3);
N=numel(StellarMass);
X=B(1,:);Y=B(2,:);


for i=1:N                            %È¥³ýËÀÍöÐÇÏµ
  if SFR(i)~=0  
     y1(i)=log10(SFR(i));
  elseif SFR(i)==0      
     y1(i)=-10;
  end   
     x1(i)=log10(StellarMass(i));
end

xbin=linspace(7.7,11,12);
l=length(xbin)-1;
ybin=linspace(-4,1,51);
y11=interp1(X,Y,xbin,'v5cubic');

s=1;
for i=1:N
  if y1(i)>interp1(X,Y,x1(i),'v5cubic')-10
  x2(s)=x1(i);
  y2(s)=y1(i);
  s=s+1;
  end
end
n=length(x2);
for i=1:l
    ss=1;
    for j=1:n
        if x2(j)>xbin(i) && x2(j)<xbin(i+1) 
            x3(i,ss)=x2(j);
            y3(i,ss)=y2(j);
            ss=ss+1;
        end
    end
end
y3(find(y3==0))=-10;
for i=1:l
    n1(i,:)=hist(y3(i,:),ybin);
end
     n1(:,1)=[];
for i=1:l     
    S(i)=sum(n1(i,:));
    nn1(i,:)=n1(i,:)/sum(n1(i,:));   
end

ybin1=linspace(-3.9,1,50);
for i=1:l
    subplot(4,4,i)
    plot(ybin1,nn1(i,:))
    xlim([-3.2 1.6])
    xlabel('log(SFR)/M¡Ñyr^{-1}');
    ylabel('ratio')
    text(-3,0.02,{['log(M_{star})=(' num2str(xbin(i)) ',' num2str(xbin(i+1)) ')' ]},'FontSize',10,'FontWeight','bold');
    text(-3,0.08,{['Number=' num2str(S(i)) '' ]},'FontSize',10,'FontWeight','bold');
end
suptitle('quench cut dex=10')
