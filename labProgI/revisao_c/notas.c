#include<stdio.h>
int main(int argc, char** argv){
	FILE *arquivo = fopen(argv[1],"r");
	
	int numero_m=0;
	int numero_f=0;

	float soma_m=0;
	float soma_f=0;

	char sexo;
	int nota;

	while(fscanf(arquivo," %c %d",&sexo,&nota)==2){
		if(sexo=='M'){
			numero_m++;
			soma_m+=nota;
		}
		if(sexo=='F'){
			numero_f++;
			soma_f+=nota;
		}
	}
	
	printf("M: %f",soma_m/numero_m);
	printf("F: %f",soma_f/numero_f);
	
}
