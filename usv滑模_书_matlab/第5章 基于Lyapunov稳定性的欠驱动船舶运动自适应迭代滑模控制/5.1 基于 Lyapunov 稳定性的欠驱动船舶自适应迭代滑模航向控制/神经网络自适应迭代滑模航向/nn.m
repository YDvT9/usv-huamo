%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Դ��: ������ ���������˶�����Ӧ��ģ���ơ� 2019���ѧ������
%%���ص�ַwww.shenbert.cn/book/shipmotionASMC.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts]=npd1(t,x,u,flag)
switch flag,
case 0,
[sys,x0,str,ts]=mdlInitializeSizes;
case 2,
sys=mdlUpdates(x,u);
case 3,
sys=mdlOutputs(t,x,u);
case {1,4,9}
sys=[];
otherwise
error(['Unhandled flag=',num2str(flag)]);
end;
%��ʼ���ӳ���
function[sys,x0,str,ts]=mdlInitializeSizes
sizes=simsizes; %����size���ݽṹ
sizes.NumContStates=0; %����״̬��
sizes.NumDiscStates=3; %��ɢ״̬��
sizes.NumOutputs=4; %���������
sizes.NumInputs=7; %����������e(k)����e(k)�� ��2e(k) sgm4 dsgm4 sgm4d dsgm4d
sizes.DirFeedthrough=1; %�Ƿ���ڴ���ѭ��(1һ����)
sizes.NumSampleTimes=1; %����ʱ�����
sys=simsizes(sizes); %����size���ݽṹ����������Ϣ
x0=[0;0;0]; %���ó�ֵ״̬
str=[]; %�����������ÿ�
ts=[-1 0]; %����ʱ�� 
% when flag=2��updates the diserete states
function sys =mdlUpdates(x,u)
 T=1;
sys=[u(1);
(u(1)-u(2))/T;
   1];

% when flag=3��computates the output signals
function sys=mdlOutputs(t,x,u)
persistent wkpl_1 wkil_1 wkdl_1  ul_1 

 xite=0.5;
 D=10000;
  a=100;b=0.1;
% kl=0.001*(a+b*u(1));
 kl=0.1;
if t==0 %Initilizing kp,ki and kd
wkpl_1=0.1;
wkil_1=0.1;
wkdl_1=0.1;
ul_1=0;
end

wkpl=wkpl_1-xite*kl*(u(5)+D*u(4))*(u(7)+D*u(6))*x(1);%P
wkdl=wkdl_1-xite*kl*(u(5)+D*u(4))*(u(7)+D*u(6))*x(2);%D
wkil=wkil_1-xite*kl*(u(5)+D*u(4))*(u(7)+D*u(6))*x(3);%1

waddl=abs(wkpl)+abs(wkil)+abs(wkdl);
wlll=wkpl/waddl;
wl22=wkdl/waddl;
wl33=wkil/waddl;
wl=[wlll,wl22,wl33];

ul=kl*wl*x;

wkpl_1=wkpl;
wkdl_1=wkdl;
wkil_1=wkil;
ul_1=ul;
sys(1)=ul;
sys(2)=wlll;
sys(3)=wl22;
sys(4)=wl33;