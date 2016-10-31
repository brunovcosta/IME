#include<stdio.h>
#define MAX 32767
void min_troca(int n,int *lista){
	int min = MAX;
	int pos;
	int t;
	for(t=0;t<n;t++)
		if(lista[t]<=min){
			min = lista[t];
			pos=t;
		}
	printf("%d\n",min);
	lista[pos] = MAX;
}
int main(){
	int n;
	scanf("%d",&n);
	int *lista = (int*)malloc(n*sizeof(int));
	int t;
	for(t=0;t<n;t++)
		scanf("%d",lista+t);

	for(t=0;t<n;t++)
		min_troca(n,lista);
	return 0;
}
