#ifndef __VILAO
#define __VILAO
#include<string>
#include"Personagem.h"
#include"SuperHeroi.h"
#include"SuperPoder.h"
using namespace std;
class Vilao : public Personagem{
	int tempoDePrisao;
	public:
		Vilao(string nome, string nomeVidaReal, int tempoDePrisao);
		double getPoderTotal();
};
#endif
