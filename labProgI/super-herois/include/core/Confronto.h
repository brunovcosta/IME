#ifndef __CONFRONTO
#define __CONFRONTO
#include<string>
#include"Personagem.h"
#include"SuperHeroi.h"
#include"SuperPoder.h"
#include"Vilao.h"
using namespace std;
class Confronto{
	public:
		string enfrentar (SuperHeroi &p1, Vilao &p2);
};
#endif
