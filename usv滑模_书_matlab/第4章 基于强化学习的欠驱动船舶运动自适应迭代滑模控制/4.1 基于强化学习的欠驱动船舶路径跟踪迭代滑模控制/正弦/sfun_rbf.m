%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Դ��: ������ ���������˶�����Ӧ��ģ���ơ� 2019���ѧ������
%%���ص�ַwww.shenbert.cn/book/shipmotionASMC.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sys,x0,str,ts] = sfun_rbf(t,x,u,flag)

switch flag,
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
     case 1,
    sys=mdlDerivatives(t,x,uss);
%   case 2,
%     sys=mdlUpdate(t,x,u);
  case 3,
    sys=mdlOutputs(t,x,u);
  case {2,4,9}
    sys=[];
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end
 

 function [sys,x0,str,ts]=mdlInitializeSizes
 
 sizes = simsizes;
 sizes.NumContStates  = 0;
 sizes.NumDiscStates  = 1;
 sizes.NumOutputs     = 2;
 sizes.NumInputs      = 3;  % ����ʵ��λ�õ�x��y��;
 sizes.DirFeedthrough = 1;
 sizes.NumSampleTimes = 1;   
 x0=[15];
 str = [];
 ts  = [0 0];
 sys = simsizes(sizes);

 
function sys=mdlDerivatives(t,x,uss)

sys=[];

function sys=mdlOutputs(t,x,u)
global xt yt ye ymax c h b dw
xt=u(2); yt=u(3);
ymax=400;
e=yt-200*sin(3.14*xt/2500);
ye=(e)/ymax;%ΪʲôҪ��ymax��������
c=abs(ye);
h=[1 1 1 1 1 1 1 1 1 1];
w=[1 1 1 1 1 1 1 1 1 1];
cj=[-1 -0.75 -0.5  -0.3 0 0.2 0.3 0.5  0.75 1];
b=2;
for i=1:1:10
    h(i)=exp(-norm(c-cj(i))^2/2*b^2);%hΪ��˹������(�����)�����
end
% Ȩ��W��ǿ��ѧϰ������,hΪ������Ϊʽ4.1.29��hǰϵ��Ϊʵ������ֱ�������˾���(����)��
% u(1)�Ƕ����������M����Ϊ(n)delay time=50!!!
dw=0.1*h*(u(1)-2)/2;
%dw=0.1*(u(1)-2)/2*h;����Ч��һ�� �����ǲ�Ӧ�������������𣿣���
% dw=0.5*h(i)*(M-1)/1Ϊǿ��ѧϰ������Ȩ��W�ĸ�����(ʽ4.1.29)���������������c��b��ǿ��ѧϰ������Ҳûд
% �������dc��dbҪ�����㣬��Ϊc��b�����е�Ԫ�ز�һ��������
w=w+dw;
sys(1)=h*w';%��ʽ4.1.17�Ļ�ģ�淴������k5
sys(2)=ye*ymax;