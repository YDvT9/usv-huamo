%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Դ��: ������ ���������˶�����Ӧ��ģ���ơ� 2019���ѧ������
%%���ص�ַwww.shenbert.cn/book/shipmotionASMC.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts] = sfun_ship(t,x,u,flag)
switch flag,
  case 0,
  %Initialization
    [sys,x0,str,ts]=mdlInitializeSizes;
  case 1,
  %Derivatives
    sys=mdlDerivatives(t,x,u);
  case 3,
  %Outputs
    sys=mdlOutputs(t,x,u);
  case {2,4,9},
    sys=[];
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
%��ʼ���ӳ���
function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes; %����size���ݽṹ
sizes.NumContStates=0; %����״̬��
sizes.NumDiscStates=0; %��ɢ״̬��
sizes.NumOutputs=2; %���������
sizes.NumInputs=1; %����������
sizes.DirFeedthrough=1; %�Ƿ���ڴ���ѭ��(1һ����)
sizes.NumSampleTimes=1; %����ʱ�����
sys=simsizes(sizes); %����size���ݽṹ����������Ϣ
x0=[]; %���ó�ֵ״̬
str=[]; %�����������ÿ�
ts=[0 0]; %����ʱ�� 

% when flag=3��computates the output signals
function sys=mdlOutputs(t,x,u)
n=10;
MaxGeneration=80;
alpha=0.2;
gamma=1.0;
delta=0.97;
sum=0;
lamdat=1;
h=0.1;
ze=u(1);
k=4;
% 
% if t==0 %Initilizing k4,k5
% sys(1)=1;
% sys(2)=100;
% end

range=[0 10 0 1000];
xrange=range(2)-range(1);
yrange=range(4)-range(3);
% xn=rand(1,n)*xrange+range(1);
% yn=rand(1,n)*yrange+range(3);

xn(1)=rand+range(1);
yn(1)=rand+range(3);
for c=2:n
   xn(c)=1*xn(c-1)*(1-xn(c-1));
   yn(c)=1*yn(c-1)*(1-yn(c-1));%��õ�XY
%    xn(c)=cos(4*acos(xn(c-1)));
%    yn(c)=cos(4*acos(yn(c-1)));
end
% xn=(1+xn)*xrange/2;%xe��õ�
% yn=(1+yn)*yrange/2;%�����ʼ��
xn=xn*xrange;%XY��õ�
yn=yn*yrange;%�����ʼ��

lightn=zeros(size(yn));
E=zeros(size(yn));
lighto=zeros(size(yn)); 
% ���������бȽϺ��ƶ�
for m=1:MaxGeneration
    for z=1:n
        sys(1)=xn(z);
        sys(2)=yn(z);
        E(z)=1/ze;
    end
    
    [lightn,index]=sort(E);
    xo=xn(index);
    yo=yn(index);
    lighto=lightn(index);
   
    yy=rand*2-1;
    p(1)=yy;
    for qq=2:n
%         p(qq)=cos(k*acos(p(qq-1)));%�б�ѩ�����ӳ��  
       p(qq)=1*p(qq-1)*(1-p(qq-1));%logistic����ӳ��
    end
    for pp=1:n
%         znx(pp)=xo(1)+p(pp)*(xo(n)-xo(1));
%         zny(pp)=yo(1)+p(pp)*(yo(n)-yo(1));
        znx(pp)=range(1)+p(pp)*xrange;
        zny(pp)=range(3)+p(pp)*yrange;
        hh=(MaxGeneration-m+1)/MaxGeneration;
        xe(pp)=(1-hh)*xo(pp)+hh*znx(pp);
        ye(pp)=(1-hh)*yo(pp)+hh*zny(pp);
        if xe(pp)>xo(pp)
            xo(pp)=xe(pp);
        end
        if ye(pp)>yo(pp)
            yo(pp)=ye(pp);
        end
    end %����ֲ���������
    
    for q=1:n
        fx=(lightn(q)-lighto(q))^2;
        sum=fx+sum;
    end
    lamda=(1/n)*sum;
    W=exp(-lamda/lamdat);
    lamdat=lamda;

    ni=size(yn,2);nj=size(yo,2);
    for i=1:ni
        for j=1:nj
            r=sqrt((xn(i)-xo(j))^2+(yn(i)-yo(j))^2);
            r1=rand;
            if r1>0.5
                Xm=xo(i)-0;
                Ym=yo(i)-0;
            else
                Xm=10-xo(i);
                Ym=1000-yo(i);
            end
            if lightn(i)<lighto(j)
                beta0=lighto(j);
                beta=beta0*exp(-gamma*r^2);
                xn(i)=h*(W*xn(i)+xo(j)*beta-xn(i)*beta+alpha*(r1-0.5)*Xm);
                yn(i)=h*(W*yn(i)+yo(j)*beta-yn(i)*beta+alpha*(r1-0.5)*Ym);
%             else
%                 xn(i)=h*(W*xn(i)+alpha*(r1-0.5)*Xm);
%                 yn(i)=h*(W*yn(i)+alpha*(r1-0.5)*Ym);
            end
        end
    end

    alpha=alpha*delta;
end
sys(1)=xo(n);
sys(2)=yo(n);


