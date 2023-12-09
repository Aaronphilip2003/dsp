close all
clear;  
clc;


N1 = 4;

x1 = input('Enter 1st sequence of length 4: ');
x2 = input('Enter 2nd sequence of length 4: ');

for n=1:N1
       y1(n)=0;
       for i=1:N1
           j=n-i+1;
           if j<1
               j=N1+j;
           end
       y1(n) = y1(n)+x1(i)*x2(j);
       end
end
disp('The resultant sequence is y1(n): ');
y1

y3 = conv(x1, x2);
y3 = [y3, 0];

y1 = [y1, zeros(1, 4)];

z1=y1-y3;
disp('z1');
disp(z1')

x1 = [x1, zeros(1,4)];
x2 = [x2, zeros(1,4)]; 
    
N2 = 8;

for n=1:N2
    y2(n)=0;
    for i=1:N2
        j=n-i+1;
        if j<1
            j=N2+j;
        end
        y2(n) = y2(n) + x1(i)*x2(j);
    end
end
disp("The resultant sequence y2(n) is: ");
y2

z2 = y2-y3;

disp('z2');
disp(z2');
