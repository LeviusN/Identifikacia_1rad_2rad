clear all, clc, close all;

yw=load('data317.mat');%y,t
plot(yw.t,yw.y)

%% Strejcova metoda
% hladanie bodov Tus a Tn
%tangenciala
y1=0.5085;
index_max=7;
y2=0.8263;
index_min=9;
t2=yw.t(index_min);
t1=yw.t(index_max);
hold on
grid on
plot(t1,y1,'*')
t=t2-t1;
y=y2-y1;
s=y/t;
x=0.1:0.001:0.8;
y=s*x-0.45;
plot(x,y)

%priesecnik
xh=0:0.001:yw.t(end);
yh=ones(1,length(xh)).*yw.y(end);
plot(xh,yh)

%hodnota Tn a Tus
Tus=0.142;
Tn=0.708-Tus;

%algoritmus
K=yw.y(end);
fs=Tus/Tn;
fo=0.218;
go=0.271;
D=(fs-fo)*Tn;
T=Tn*go;

s=tf('s');
F=(K/(1+s*T)^3)*exp(-D*s)
[y1s,t1s]=step(F,yw.t(end));
%% Broidova

K=yw.y(end);
fs=Tus/Tn
fo=0.192;
go=0.440;
D=(fs-fo)*Tn;
T=Tn*go;

s=tf('s');
F=(K/((1+s*T/1)*(1+s*T/2)*(1+s*T/3)))*exp(-D*s)
[y2s,t2s]=step(F,yw.t(end));

%% Plot
figure(2)
plot(yw.t,yw.y)% skutek utek
hold on
plot(t1s,y1s) % Strejc
plot(t2s,y2s) % Broid
legend('real','Strejcova metoda','Broidova metoda')
title('Uloha 3')
xlabel('cas')
ylabel('vystup')