class Menu{
	public:
		static void pause(){
			cout<<"Pressione [ENTER] para continuar"<<endl;
			cin.get();
		}
		static void titulo(){
#if defined(WIN32) || defined(_WIN32) || defined(__WIN32) && !defined(__CYGWIN__)
			system("cls");
#else
			system("clear");
#endif
			cout<<"XXXXXXX       XXXXXXXPPPPPPPPPPPPPPPPP   TTTTTTTTTTTTTTTTTTTTTTT     OOOOOOOOO     "<<endl;
			cout<<"X:::::X       X:::::XP::::::::::::::::P  T:::::::::::::::::::::T   OO:::::::::OO   "<<endl;
			cout<<"X:::::X       X:::::XP::::::PPPPPP:::::P T:::::::::::::::::::::T OO:::::::::::::OO "<<endl;
			cout<<"X::::::X     X::::::XPP:::::P     P:::::PT:::::TT:::::::TT:::::TO:::::::OOO:::::::O"<<endl;
			cout<<"XXX:::::X   X:::::XXX  P::::P     P:::::PTTTTTT  T:::::T  TTTTTTO::::::O   O::::::O"<<endl;
			cout<<"   X:::::X X:::::X     P::::P     P:::::P        T:::::T        O:::::O     O:::::O"<<endl;
			cout<<"    X:::::X:::::X      P::::PPPPPP:::::P         T:::::T        O:::::O     O:::::O"<<endl;
			cout<<"     X:::::::::X       P:::::::::::::PP          T:::::T        O:::::O     O:::::O"<<endl;
			cout<<"     X:::::::::X       P::::PPPPPPPPP            T:::::T        O:::::O     O:::::O"<<endl;
			cout<<"    X:::::X:::::X      P::::P                    T:::::T        O:::::O     O:::::O"<<endl;
			cout<<"   X:::::X X:::::X     P::::P                    T:::::T        O:::::O     O:::::O"<<endl;
			cout<<"XXX:::::X   X:::::XXX  P::::P                    T:::::T        O::::::O   O::::::O"<<endl;
			cout<<"X::::::X     X::::::XPP::::::PP                TT:::::::TT      O:::::::OOO:::::::O"<<endl;
			cout<<"X:::::X       X:::::XP::::::::P                T:::::::::T       OO:::::::::::::OO "<<endl;
			cout<<"X:::::X       X:::::XP::::::::P                T:::::::::T         OO:::::::::OO   "<<endl;
			cout<<"XXXXXXX       XXXXXXXPPPPPPPPPP                TTTTTTTTTTT           OOOOOOOOO     "<<endl;
			cout<<"                                             | |   (_)                             "<<endl;
			cout<<"     ___    ___    _ __ ___    _ __     ___  | |_   _    ___    __ _    ___        "<<endl;
			cout<<"    / __|  / _ \\  | '_ ` _ \\  | '_ \\   / _ \\ | __| | |  / __|  / _` |  / _ \\       "<<endl;
			cout<<"   | (__  | (_) | | | | | | | | |_) | |  __/ | |_  | | | (__  | (_| | | (_) |      "<<endl;
			cout<<"    \\___|  \\___/  |_| |_| |_| | .__/   \\___|  \\__| |_|  \\___|  \\__,_|  \\___/       "<<endl;
			cout<<"                              | |                                                  "<<endl;
			cout<<"                              |_|                                                  "<<endl;
		}
		static int principal(){
			titulo();
			cout<<"Entre com a opcao que deseja:                                                      "<<endl;
			cout<<"1 - Inserir competidor                                                             "<<endl;
			cout<<"2 - Imprimir classificacao                                                         "<<endl;
			cout<<"3 - Salvar competicao                                                              "<<endl;
			cout<<"4 - Carregar competicao                                                            "<<endl;
			cout<<"5 - Sair do programa                                                               "<<endl;
			int opcao;
			cin>>opcao;
			pause();
			return opcao;
		}
		static void inserirCompetidor(vector<Competidor> *competidores){
			titulo();
			cout<<"Insira o nome do competidor"<<endl;
			string nome;
			cin>>nome;
			Competidor competidor;
			competidor.setNome(nome);
			int n;
			cout<<"Insira a quantidades de jurados"<<endl;
			for(;;){
				cin>>n;
				if(n>2){
					break;
				}
				cout<<"Soh pode mais que 2"<<endl;
			}
			for(int t=0;t<n;t++){
				cout<<"Insira a "<<(t+1)<<"a nota do competidor "<<competidor.getNome()<<":"<<endl;
				double nota;
				for(;;){
					cin>>nota;
					if(nota>10 || nota < 5){
						cout<<"Nota invalida"<<endl;
					}else{
						competidor.addNota(nota);
						break;
					}
				}
			}
			cout<<"Inserindo as notas em 3, 2 ..."<<endl;
			competidores->push_back(competidor);
			pause();
		}
		static void imprimirClassificacao(vector<Competidor> *competidores){
			titulo();
			cout<<"Lista de classificacao:"<<endl;
			sort(competidores->begin(),competidores->end(),Competidor::primeiroEhMaior);
			for(int t=0;t<competidores->size();t++){
				cout<<(t+1)<<"o \t"<<(*competidores)[t].getNome()<<(*competidores)[t].notasValidas()<<endl;
			}
			pause();
		}
		static void salvarCompeticao(vector<Competidor> *competidores){
			titulo();
			cout<<"Insira o nome do arquivo que deseja salvar:"<<endl;
			string nome;
			cin>>nome;
			ofstream arquivo;
			arquivo.open(nome.c_str());
			arquivo<<Competidor::serializar(*competidores);
			arquivo.close();
			pause();
		}
		static vector<Competidor> carregarCompeticao(){
			titulo();
			vector<Competidor> retVal;
			ifstream arquivo;
			cout<<"Insira o nome do arquivo que deseja carregar:"<<endl;
			string nome;
			cin>>nome;
			arquivo.open(nome);
			string leitura;
			retVal = Competidor::desserializar(&arquivo);
			arquivo.close();
			pause();
			return retVal;
		}
		static void respostaErrada(){
			titulo();
			cout<<"Opcao invalida, tente novamente"<<endl;
			pause();
		}
};
