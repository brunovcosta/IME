#include<stdio.h>
int main(){
	int n;
	scanf("%d",&n);

	int k;

	int penultimo = 0;
	int ultimo = 1;
	for(k=0;k<n-1;k++){
		int tmp = penultimo;
		penultimo = ultimo;
		ultimo+=tmp;
	}
	printf("%d\n",n==0?0:ultimo);
	return 0;
}
