clc
clear all

%For system 1.3 and 1.2

syms x k1 k2 theta t m y(t) n k; %initialization

Q = x^2 +2*x + 1 ==0;  			%equation of Q(D) in terms of x    
								%change Q to x(x+1) for system 1.2
A = solve(Q);
W = 0;

%To find zero input response


if A(1) == A(2)
    %case = 1;
    y(t) = (k1+k2*t)*exp(A(1)*t);
    Dy(t) = diff(y(t));
    m = y(0) == 0;
    n = Dy(0) == 1;
    R = solve(m,n);
    y(t) = (R.k1+R.k2.*t).*exp(A(1).*t);
elseif isreal(A)
    %case = 2;
    y(t) = k1.*exp(A(1).*t)+k2.*exp(A(2).*t);
    Dy(t) = diff(y(t));
    m = y(0) == 0;
    n = Dy(0) == 1;
    R = solve(m,n);
    y(t) = R.k1.*exp(A(1).*t)+R.k2.*exp(A(2).*t);
else
    %case = 3;
    a = (A(1) + A(2))/2;
    b = abs((A(1) - A(2))/2i);
    y(t) = k.*exp(a.*t).*cos(b.*t + theta);
    Dy(t) = diff(y(t));
    m = y(0) == 0;
    n = Dy(0) == 1;
    R = solve(m,n);
    y(t) = R.k.*exp(a.*t).*cos(b.*t + R.theta);
    
end


%to declare unit step function

o = (-1:0.01:10);
u = o>=0;

%plot(u); 						%to plot unit step function to crosscheck



%to find impulse response h(t). As P(D) = D and b0=0 = >
e = [-1:0.01:10];
m(t)= diff(y(t));
q = double(subs(m(t),t,e));



t = [-1:0.01:10];

%hold on;
%plot(t,y(t));


input = u;      				%input entered by user
h = q.*u;   
%plot(t,h); 					%to display impulse response

%to find output


f = conv(h,input);    			%convolution using conv prebuilt funtion to find output
%plot(f);



%convolution using self made funtion to find output


x = input;

m=length(x);
n=length(h);
X=[x,zeros(1,n)];
H=[h,zeros(1,m)];
for i=1:n+m-1
    Y(i)=0;
    for j=1:m
        if(i-j+1>0)
            Y(i)=Y(i)+(X(j)*H(i-j+1));
        else
        end
    end
end
hold on;





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

