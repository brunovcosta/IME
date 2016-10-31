#include"../../include/core/Confronto.h"
#include"../../include/core/Personagem.h"
#include"../../include/core/SuperHeroi.h"
#include"../../include/core/SuperPoder.h"
#include"../../include/core/Vilao.h"
using namespace std;
SuperHeroi::SuperHeroi(string nome, string nomeVidaReal){
	this->setNome(nome);
	this->setNomeVidaReal(nomeVidaReal);
}
double SuperHeroi::getPoderTotal(){
	return getPoderTotal()*1.1;
}
