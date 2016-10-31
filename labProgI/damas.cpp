#include<iostream>
#include<string>
#include<cstdlib>
using namespace std;
enum celula {vazio,peca1,peca2,dama1,dama2};
class Jogo{
	private:
		bool vez1;
		celula estado[8][8];
		void draw(){
#ifdef WINDOWS
			system("cls");
#else
			system ("clear");
#endif
			cout<<' ';
			for(int t=0;t<8;t++){
				cout<<t+1;
			}
			cout<<endl;
			for(int i=0;i<8;i++){
				for(int j=0;j<8;j++){
					if(j==0)
						cout<<(char)('A'+i);
					if((i+j)%2==0){
						cout<<"█";
					}else{
						if (estado[i][j]==vazio)
							cout<<" ";
						if (estado[i][j]==peca1 || estado[i][j]==dama1)
							cout<<"0";
						if (estado[i][j]==peca2 || estado[i][j]==dama2)
							cout<<"O";
					}
				}
				cout<<endl;
			}
		}
		bool fim(){
			for(int i=0;i<8;i++){
				for(int j=0;j<8;j++){
					if (estado[i][j]!=vazio)
						return false;
				}
			}
			return true;
		}
		bool formato_valido(string jogada){
			return(
					((jogada[0]>='a' && jogada[0]<='h')||(jogada[0]>='A' && jogada[0]<='H')) &&
					((jogada[2]>='a' && jogada[2]<='h')||(jogada[2]>='A' && jogada[2]<='H')) &&
					(jogada[1]>='1' && jogada[1]<='7') &&
					(jogada[3]>='0' && jogada[3]<='7')
				  );
		}
		bool mover(string jogada){
			if(jogada[0]>='a')
				jogada[0]+='A'-'a';
			if(jogada[2]>='a')
				jogada[2]+='A'-'a';
			int i1=jogada[0]-'A';
			int j1=jogada[1]-'1';
			int i2=jogada[2]-'A';
			int j2=jogada[3]-'1';

			if((i1-i2)*(i1-i2)!=(j1-j2)*(j1-j2))
				return false;
			if((i1+j1)%2==0 || (i2+j2)%2==0)
				return false;
			if(estado[i1][j1]!=(vez1?peca1:peca2) && estado[i1][j1]!=(vez1?dama1:dama2))
				return false;
			if(estado[i2][j2]!=vazio)
				return false;
			if((i1-i2)*(i1-i2)==4){
				if(estado[(i1+i2)/2][(j1+j2)/2]==(vez1?peca2:peca1))
					estado[(i1+i2)/2][(j1+j2)/2]=vazio;
			}else if((i1-i2)*(i1-i2)!=1)
				return false;
			celula tmp = estado[i1][j1];
			estado[i1][j1]=estado[i2][j2];
			estado[i2][j2]=tmp;
			return true;
		}
	public:
		Jogo(){
			vez1=true;

			for(int i=0;i<8;i++){
				for(int j=0;j<8;j++){
					if((i+j)%2==1){
						if(j<3)
							estado[i][j]=peca1;
						if(j>4)
							estado[i][j]=peca2;
					}else{
						estado[i][j]=vazio;
					}
				}
			}
		}
		void iniciar(){
			while(!fim()){
				draw();
				string jogada;
				cout<<"Jogador "<<(vez1?1:2)<<endl;
				cin>>jogada;
				if(formato_valido(jogada)){
					while(!mover(jogada));
					vez1=!vez1;
				}else{
					cout<<"Jogada Inválida!"<<endl;
				}
			}
		}
};
int main(){
	Jogo *jogo=new Jogo();
	jogo->iniciar();
}
