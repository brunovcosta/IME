#include<stdio.h>
int fibo(int total,int atual,int penultimo,int ultimo){
	if(total==atual)
		printf("%d\n",ultimo);
	else
		fibo(total,atual+1,ultimo,penultimo+ultimo);
}
int main(){
	int n;
	scanf("%d",&n);
	if(n==0)
		printf("0\n");
	else
		fibo(n,1,0,1);
	return 0;
}
