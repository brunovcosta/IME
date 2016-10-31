#include<stdio.h>
#include<stdlib.h>
float media(int n,float *ptr){
	float soma=0;
	int t;
	for(t=0;t<n;t++)
		soma+=ptr[t];
	return soma/n;
}
int main(){
	int n;
	printf("Entre com o número de notas\n");
	scanf("%d",&n);
	float *lista = (float*)malloc(sizeof(float)*n);
	printf("Entre com as notas\n");
	int t;
	for(t=0;t<n;t++)
		scanf("%f",lista+t);
	
	printf("a media deu: %f\n",media(n,lista));
	return 0;
}
