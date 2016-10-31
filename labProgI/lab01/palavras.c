#include<stdio.h>
int main(int argc,char **argv){
	FILE *outputFile=fopen(argv[1],"w"),*inputFile;
	char input[256];
	scanf("%s",input);
	fprintf(outputFile,"%s",input);
	fclose(outputFile);

	char read[256];
	inputFile = fopen(argv[1],"r");
	if(!strcmp(input,read))
		printf("diferente!");
	else
		printf("igual!");
	
	return 0;
}
