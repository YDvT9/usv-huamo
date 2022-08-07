function [sys,x0,str,ts]=low_filter(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[0 0 0];
str=[];
ts=[0 0];
function sys=mdlDerivatives(t,x,u)
T=0.3;
FAI1=[u(1);u(2);u(3)];

XX=[x(1);x(2);x(3)];
sys(1)=[1 0 0]*1/T*(FAI1-XX);
sys(2)=[0 1 0]*1/T*(FAI1-XX);
sys(3)=[0 0 1]*1/T*(FAI1-XX);

function sys=mdlOutputs(t,x,u)
sys=x;  %Xd