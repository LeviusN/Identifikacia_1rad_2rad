clear all, clc,close all;
%% Uloha2
yw=load('data217.mat');%y,t
%% metoda1

%Parametre y a t
y1=max(yw.y);
index_max=find(yw.y==y1);
y2=min(yw.y(index_max : end));
index_min=find(yw.y==y2);
t2=yw.t(index_min);
t1=yw.t(index_max);

% algoritmus
K=yw.y(end);
M=(y1-y2)/y1;
th=abs(log(M)/sqrt(pi^2+log(M)^2));
omega=pi/((t2-t1)*sqrt(1-th^2));
T=1/omega;

% test
s=tf('s');
F1=K*omega^2/(s^2+2*omega*th*s+omega^2)
[y1s,t1s]=step(F1,yw.t(end));

%% metoda2
y1max=max(yw.y);
index_max=find(yw.y==y1max);
y2max=max(yw.y(index_min : end));
index_max2=find(yw.y==y2max);
t2max=yw.t(index_max2);
t1max=yw.t(index_max);
% plot(y2,'*')

K=yw.y(end);
c=1/pi*log(y1max/K-1);
th=-c/sqrt(1+c^2);
d_t=t2max-t1max;
T=d_t/(2*pi*sqrt(1+c^2));
omega=1/T;

s=tf('s');
F2=K*omega^2/(s^2+2*omega*th*s+omega^2)
%F=K/(T^2*s^2+2*th*T*s+1)
[y2s,t2s]=step(F2,yw.t(end));

%% metoda3
y_p=sum(yw.y(65:end));
dlzka=length(yw.y(65:end));
y_priemer=y_p/dlzka

K=y_priemer+0.01;
A1=y1max-K;
A2=y2max-K;
delta=A1/A2;
th=log(delta)/sqrt((log(delta))^2+4*pi^2);
T=d_t/(2*pi)*sqrt(1-th^2);
omega=1/T;

s=tf('s');
F3=K*omega^2/(s^2+2*omega*th*s+omega^2)
%F=K/(T^2*s^2+2*th*T*s+1)
[y3s,t3s]=step(F3,yw.t(end));

%% metoda4
a1=y1-y2;
a2=0.8911-y2;
t1a=0.64;
t2a=1.28;
t3a=1.96;
n=2;
% 
K=yw.y(end);
th=-log(a2/a1)/(sqrt(pi^2+(log(a2/a1))^2));
T=(1/(pi*n)*(t3a-t1a))*sqrt(1-th^2);
D=1/2*(t1a+t2a)-3/4*(t3a-t1a);

s=tf('s');
F4=K/(T^2*s^2+2*th*T*s+1)*exp(D*s)
[y4s,t4s]=step(F4,yw.t(end));
%% PLot

plot(yw.t,yw.y)
hold on
plot(t1s,y1s)
plot(t2s,y2s)
plot(t3s,y3s)
plot(t4s,y4s)

title('Uloha2')
xlabel('èas')
ylabel('vystup')
legend('real','model1','model2','model3','model4')
