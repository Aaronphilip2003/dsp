#include <stdio.h>
int main()
{
int x[15] = {0};
int h[15] = {0};
int y[15] = {0};
int N,L,K,i,j = 0;
printf("Enter the length of h(n): ");
scanf("%d",&N);
printf("Enter the length of x(n): ");

scanf("%d",&L);
K=N+L-1;
printf("Enter the values of h(n)");
for(i=0;i<N;i++)
{
scanf("%d",&h[i]);
}
printf("Enter the values of x(n)");
for(j=0;j<L;j++)
{
scanf("%d",&x[j]);
}

// padding of zeros to make lengths of h(n) and x(n) equal to K = N+M-1

for(i=N;i<=K;i++)
{
h[i]=0;
}
for(i=L;i<=K;i++)
{
x[i]=0;

}

// linear convolution of h(n) and x(n)

for(i=0;i<K;i++)
{
y[i]=0;

for(j=0;j<=i;j++)
{
y[i]=y[i]+((h[j])*(x[i-j]));
}
}

printf("\nLinear convolution output is:");

for(i=0;i<=K;i++)

{
printf("\n y(%d) = %d",i,y[i]);
}

while(1);
}
