//carrega STL
#include<iostream>
#include<string>
//core
#include"include/core/SuperPoder.h"
#include"include/core/Personagem.h"
#include"include/core/SuperHeroi.h"
#include"include/core/Vilao.h"
#include"include/core/Confronto.h"
//engine
#include"include/engine/Game.h"

using namespace std;
SuperHeroi inputHeroi(){
	string nome,nomeVidaReal;
	cout<<"Insira o nome do super heroi"<<endl;
	cin>>nome;
	cout<<"Insira o nome real do super heroi"<<endl;
	cin>>nomeVidaReal;
	SuperHeroi heroi(nome,nomeVidaReal);

	int numeroDePoderes;
	cout<<"Insira o numero de poderes"<<endl;
	cin>>numeroDePoderes;
	for(int j=0;j<numeroDePoderes;j++){
		string nomePoder;
		int categoriaPoder;
		cout<<"Insira o nome do poder"<<endl;
		cin>>nomePoder;
		cout<<"Insira a categoria do poder"<<endl;
		cin>>categoriaPoder;
		SuperPoder poder(nomePoder,categoriaPoder);
		heroi.adicionaSuperPoder(poder);
	}
	return heroi;
}
Vilao inputVilao(){
	string nome,nomeVidaReal;
	int tempoDePrisao;
	cout<<"Insira o nome do vilao"<<endl;
	cin>>nome;
	cout<<"Insira o nome real do vilao"<<endl;
	cin>>nomeVidaReal;
	cout<<"Insira o tempo de prisao do vilao"<<endl;
	cin>>tempoDePrisao;
	Vilao vilao(nome,nomeVidaReal,tempoDePrisao);

	int numeroDePoderes;
	cout<<"Insira o numero de poderes"<<endl;
	cin>>numeroDePoderes;
	for(int j=0;j<numeroDePoderes;j++){
		string nomePoder;
		int categoriaPoder;
		cout<<"Insira o nome do poder"<<endl;
		cin>>nomePoder;
		cout<<"Insira a categoria do poder"<<endl;
		cin>>categoriaPoder;
		SuperPoder poder(nomePoder,categoriaPoder);
		vilao.adicionaSuperPoder(poder);
	}

	return vilao;
}
int main(){
	SuperHeroi heroi = inputHeroi();
	Vilao vilao = inputVilao();

	Confronto confronto;
	cout << confronto.enfrentar(heroi,vilao) << endl;
	}
	return 0;
}
