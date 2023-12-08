#include <stdio.h>

int main(void)
{
int x[15] = {0};
int h[15] = {0};
int a[15] = {0};
int p[15] = {0};
int y[15] = {0};
int N,L,k,i,j = 0;
printf("Enter the length of h(n): ");
scanf("%d",&N);
printf("Enter the length of x(n): ");
scanf("%d",&L);
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
// padding of zeros to make lengths of h(n) and x(n) equal
to that of the larger sequence

if(N-L!=0) // if length of both
sequences are not equal
{
if(L>N) // pad the smaller
sequence with zeros
{
for(i=N;i<L;i++)
h[i]=0;
N=L;

}
for(i=L;i<N;i++)
x[i]=0;
L=N;

}
// Circular convolution of h(n) and x(n)
y[0]=0;
a[0]=h[0];
for(j=1;j<N;j++) // folding h(n) to h(-n)
a[j]=h[N-j];
for(i=0;i<N;i++) // obtain first output value
y(0)
y[0]+=x[i]*a[i];
for(k=1;k<N;k++) // obtain remaining output
values
{
y[k]=0; // circular shift
for(j=1;j<N;j++)
p[j]=a[j-1];
p[0]=a[N-1];

for(i=0;i<N;i++)
{
a[i]=p[i];

y[k]+=x[i]*p[i];
}
}
// displaying the result
printf("\nCircular convolution output is:");
for(i=0;i<=N;i++)
{
printf("\n Output y[%d] = %d",i,y[i]);
}
while(1);
}
