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
sizes.NumContStates  = 366;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 18;
sizes.NumInputs      = 21;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = 0*ones(1,366);
str = [];
ts  = [0 0];
global b L 
% l1=0.6*[-30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
% l2=0.6*[-10 -9.5 -9 -8.5 -8 -7.5 -7 -6.5 -6 -5.5 -5 -4.5 -4 -3.5 -3 -2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15 15.5 16 16.5 17 17.5 18 18.5 19 19.5 20];
% l3=0.06*[-30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
% l4=0.006*[-10 -9.5 -9 -8.5 -8 -7.5 -7 -6.5 -6 -5.5 -5 -4.5 -4 -3.5 -3 -2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15 15.5 16 16.5 17 17.5 18 18.5 19 19.5 20];
% L=[l1;l1;l2;l3;l3;l4];
l1=[-30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
l2=[-10 -9.5 -9 -8.5 -8 -7.5 -7 -6.5 -6 -5.5 -5 -4.5 -4 -3.5 -3 -2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15 15.5 16 16.5 17 17.5 18 18.5 19 19.5 20];
l3=[-30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
l4=[-10 -9.5 -9 -8.5 -8 -7.5 -7 -6.5 -6 -5.5 -5 -4.5 -4 -3.5 -3 -2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15 15.5 16 16.5 17 17.5 18 18.5 19 19.5 20];
L=[l1;l1;l2;l1;l1;l2;l3;l3;l4];
% L=0.6*[-30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30;
%    -30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30;
%    -10 -9.5 -9 -8.5 -8 -7.5 -7 -6.5 -6 -5.5 -5 -4.5 -4 -3.5 -3 -2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15 15.5 16 16.5 17 17.5 18 18.5 19 19.5 20;
%    -30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30;
%    -30 -29 -28 -27 -26 -25 -24 -23 -22 -21 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30;
%    -10 -9.5 -9 -8.5 -8 -7.5 -7 -6.5 -6 -5.5 -5 -4.5 -4 -3.5 -3 -2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15 15.5 16 16.5 17 17.5 18 18.5 19 19.5 20];

b=15;


function sys=mdlDerivatives(t,x,u)
global b L 
xd=500*sin(0.02*t+pi/4);%u(1)
yd=500*(1-cos(0.02*t+pi/4));%u(2)
psid=0.01*t;%u(3)
ETAD=[xd;yd;psid];

xx=u(4);
y=u(5);
psi=u(6);
ETA=[xx;y;psi];
JT=[cos(psi) sin(psi) 0;-sin(psi) cos(psi) 0;0 0 1];
S1=JT*(ETA-ETAD);
ut=u(7);
v=u(8);
r=u(9);
VV=[u(7);u(8);u(9)];
Vd=[u(10);u(11);u(12)];
vd1=[1 0 0]*Vd;
vd2=[0 1 0]*Vd;
vd3=[0 0 1]*Vd;
FAI1=[u(13);u(14);u(15)];
VG=[u(19);u(20);u(21)];
utg=u(19);
vg=u(20);
rg=u(21);
E2=VV-Vd;
E2G=VG-Vd;
C1=diag([0.08,0.08,1]);
S2=C1*S1+E2;
S2G=C1*S1+E2G;
T=0.3;
dVd=1/T*(FAI1-Vd);
dvd1=[1 0 0]*dVd;
dvd2=[0 1 0]*dVd;
dvd3=[0 0 1]*dVd;

xi=[utg;vg;rg;vd1;vd2;vd3;dvd1;dvd2;dvd3];
h=zeros(61,1);
for j=1:1:61
    h(j)=exp(-norm(xi-L(:,j))^2/(2*b^2));
end
HH=[h;h;h];

% gama1=1*10^6;bb1=5*10^(-7);
% for i=1:1:61
%     W1=x(i);
%     sys(i)=gama1*(-HH(i)*S2G(1)-bb1*W1);
% end
% gama2=1*10^6;bb2=5*10^(-7);
% for i=62:1:122
%     W2=x(i);
%     sys(i)=gama2*(-HH(i)*S2G(2)-bb2*W2);
% end
% gama3=1*10^8;bb3=5*10^(-9);
% for i=123:1:183
%     W3=x(i);
%     sys(i)=gama3*(-HH(i)*S2G(3)-bb3*W3);
% end
gama1=1*10^6;bb1=1*10^(-6);
for i=1:1:61
    W1=x(i);
    W1f=x(i+183);
    sys(i)=gama1*(-HH(i)*S2G(1)-bb1*(W1-W1f));
    sys(i+183)=0.03*(W1-W1f);
end
gama2=1*10^6;bb2=1*10^(-6);
for i=62:1:122
    W2=x(i);
    W2f=x(i+183);
    sys(i)=gama2*(-HH(i)*S2G(2)-bb2*(W2-W2f));
    sys(i+183)=0.03*(W2-W2f);
end
gama3=1*10^8;bb3=1*10^(-8);
for i=123:1:183
    W3=x(i);
    W3f=x(i+183);
    sys(i)=gama3*(-HH(i)*S2G(3)-bb3*(W3-W3f));
    sys(i+183)=0.03*(W3-W3f);
end

function sys=mdlOutputs(t,x,u)
global b L 
xd=500*sin(0.02*t+pi/4);%u(1)
yd=500*(1-cos(0.02*t+pi/4));%u(2)
psid=0.01*t;%u(3)
ETAD=[xd;yd;psid];

xx=u(4);
y=u(5);
psi=u(6);
ETA=[xx;y;psi];
JT=[cos(psi) sin(psi) 0;-sin(psi) cos(psi) 0;0 0 1];
S1=JT*(ETA-ETAD);
ut=u(7);
v=u(8);
r=u(9);
VV=[u(7);u(8);u(9)];
Vd=[u(10);u(11);u(12)];
vd1=[1 0 0]*Vd;
vd2=[0 1 0]*Vd;
vd3=[0 0 1]*Vd;
FAI1=[u(13);u(14);u(15)];
VG=[u(19);u(20);u(21)];
utg=u(19);
vg=u(20);
rg=u(21);
E2=VV-Vd;
E2G=VG-Vd;
C1=diag([0.08,0.08,1]);
S2=C1*S1+E2;
S2G=C1*S1+E2G;
T=0.3;
dVd=1/T*(FAI1-Vd);
dvd1=[1 0 0]*dVd;
dvd2=[0 1 0]*dVd;
dvd3=[0 0 1]*dVd;
RT=[0 r 0;-r 0 0;0 0 0];
dxd=10*cos(0.02*t+pi/4);
dyd=10*sin(0.02*t+pi/4);
dpsid=0.01;
dETAD=[dxd;dyd;dpsid];
dS1=RT*S1+VV-JT*dETAD;
xi=[utg;vg;rg;vd1;vd2;vd3;dvd1;dvd2;dvd3];
h=zeros(61,1);
for j=1:1:61
    h(j)=exp(-norm(xi-L(:,j))^2/(2*b^2));
end

W1=[x(1) x(2) x(3) x(4) x(5) x(6) x(7) x(8) x(9) x(10) x(11) x(12) x(13) x(14) x(15) x(16) x(17) x(18) x(19) x(20) x(21) x(22) x(23) x(24) x(25) x(26) x(27) x(28) x(29) x(30) x(31) x(32) x(33) x(34) x(35) x(36) x(37) x(38) x(39) x(40) x(41) x(42) x(43) x(44) x(45) x(46) x(47) x(48) x(49) x(50) x(51) x(52) x(53) x(54) x(55) x(56) x(57) x(58) x(59) x(60) x(61)];
W2=[x(62) x(63) x(64) x(65) x(66) x(67) x(68) x(69) x(70) x(71) x(72) x(73) x(74) x(75) x(76) x(77) x(78) x(79) x(80) x(81) x(82) x(83) x(84) x(85) x(86) x(87) x(88) x(89) x(90) x(91) x(92) x(93) x(94) x(95) x(96) x(97) x(98) x(99) x(100) x(101) x(102) x(103) x(104) x(105) x(106) x(107) x(108) x(109) x(110) x(111) x(112) x(113) x(114) x(115) x(116) x(117) x(118) x(119) x(120) x(121) x(122)];
W3=[x(123) x(124) x(125) x(126) x(127) x(128) x(129) x(130) x(131) x(132) x(133) x(134) x(135) x(136) x(137) x(138) x(139) x(140) x(141) x(142) x(143) x(144) x(145) x(146) x(147) x(148) x(149) x(150) x(151) x(152) x(153) x(154) x(155) x(156) x(157) x(158) x(159) x(160) x(161) x(162) x(163) x(164) x(165) x(166) x(167) x(168) x(169) x(170) x(171) x(172) x(173) x(174) x(175) x(176) x(177) x(178) x(179) x(180) x(181) x(182) x(183)];

K2=diag([1*10^5,1*10^5,1*10^7]);

f1=W1*h;
f2=W2*h;
f3=W3*h;
FF=[f1;f2;f3];
epsilon1=1;
epsilon2=1;
epsilon3=0.1;
XI=diag([tanh(S2G(1)/epsilon1),tanh(S2G(2)/epsilon2),tanh(S2G(3)/epsilon3)]);
DGJ=[u(16);u(17);u(18)];

Lambda=diag([1*10^(-8),1*10^(-8),1*10^(-11)]);
D0=[0.1;0.1;0.1];
CONG=diag([3*10^3,3*10^3,3*10^6]);
dDGJ=CONG*(XI*S2G-Lambda*(DGJ-D0));
m11=5.3122*10^6;
m22=8.2831*10^6;
m23=0;
m33=3.7454*10^9;
M=[5.3122*10^6 0 0;0 8.2831*10^6 0;0 0 3.7454*10^9];
C=[0 0 -m22*v-m23*r;0 0 m11*ut;m22*v+m23*r -m11*ut 0];
du=5.0242*10^4;
dv=2.7229*10^5;
dr=4.1894*10^8;
D=[5.0242*10^4 0 0;0 2.7229*10^5 -4.3933*10^6;0 -4.3933*10^6 4.1894*10^8];
DDD=[1*10^5*(sin(0.2*t)+cos(0.5*t));1*10^5*(sin(0.1*t)+cos(0.4*t));1*10^6*(sin(0.5*t)+cos(0.3*t))];
J=[cos(psi) -sin(psi) 0;sin(psi) cos(psi) 0;0 0 1];
FFS=C*VV+D*VV+M*dVd-M*C1*dS1;
TAO=FF-K2*S2G-S1-XI*DGJ;
% TAO=FF-K2*S2-S1;
sys(1)=[1 0 0]*TAO;
sys(2)=[0 1 0]*TAO;
sys(3)=[0 0 1]*TAO;
sys(4)=[1 0 0]*FF;
sys(5)=[0 1 0]*FF;
sys(6)=[0 0 1]*FF;
sys(7)=[1 0 0]*FFS;
sys(8)=[0 1 0]*FFS;
sys(9)=[0 0 1]*FFS;
sys(10)=[1 0 0]*dDGJ;
sys(11)=[0 1 0]*dDGJ;
sys(12)=[0 0 1]*dDGJ;
sys(13)=[1 0 0]*DDD;
sys(14)=[0 1 0]*DDD;
sys(15)=[0 0 1]*DDD;
sys(16)=[1 0 0]*XI*DGJ;
sys(17)=[0 1 0]*XI*DGJ;
sys(18)=[0 0 1]*XI*DGJ;


