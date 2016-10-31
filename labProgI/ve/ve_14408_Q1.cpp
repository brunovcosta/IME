#include<iostream>
#include<string>
#include<vector>
using namespace std;
struct stats{
	int tempoMedio;
	int desistentes;
};
class Cliente{
	protected:
		int classCode;
		int tempoEsperando;
		string nome;
		int tempoChegada;
		int duracaoServico;
	public:
		/* Retorna seu resultado ao avançar 1min
		 *  0 - Não chegou ainda
		 * -1 - Desiste
		 *  * - Tempo de atendimento
		 */
		int getClassCode(){
			return classCode;
		}
};
class ClienteComum : public Cliente{
	int tempoEsperaMax;
	public:
		ClienteComum(string nome,int tempoChegada,int duracaoServico,int tempoEsperaMax){
			this->tempoEsperando=0;
			this->nome=nome;
			this->tempoChegada=tempoChegada;
			this->duracaoServico=duracaoServico;
			this->tempoEsperaMax=tempoEsperaMax;
			classCode=0;
		}
	public:
		int simular() {
			if(tempoChegada)
				tempoChegada--;
			else
				tempoEsperando++;
			if(tempoEsperando>tempoEsperaMax)
				return -1;
			else
				return tempoEsperando;
		}
};
class ClientePreferencial : public Cliente{
	public:
		ClientePreferencial(string nome,int tempoChegada,int duracaoServico){
			this->tempoEsperando=0;
			this->nome=nome;
			this->tempoChegada=tempoChegada;
			this->duracaoServico=duracaoServico;
			classCode=1;
		}
		int simular() {
			if(tempoChegada)
				tempoChegada--;
			else
				tempoEsperando++;
			return tempoEsperando;
		}
};
class Banco{
	int capacidadeMax;
	vector<Cliente> fila;
	public:
		Banco(int capacidadeMax){
			this->capacidadeMax=capacidadeMax;
		}
		void adicionarCliente(Cliente cliente){
			fila.push_back(cliente);
		}
		stats simular(){
			stats resultado;
			resultado.desistentes=0;
			int somaTempo=0;
			/* código defeituoso
			while(fila.size()){
				for(vector<Cliente>::iterator it=fila.begin();it!=fila.end();){
					int retSim;
					if ((*it).getClassCode()==0){
						retSim = static_cast<ClienteComum*>(&(*it))->simular();
					}else
						retSim = static_cast<ClientePreferencial*>(&(*it))->simular();
					if(retSim==-1){
						resultado.desistentes++;
						it = fila.erase(it);
						return;
					} else{
						somaTempo+=retSim;
						if(!retSim)
							it = fila.erase(it);
						it++;
					}
				}
			}
			*/
			resultado.tempoMedio = somaTempo/fila.size();
			return resultado;
		}
};
//Casos de testes do EAD modificada apenas com a adição de um return 0;
int mainQ1(){
    Banco b(10); //10 é a capacidade máxima do banco
    ClienteComum cc1("Joao", 1, 3, 5); // nome - tempo de chegada - tempo de serviço - tempo de espera
    ClienteComum cc2("Jose", 2, 4, 6);
    ClienteComum cc3("Luiz", 3, 5, 2);
    ClientePreferencial cp1("Maria", 1, 3); // nome - tempo de chegada - tempo de serviço
    ClientePreferencial cp2("Ana", 2, 4);
    ClientePreferencial cp3("Jorge", 3, 5);
    b.adicionarCliente(cc2); //adiciona cliente na fila correspondente
    b.adicionarCliente(cc3);
    b.adicionarCliente(cc1);
    b.adicionarCliente(cp2);
    b.adicionarCliente(cp3);
    b.adicionarCliente(cp1);
    stats st = b.simular(); //método de simulação que retorna estatísticas
    cout << st.tempoMedio << " " << st.desistentes << endl;
	return 0;
}
int main(){
	return mainQ1();
}
