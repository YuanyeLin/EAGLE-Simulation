xmin=-3;                      %���ļ�����Դ������HaloMass.m
xmax=-0.5;                      %����������Ϸ�Χ       

width=0.1;                     %����bin width
n=(xmax-xmin)*(1/width)+1;            
xbins=linspace(xmin,xmax,n);
[n1,C1]=hist(meta,xbins);
[n2,C2]=hist(metb,xbins);
meana=mean(meta);               %����Above MSƽ��ֵ
meanb=mean(metb);               %����Below MSƽ��ֵ
metan=length(meta);
metbn=length(metb);
erra=std(meta)/sqrt(metan);
errb=std(metb)/sqrt(metbn);
table=[meana erra meanb errb]
n11=n1'./sum(n1);
n22=n2'./sum(n2);
n=n11;
n(:,2)=n22;
b=bar(n);                     %����״ͼ��ͼ
grid on
set(gca,'XTickLabel',{'-3.0','-2.5','-2.0','-1.5','-1.0','-0.5','0'})
legend('Above MS','Below MS');
xlabel('Metallicity');
ylabel('Ratio');
text(0.8,0.27,{['Number_{Above}=' num2str(metan) '' ]},'FontSize',10,'FontWeight','bold');
text(0.8,0.25,{['Number_{Below}=' num2str(metbn) '' ]},'FontSize',10,'FontWeight','bold');
title('M_{star} =[7.7,8.0] at z=0 ')