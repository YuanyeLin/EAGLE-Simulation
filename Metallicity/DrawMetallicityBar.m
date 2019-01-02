xmin=-3;                      %该文件数据源来自于HaloMass.m
xmax=-0.5;                      %设置数据拟合范围       

width=0.1;                     %设置bin width
n=(xmax-xmin)*(1/width)+1;            
xbins=linspace(xmin,xmax,n);
[n1,C1]=hist(meta,xbins);
[n2,C2]=hist(metb,xbins);
meana=mean(meta);               %计算Above MS平均值
meanb=mean(metb);               %计算Below MS平均值
metan=length(meta);
metbn=length(metb);
erra=std(meta)/sqrt(metan);
errb=std(metb)/sqrt(metbn);
table=[meana erra meanb errb]
n11=n1'./sum(n1);
n22=n2'./sum(n2);
n=n11;
n(:,2)=n22;
b=bar(n);                     %以柱状图绘图
grid on
set(gca,'XTickLabel',{'-3.0','-2.5','-2.0','-1.5','-1.0','-0.5','0'})
legend('Above MS','Below MS');
xlabel('Metallicity');
ylabel('Ratio');
text(0.8,0.27,{['Number_{Above}=' num2str(metan) '' ]},'FontSize',10,'FontWeight','bold');
text(0.8,0.25,{['Number_{Below}=' num2str(metbn) '' ]},'FontSize',10,'FontWeight','bold');
title('M_{star} =[7.7,8.0] at z=0 ')