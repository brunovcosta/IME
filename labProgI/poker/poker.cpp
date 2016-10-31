#include<stack>
#include<vector>
#include<set>
#include<iterator>
#include<random>
#include<algorithm>
#include<string>
#include<iostream>
using namespace std;
enum valor{as,dois,tres,quatro,cinco,seis,sete,oito,nove,dez,valete,dama,rei};
string valor_s[] = {"AS"," 2"," 3"," 4"," 5"," 6"," 7"," 8"," 9","10","VA","DA","RE"};
enum naipe{copas,ouros,paus,espadas};
string naipe_s[] = {"♥ ","♦ ","♧ ","♤ "};
struct Carta{
	valor v;
	naipe n;
	Carta(valor v,naipe n):v(v),n(n){}
	bool operator==(Carta c){
		return c.v==v;
	}
};
ostream& operator<<(ostream& os,Carta c){
	os<<valor_s[c.v]<<naipe_s[c.n];
	return os;
}
class Baralho{
	vector<Carta> pilha;
	public:
	Baralho(){
		for (valor i =as;i<=rei;i=(valor)((int)i+1)){
			for (naipe j =copas;j<=espadas;j=(naipe)((int)j+1)){
				pilha.push_back(Carta(i,j));
			}
		}
	}
	void embaralhar(){
		random_shuffle(pilha.begin(),pilha.end());
	}
	Carta sacar(){
		Carta ultimo = *pilha.end();
		pilha.pop_back();
		return ultimo;
	}
	void imprimir(){
		for(Carta carta : pilha){
			cout<<carta<<endl;
		}
	}
};
struct Mesa{
	vector< pair<Carta,Carta> > jogadores;
	set<Carta> mesa;
	Baralho baralho;
	int rodada(){
		vector<int> pontos;
		for(auto jogador : jogadores){
			vector <Carta> mao_cheia;
			mao_cheia.push_back(jogador.first);
			mao_cheia.push_back(jogador.second);
			for(Carta c : mesa)
				mao_cheia.push_back(c);

			int dobro_pares=0;
			for(Carta c1 : mao_cheia){
				for(Carta c2 : mao_cheia){
					dobro_pares+=c1==c2?1:0;
				}
			}
			pontos.push_back(dobro_pares);
		}
		return distance(jogadores.begin(),max_element(jogadores.begin(),jogadores.end()));
	}
};
int main(int argc,char** argv){
	Baralho baralho;
	baralho.embaralhar();
	baralho.imprimir();
	Mesa mesa;
	mesa.mesa.insert(baralho.sacar());
	for(int i : {0,1,2,3,4}){
		mesa.jogadores.push_back(make_pair(baralho.sacar(),baralho.sacar()));
	}
	cout<< mesa.rodada();
	return 0;
}
