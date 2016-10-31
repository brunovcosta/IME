#ifndef __SUPERHEROI
#define __SUPERHEROI
#include<string>
#include"Personagem.h"
#include"SuperPoder.h"
using namespace std;
class SuperHeroi : public Personagem{
	public:
		SuperHeroi(string nome, string nomeVidaReal);
		double getPoderTotal();
};
#endif
