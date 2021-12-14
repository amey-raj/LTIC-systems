clc
clear

%For system 1.1

syms y x y(t) %initialization
W = 3; %value of b0
M = x + 2 == 0; %equation of Q(D) in terms of x
%To find zero input response

A = solve(M);
if length(A) < 2
    y(t) = exp(A(1)*t);
end

%As P(D) = 3D+5 = >
e = (-1:0.01:10);
m(t)= 3*diff(y(t)) + 5*y(t);
q = double(subs(m(t),t,e));
%initializing unit impulse and unit step function
t = (-1:0.01:10);
impulse = t==0;
u = t>=0;
%to find impulse response h(t). As b0=3 = >
input = u; %input entered by user
h = W*impulse + q.*u;
x = input;

%convolution using self made funtion to find output

m=length(x);
n=length(h);
X=[x,zeros(1,n)];
H=[h,zeros(1,m)];
for i=1:n+m-1
    Y(i)=0;
    for j=1:m
        if(i-j+1>0)
            Y(i)=Y(i)+X(j)*H(i-j+1);
        else
            end

    end
end

%to plot both output and unit impulse response

figure(1); %to plot output
plot(Y,'b'); xlim([-1,2500]);
pos1 = get(gcf,'Position');

% get position of Figure(1)

set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0])

% Shift position of Figure(1)

figure(2);

%to plot unit impulse response

plot(t,h,'r'); xlim([-0.1,2.5]);
set(gcf,'Position', get(gcf,'Position') + [0,0,150,0]);

% When Figure(2) is not the same size as Figure(1)

pos2 = get(gcf,'Position');

% get position of Figure(2)

set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0])

% Shift position of Figure(2)