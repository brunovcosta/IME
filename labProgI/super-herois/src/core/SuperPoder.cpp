#include"../../include/core/Confronto.h"
#include"../../include/core/Personagem.h"
#include"../../include/core/SuperHeroi.h"
#include"../../include/core/SuperPoder.h"
#include"../../include/core/Vilao.h"
using namespace std;
SuperPoder::SuperPoder(){
}
SuperPoder::SuperPoder(string nome,int categoria){
	this->nome=nome;
	this->categoria=categoria;
}
string SuperPoder::getNome(){
	return nome;
}
int SuperPoder::getCategoria(){
	return categoria;
}
