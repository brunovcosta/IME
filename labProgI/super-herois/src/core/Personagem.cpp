#include"../../include/core/Confronto.h"
#include"../../include/core/Personagem.h"
#include"../../include/core/SuperHeroi.h"
#include"../../include/core/SuperPoder.h"
#include"../../include/core/Vilao.h"
using namespace std;
bool Personagem::adicionaSuperPoder(SuperPoder sp){
	if(numeroDePoderes<4){
		poderes[numeroDePoderes]=sp;
		return true;
	}else{
		return false;
	}
}
double Personagem::getPoderTotal(){
	int soma=0;
	for (int t=0;t<4;t++){
		soma+=poderes[t].getCategoria();
	}
}
string Personagem::getNome(){
	return nome;
}
string Personagem::getNomeVidaReal(){
	return nomeVidaReal;
}
void Personagem::setNome(string nome){
	this->nome = nome;
}
void Personagem::setNomeVidaReal(string nomeVidaReal){
	this->nomeVidaReal = nomeVidaReal;
}
