clear all, clc, close all;

%% Uloha 1
yw=load('data117.mat');%y,t
yw.y=yw.y-64.73;
%% metoda1
K=yw.y(end);
T=(yw.t(200)-yw.t(100))/log((K-yw.y(100))/(K-yw.y(200)));
x=log((K-yw.y(100))/K)/log((K-yw.y(200))/K);
D=(yw.t(200)*x-yw.t(100))/(x-1);

%Test
s=tf('s');
%S oneskorenim
%F1=((K/(1+T*s))*exp(-D*s))+64.73;
%bez eneskorenia
F1=((K/(1+T*s)))%+64.73
F1=F1+64.73
[y1s,t1s]=step(F1,yw.t(end));


%% metoda2
y1_03=0.33*(yw.y(end)-yw.y(1))+yw.y(1);
y2_07=0.7*(yw.y(end)-yw.y(1))+yw.y(1);
%identifikacia t
xt=0:0.001:5;
l=length(xt);
y1_03=ones(1,l).*y1_03;
y2_07=ones(1,l).*y2_07;
figure(1)
plot(yw.t,yw.y)
hold on
plot(xt,y1_03)
plot(xt,y2_07)
s=find(yw.y==yw.y(end));

%algoritmus
K=yw.y(end);
t1_03=0.763;
t2_07=1.121;
T=1.245*(t2_07-t1_03);
D=1.498*t1_03-.498*t2_07;

%Test
s=tf('s');
%s oneskorenim
%F2=K*exp(-D*s)/(1+T*s)+64.73;
%bez oneskorenia
F2=K/(1+T*s)%+64.73
F2=F2+64.73
[y2s,t2s]= step(F2,yw.t(end));

%% metoda3
y1_04=0.4*(yw.y(end)-yw.y(1))+yw.y(1);
y2_02=0.28*(yw.y(end)-yw.y(1))+yw.y(1);
%identifikacia t
xt=0:0.001:5;
l=length(xt);
y1_04=ones(1,l).*y1_04;
y2_02=ones(1,l).*y2_02;
figure(2)
plot(yw.t,yw.y)
hold on
plot(xt,y1_04)
plot(xt,y2_02)

%algoritmus
t1_04=0.82;
t2_02=0.732;
K=yw.y(end);
T=5.5*(t1_04-t2_02);
D=2.8*t2_02-1.8*t1_04;

%s oneskorenim
%F3=K*exp(-D*s)/(1+T*s)+64.73;
%bez oneskorenia
F3=K/(1+T*s)%+64.73
F3=F3+64.73
[y3s,t3s]= step(F3,yw.t(end));
%% metoda4
%algoritmus
K=yw.y(end);
t1_03=0.763;
t2_07=1.121;
T=0.794*(t2_07-t1_03);
D=1.937*t1_03-.937*t2_07;

% s oneskorenim
%F4=K/(1+T*s)^2*exp(-D*s)+64.73;
%bez oneskorenia
F4=K/(1+T*s)^2%+64.73
F4=F4+64.73
[y4s,t4s]=step(F4,yw.t(end));
%% metoda5
figure(3)
hold on
grid on
plot(yw.t,yw.y+64.73)
y=yw.y(75:76)+64.73;
x=yw.t(75:76);
slope=diff(y)./diff(x);
t=0.5:0.01:1.3;
p=slope*t-5.5;
plot(t,p+64.73)
%hore horizontal
t_h=0:0.01:6;
y_h=ones(1,length(t_h))*yw.y(end)+64.73;
plot(t_h,y_h)
%dole horizontal
y_d=ones(1,length(t_h))*yw.y(1)+64.73;
plot(t_h,y_d)

Tu=0.55-0.5;
Tn=1.19-0.55;

%algoritmus
K=yw.y(end);
f1=Tn/Tu; %12.8
f2=1.495;
k=0.2;
T1=Tn/f2;
T2=k*T1;

%F5=K/((T1*s+1)*(T2*s+1))*exp(-D*s)+64.73
F5=K/((T1*s+1)*(T2*s+1))%+64.73
F5=F5+64.73
[y5s,t5s]=step(F5,yw.t(end));
%% PLot T*s+1

figure(4)
plot(yw.t(55:end)-0.5,yw.y(55:end)+64.73,'Linewidth',1.5)
hold on
plot(t1s,y1s) % metoda 1
plot(t2s,y2s) % metoda 2
plot(t3s,y3s) % metoda 3
plot(t4s,y4s) % metoda 4
plot(t5s,y5s) % metoda 5

title('Uloha2')
xlabel('èas')
ylabel('vystup')
legend('real','model1','model2','model3','model4','model5')

% t = (0.5:0.1:4)';
% plot(t+0.6,y)
% plot(yw.t,yw.y+64.73,'r')
% legend('model','system')







