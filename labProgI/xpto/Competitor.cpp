class Competidor{
	string nome;
	Pais nacionalidade;
	vector<double> notas;
	public:
		string getNome(){
			return nome;
		}
		void setNome(string nome){
			this->nome=nome;
		}
		vector<double> getNotas(){
			return notas;
		}
		void addNota(double nota){
			notas.push_back(nota);
		}
		double notaFinal(){
			sort(notas.begin(),notas.end());
			double soma=0;
			for(int t=1;t<notas.size()-1;t++){
				soma+=notas[t];
			}
			return soma/(notas.size()-2);
		}
		string notasValidas(){
			string retVal="";
			for(int t=1;t<notas.size()-1;t++){
				retVal+="\t"+to_string(notas[t]);
			}
			return retVal;
		}
		static bool primeiroEhMaior(Competidor a, Competidor b){
			return a.notaFinal()>b.notaFinal();
		}
		static string serializar(vector<Competidor> competidores){
			string retVal=" ";
			retVal+=" "+to_string(competidores.size());
			retVal+="\n";
			for(int i=0;i<competidores.size();i++){
				Competidor competidor = competidores[i];
				retVal+=" "+competidor.getNome();
				retVal+=" "+to_string(competidor.getNotas().size());
				for(int j=0;j<competidor.notas.size();j++){
					retVal+=" "+to_string(competidor.notas[j]);
				}
				retVal+="\n";
			}
			return retVal;
		}
		static vector<Competidor> desserializar(ifstream *arquivo){
			vector<Competidor> competidores;

			int total;
			(*arquivo)>>total;
			for(int i=0;i<total;i++){
				string nome;
				(*arquivo)>>nome;
				Competidor competidor;
				competidor.setNome(nome);
				int n;
				(*arquivo)>>n;
				for(int t=0;t<n;t++){
					double nota;
					(*arquivo)>>nota;
					competidor.addNota(nota);
				}
				competidores.push_back(competidor);
			}

			return competidores;
		}
};
