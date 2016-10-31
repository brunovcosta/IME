#include<stdio.h>
#include<stdlib.h>
struct elo{
	int valor;
	struct elo *proximo;
};
typedef struct elo elo;

elo *adicionar_depois(elo *ultimo,int val){
	elo *proximo = (elo*)malloc(sizeof(elo));
	proximo->valor=val;
	proximo->proximo=ultimo->proximo;
	ultimo->proximo=proximo;
	return proximo;
}
elo *adicionar_antes(elo *primeiro,int val){
	elo *anterior = (elo*)malloc(sizeof(elo));
	anterior->valor=val;
	anterior->proximo=primeiro;
	return anterior;
}
void adicionar_final(elo *elemento,int val){
	if(elemento->proximo)
		adicionar_final(elemento->proximo,val);
	else
		adicionar_depois(elemento,val);
}

void imprimir_corrente(elo elemento){
	printf("%d\n",elemento.valor);
	if(elemento.proximo){
		imprimir_corrente(*(elemento.proximo));
	}
}

int main(){
	elo *meio = (elo*)malloc(sizeof(elo));
	meio->valor=1;
	meio->proximo=0;
	elo *anterior = adicionar_antes(meio,5);
	elo *posterior = adicionar_depois(meio,4);
	adicionar_final(anterior,7);
	imprimir_corrente(*anterior);
	
	return 0;
}
