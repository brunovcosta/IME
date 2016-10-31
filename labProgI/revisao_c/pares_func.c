#include<stdio.h>
int step(int n,int atual){
	printf("%d\n",atual);
	int prox = atual+2;
	if(prox<n)
		step(n,prox);
}
int main(){
	int n;
	scanf("%d",&n);
	step(n,2);
	return 0;
}
