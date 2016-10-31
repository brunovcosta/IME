#ifndef __PERSONAGEM
#define __PERSONAGEM
#include<string>
#include"SuperPoder.h"
using namespace std;
class Personagem{
	string nome;
	string nomeVidaReal;
	SuperPoder poderes[4];
	int numeroDePoderes;
	public:
		bool adicionaSuperPoder(SuperPoder sp);
		virtual double getPoderTotal();
		string getNome();
		string getNomeVidaReal();
		void setNome(string nome);
		void setNomeVidaReal(string nomeVidaReal);
};
#endif
