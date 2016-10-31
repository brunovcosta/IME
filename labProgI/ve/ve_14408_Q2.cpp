#include<iostream>
#include<string>
#include<vector>
using namespace std;
class Jogador{
	protected:
		int classCode;
		string nome;
		int forca;
		int velocidade;
		int estilo;
		Jogador(string nome,int forca,int velocidade,int estilo):nome(nome),forca(forca),estilo(estilo){};
	public:
		int getClassCode(){
			return classCode;
		}
		string getNome(){
			return nome;
		}
		int getForca(){
			return forca;
		}
		int getVelocidade(){
			return velocidade;
		}
		int getEstilo(){
			return estilo;
		}
};
class Goleiro : public Jogador{
	int camisasLimpas;
	int jogos;
	public:
		Goleiro(string nome,int forca,int velocidade,int estilo,int camisasLimpas,int jogos): camisasLimpas(camisasLimpas),jogos(jogos), Jogador(nome,forca,velocidade,estilo){
			classCode = 3;
		}
		int getGolsTomados(){
			return jogos-camisasLimpas;
		}
};
class Apanhador : public Jogador{
	int pomosDeOuro;
	public:
		Apanhador(string nome,int forca,int velocidade,int estilo,int pomosDeOuro): pomosDeOuro(pomosDeOuro), Jogador(nome,forca,velocidade,estilo){
			classCode = 2;
		}
		int getPomos(){
			return pomosDeOuro;
		}
};
class Batedor : public Jogador{
	int balacosAfastados;
	public:
		Batedor(string nome,int forca,int velocidade,int estilo,int balacosAfastados): balacosAfastados(balacosAfastados), Jogador(nome,forca,velocidade,estilo){
			classCode = 1;
		}
		int getBalacos(){
			return balacosAfastados;
		}
};
class Artilheiro : public Jogador{
	int truques;
	public:
		Artilheiro(string nome,int forca,int velocidade,int estilo,int truques): truques(truques), Jogador(nome,forca,velocidade,estilo){
			classCode = 0;
		}
		int getTruques(){
			return truques;
		}
};
class QuadribolTime{
	string nome;
	vector<Jogador> jogadores;
	public:
		QuadribolTime(string nome):nome(nome){}
		void adicionarJogador(Jogador jogador){
			jogadores.push_back(jogador);
		}
		string getNome(){
			return nome;
		}
		void alterarJogador(int index,Jogador jogador){
			jogadores[index]=jogador;
		}
		int pegarHabilidadeTotal(){
			int totalDeCada[] =     {0,0,0,0};
			int maxDeCada[] =       {3,2,1,1};
			int pesosForca[] =      {1,2,1,2};
			int pesosVelocidade[] = {3,1,2,0};
			int pesosEstilo[] =     {2,1,3,3};
			int poderTotal=0;
			for(int t=0;t<jogadores.size();t++){
				Jogador jogador = jogadores[t];
				int code= jogador.getClassCode();
				totalDeCada[code]++;
				int poder=0;
				poder+=pesosForca[code]*jogador.getForca();
				poder+=pesosVelocidade[code]*jogador.getVelocidade();
				poder+=pesosEstilo[code]*jogador.getEstilo();
				if(code==0){
					poder+=20*static_cast<Artilheiro*>(&jogador)->getTruques();
				}else if(code==1){
					int balacos=20*static_cast<Batedor*>(&jogador)->getBalacos();
					for(int i=0;i<balacos/100;i++)
						poder*=2;
				}else if(code==2){
					poder+=10*static_cast<Apanhador*>(&jogador)->getPomos();
				}else if(code==3){
					poder-=static_cast<Goleiro*>(&jogador)->getGolsTomados();
				}
				poderTotal+=poder;
			}
			for(int t=0;t<4;t++){
				if(totalDeCada[t]>maxDeCada[t])
					return -1;
			}
			return poderTotal;
		}
};
class Partida{
	public: 
		bool realizar(QuadribolTime q1,QuadribolTime q2,string &res){
			int h1=q1.pegarHabilidadeTotal();
			int h2=q2.pegarHabilidadeTotal();
			if (h1==-1 || h2==-1)
				return false;
			res = ((h1>h2)?q1.getNome():q2.getNome());
			return true;
		};
};
int main(){
	Goleiro go1("Ron Weasley", 5, 3, 4, 10, 20); //nome, forca, velocidade, estilo, Qtde de Camisas Limpas, Qtde de Jogos
	Apanhador ap1("Harry Potter", 3, 2, 6, 10);  //nome, forca, velocidade, estilo, Qtde de Pomos de Ouro
	Batedor ba1("Jimmy Peakes", 3, 6, 4, 8),     //nome, forca, velocidade, estilo, Qtde de Balaços afastados
			ba2("Ritchie Coote", 3, 6, 3, 7);
	Artilheiro ar1("Demelza Robins", 5, 7, 3, 8),//nome, forca, velocidade, estilo, Qtde de Truques do Chapéu
			   ar2("Ginny Weasley", 10, 7, 3, 2),
			   ar3("Katie Bell", 2, 7, 4, 4);
	Goleiro go2("Miles Bletchley", 5, 3, 4, 10, 50);
	Apanhador ap2("Draco Malfoy", 5, 1, 5, 20);
	Batedor ba4("Vincent Crabbe", 3, 6, 4, 8),
			ba5("Gregory Goyle", 3, 6, 3, 7);
	Artilheiro ar4("Graham Montague", 5, 7, 3, 8),
			   ar5("Adrian Pucey", 10, 7, 3, 2),
			   ar6("Cassius Warrington", 2, 7, 4, 0);
	QuadribolTime q1("Grifinoria"), //nome
				  q2("Sonserina");
	q1.adicionarJogador(go1);//adiciona o jogador go1 a equipe q1
	q1.adicionarJogador(ap1);
	q1.adicionarJogador(ba1);
	q1.adicionarJogador(ap2);
	q1.adicionarJogador(ar1);
	q1.adicionarJogador(ar2);
	q1.adicionarJogador(ar3);
	q2.adicionarJogador(go2);
	q2.adicionarJogador(ap2);
	q2.adicionarJogador(ba4);
	q2.adicionarJogador(ba5);
	q2.adicionarJogador(ar4);
	q2.adicionarJogador(ar5);
	q2.adicionarJogador(ar6);//adiciona o jogador ar6 a equipe q2
	Partida p;
	string res;
	bool b;
	b = p.realizar(q1,q2,res);//realiza a partida entre q1 e q2, res é o resultado
	if (b)
		cout << q1.getNome() << " X " << q2.getNome() << " -> " << res << endl;
	else
		cout << "Jogo Inválido\n";
	q1.alterarJogador(3, ba2);//altera o jogador de índice 3 da equipe q1 para ba2
	b = p.realizar(q1,q2,res);
	if (b)
		cout << q1.getNome() << " X " << q2.getNome() << " -> " << res << endl;
	else
		cout << "Jogo Inválido\n";
	return 0;
}
