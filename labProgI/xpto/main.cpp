//lib
#include<iostream>
#include<fstream>
#include<string>
#include<vector>
#include<algorithm>
#include<cstdlib>
using namespace std;
//core
#include"Pais.cpp"
#include"Competitor.cpp"
#include"Menu.cpp"


int main(){
	Competidor competidor;
	vector<Competidor> *competidores = new vector<Competidor>();
	for(;;){
		int opcao = Menu::principal();
		if(opcao==1){
			Menu::inserirCompetidor(competidores);
		}else if(opcao==2){
			Menu::imprimirClassificacao(competidores);
		}else if(opcao==3){
			Menu::salvarCompeticao(competidores);
		}else if(opcao==4){
			*competidores = Menu::carregarCompeticao();
		}else if(opcao==5){
			return 0;
		}else{
			Menu::respostaErrada();
		}
	}
	return 0;
}
