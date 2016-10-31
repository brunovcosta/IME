#include<stdio.h>
int main(){
	int n;
	scanf("%d",&n);
	int k;
	for(k=0;k<n/2;k++)
		printf("%d\n",2*k);
	return 0;
}
