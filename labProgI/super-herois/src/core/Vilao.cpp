#include"../../include/core/Confronto.h"
#include"../../include/core/Personagem.h"
#include"../../include/core/SuperHeroi.h"
#include"../../include/core/SuperPoder.h"
#include"../../include/core/Vilao.h"
using namespace std;
Vilao::Vilao(string nome, string nomeVidaReal, int tempoDePrisao){
	setNome(nome);
	setNomeVidaReal(nomeVidaReal);
	this->tempoDePrisao = tempoDePrisao;
}
double Vilao::getPoderTotal(){
	getPoderTotal()*1.1;
}
