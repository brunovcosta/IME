#include"../../include/core/Confronto.h"
#include"../../include/core/Personagem.h"
#include"../../include/core/SuperHeroi.h"
#include"../../include/core/SuperPoder.h"
#include"../../include/core/Vilao.h"
using namespace std;
string Confronto::enfrentar (SuperHeroi &p1, Vilao &p2){
	double sp1 = p1.getPoderTotal();
	double sp2 = p2.getPoderTotal();

	if(sp1>sp2){
		return p1.getNome();
	}else if(sp2>sp1){
		return p2.getNome();
	}else{
		return "empate";
	}
}
