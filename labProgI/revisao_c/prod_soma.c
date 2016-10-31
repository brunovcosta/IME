#include<stdio.h>
int main(int argc, char** argv){
	FILE *arquivo = fopen(argv[1],"r");
	int prod = 1;
	int soma = 0;
	int fator;
	while(fscanf(arquivo,"%d",&fator)==1){
		if(fator%2==0)
			prod*=fator;
		else
			soma+=fator;
	}
	printf("produto dos pares: %d\n",prod);
	printf("soma dos ímpares: %d\n",soma);

	return 0;
}
