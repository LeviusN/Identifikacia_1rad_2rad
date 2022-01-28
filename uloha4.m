clear all, clc, close all;
y=load('data417.mat');%g,h,t
%%
figure(1)
plot(y.t,y.g)
hold on
figure(2)
plot(y.t,y.h)

Tvz=y.t(3)-y.t(2);

M0=sum(y.h*Tvz);
M1=sum(y.t*y.h*Tvz);
M2=sum(y.t.^2*y.h*Tvz);
M3=sum(y.t.^3*y.h*Tvz);

%% S nulou
M=[0 0 1 0;
    M0 0 0 -1;
   -M1 M0 0 0;
    M2/2 -M1 0 0];
m=[M0 M1 -M2/2 M3/6]';
theta=inv(M)*m;

s=tf('s');
F1=(theta(4)/1.2*s+theta(3))/(theta(2)*s^2+theta(1)*s+1)
[ys1,ts1]=step(F1);
[yi1,ti1]=impulse(F1);

%% Bez nuly

M=[0 0 1;
    M0 0 0;
   -M1 M0 0;
   M2/2 -M1 0];
m=[M0 M1 -M2/2 M3/6]';
theta=pinv(M)*m;


s=tf('s');
F2=(theta(3))/(theta(2)*s^2+theta(1)*s+1)
[ys2,ts2]=step(F2);
[yi2,ti2]=impulse(F2);

%% Plot
figure(1)
plot(ts1,ys1)
hold on
plot(y.t,y.g)
title('Step s nulou')
xlabel('cas')
ylabel('amplituda')
legend('estimovane','namerane')

figure(2)
plot(ti1,yi1)
hold on 
plot(y.t,y.h)
title('Impuls s nulou')
xlabel('cas')
ylabel('amplituda')
legend('estimovane','namerane')

figure(3)
plot(ts2,ys2)
hold on
plot(y.t,y.g)
title('Step bez nulou')
xlabel('cas')
ylabel('amplituda')
legend('estimovane','namerane')

figure(4)
plot(ti2,yi2)
hold on
plot(y.t,y.h)
title('Impuls bez nuly')
xlabel('cas')
ylabel('amplituda')
legend('estimovane','namerane')
