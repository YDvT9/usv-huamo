
% ################################################################
% ##源自: 沈智鹏 著《船舶运动自适应滑模控制》 2019年科学出版社#######
% ##下载地址www.shenbert.cn/book/shipmotionASMC.html##############
% ###############################################################
function [sys,x0,str,ts]=chap4_3ctrl(t,x,u,flag)
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
sizes.NumContStates  = 183;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 12;
sizes.NumInputs      = 18;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = 0*ones(1,183);
str = [];
ts  = [0 0];
global b1 b2 b3 m1 m2 m3 
m1=0.6*[-30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
m2=0.6*[-30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
%     -0.01 -0.0095 -0.009 -0.0085 -0.008 -0.0075  -0.007 -0.0065 -0.006 -0.0055 -0.005 -0.0045 -0.004 -0.0035 -0.003 -0.0025 -0.002 -0.0015 -0.001 -0.0005 0 0.0005 0.001 0.0015 0.002 0.0025 0.003 0.0035 0.004 0.0045 0.005 0.0055 0.006 0.0065 0.007 0.0075 0.008 0.0085 0.009 0.0095 0.01];
% m3=[-0.30 -0.29 -0.28 -0.27 -0.26 -0.25 -0.24 -0.23 -0.22 -0.21 -0.2 -0.19 -0.18 -0.17 -0.16 -0.15 -0.14 -0.13 -0.12 -0.11 -0.10 -0.09 -0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30]; 
%     -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
% m3=[-20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
m3=0.01*[-30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];

b1=3;
b2=3;
b3=1;
% global b L 
% b=8;
% L=[-20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20;
%    -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20;
%    -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];

function sys=mdlDerivatives(t,x,u)
global b1 b2 b3 m1 m2 m3 

xd=8*t;%u(1)
yd=8*t;%u(2)
psid=0.01*t;%u(3)
% xd=500*sin(0.02*t+pi/4);%u(1)
% yd=500*cos(0.02*t+pi/4);%u(2)
% psid=0.01*t;%u(3)
ETAD=[xd;yd;psid];

xx=u(4);
y=u(5);
psi=u(6);
ETA=[xx;y;psi];
E1=ETA-ETAD;
ut=u(7);
v=u(8);
r=u(9);
VV=[ut;v;r];
Vd=[u(10);u(11);u(12)];

E2=VV-Vd;

h1=zeros(61,1);
for j=1:1:61
    h1(j)=exp(-norm(ut-m1(:,j))^2/(2*b1^2));
end
h2=zeros(61,1);
for j=1:1:61
    h2(j)=exp(-norm(v-m2(:,j))^2/(2*b2^2));
end
h3=zeros(61,1);
for j=1:1:61
    h3(j)=exp(-norm(r-m3(:,j))^2/(2*b3^2));
end
HH=[h1;h2;h3];

gama1=1*10^5;bb1=1*10^(-6);
for i=1:1:61
    W1=x(i);
    sys(i)=gama1*(-HH(i)*E2(1)-bb1*W1);
end
gama2=2*10^5;bb2=5*10^(-7);
for i=62:1:122
    W2=x(i);
    sys(i)=gama2*(-HH(i)*E2(2)-bb2*W2);
end
gama3=1*10^1;bb3=1*10^(-2);
for i=123:1:183
    W3=x(i);
    sys(i)=gama3*(-HH(i)*E2(3)-bb3*W3);
end

function sys=mdlOutputs(t,x,u)
global b1 b2 b3 m1 m2 m3 
xd=8*t;%u(1)
yd=8*t;%u(2)
psid=0.01*t;%u(3)
ETAD=[xd;yd;psid];
dxd=8;
dyd=8;
dpsid=0.01;
dETAD=[dxd;dyd;dpsid];
% xd=500*sin(0.02*t+pi/4);%u(1)
% yd=500*cos(0.02*t+pi/4);%u(2)
% psid=0.01*t;%u(3)
% ETAD=[xd;yd;psid];
% dxd=10*cos(0.02*t+pi/4);
% dyd=-10*sin(0.02*t+pi/4);
% dpsid=0.01;
% dETAD=[dxd;dyd;dpsid];

xx=u(4);
y=u(5);
psi=u(6);
ETA=[xx;y;psi];
ut=u(7);
v=u(8);
r=u(9);
VV=[ut;v;r];
Vd=[u(10);u(11);u(12)];
FAI1=[u(13);u(14);u(15)];
T=0.3;
dVd=1/T*(FAI1-Vd);
E1=ETA-ETAD;
E2=VV-Vd;

W1=[x(1) x(2) x(3) x(4) x(5) x(6) x(7) x(8) x(9) x(10) x(11) x(12) x(13) x(14) x(15) x(16) x(17) x(18) x(19) x(20) x(21) x(22) x(23) x(24) x(25) x(26) x(27) x(28) x(29) x(30) x(31) x(32) x(33) x(34) x(35) x(36) x(37) x(38) x(39) x(40) x(41) x(42) x(43) x(44) x(45) x(46) x(47) x(48) x(49) x(50) x(51) x(52) x(53) x(54) x(55) x(56) x(57) x(58) x(59) x(60) x(61)];
W2=[x(62) x(63) x(64) x(65) x(66) x(67) x(68) x(69) x(70) x(71) x(72) x(73) x(74) x(75) x(76) x(77) x(78) x(79) x(80) x(81) x(82) x(83) x(84) x(85) x(86) x(87) x(88) x(89) x(90) x(91) x(92) x(93) x(94) x(95) x(96) x(97) x(98) x(99) x(100) x(101) x(102) x(103) x(104) x(105) x(106) x(107) x(108) x(109) x(110) x(111) x(112) x(113) x(114) x(115) x(116) x(117) x(118) x(119) x(120) x(121) x(122)];
W3=[x(123) x(124) x(125) x(126) x(127) x(128) x(129) x(130) x(131) x(132) x(133) x(134) x(135) x(136) x(137) x(138) x(139) x(140) x(141) x(142) x(143) x(144) x(145) x(146) x(147) x(148) x(149) x(150) x(151) x(152) x(153) x(154) x(155) x(156) x(157) x(158) x(159) x(160) x(161) x(162) x(163) x(164) x(165) x(166) x(167) x(168) x(169) x(170) x(171) x(172) x(173) x(174) x(175) x(176) x(177) x(178) x(179) x(180) x(181) x(182) x(183)];
xi=[ut;v;r];

h1=zeros(61,1);
for j=1:1:61
    h1(j)=exp(-norm(ut-m1(:,j))^2/(2*b1^2));
end
h2=zeros(61,1);
for j=1:1:61
    h2(j)=exp(-norm(v-m2(:,j))^2/(2*b2^2));
end
h3=zeros(61,1);
for j=1:1:61
    h3(j)=exp(-norm(r-m3(:,j))^2/(2*b3^2));
end
HH=[h1;h2;h3];

epsilon1=1;
epsilon2=1;
epsilon3=0.1;
XI=diag([tanh(E2(1)/epsilon1),tanh(E2(2)/epsilon2),tanh(E2(3)/epsilon3)]);

% DGJ=[u(16);u(17);u(18)];
% Lambda=diag([1*10^(-6),1*10^(-6),1*10^(-8)]);
% D0=[0.1;0.1;0.1];
% CONG=diag([1*10^4,1*10^5,1*10^5]);
% dDGJ=CONG*(XI*E2-Lambda*(DGJ-D0));
DGJ=[u(16);u(17);u(18)];
Lambda=diag([1*10^(-7),1*10^(-7),1*10^(-9)]);
D0=[0.1;0.1;0.1];
CONG=diag([5*10^4,5*10^4,1*10^5]);
dDGJ=CONG*(XI*E2-Lambda*(DGJ-D0));

K2=diag([1*10^5;1*10^5;2*10^8]);

f1=W1*h1;
f2=W2*h2;
f3=W3*h3;
FF=[f1;f2;f3];

m11=5.3122*10^6;
m22=8.2831*10^6;
m23=0;
m33=3.7454*10^9;
M=[5.3122*10^6 0 0;0 8.2831*10^6 0;0 0 3.7454*10^9];
C=[0 0 -m22*v-m23*r;0 0 m11*ut;m22*v+m23*r -m11*ut 0];
D=[5.0242*10^4 0 0;0 2.7229*10^5 -4.3933*10^6;0 -4.3933*10^6 4.1894*10^8];
du=5.0242*10^4;
dv=2.7229*10^5;
dr=4.1894*10^8;
F=[0.2*du*ut^2+0.1*du*ut^3;0.2*dv*v^2+0.1*dv*v^3;0.2*dr*r^2+0.1*dr*r^3];

TAO=C*VV+D*VV+M*dVd+FF-K2*E2-XI*DGJ;

sys(1)=[1 0 0]*TAO;
sys(2)=[0 1 0]*TAO;
sys(3)=[0 0 1]*TAO;
sys(4)=[1 0 0]*FF;
sys(5)=[0 1 0]*FF;
sys(6)=[0 0 1]*FF;
sys(7)=W1*W1.';
sys(8)=W2*W2.';
sys(9)=W3*W3.';
sys(10)=[1 0 0]*dDGJ;
sys(11)=[0 1 0]*dDGJ;
sys(12)=[0 0 1]*dDGJ;


