#ifndef __SUPERPODER
#define __SUPERPODER
#include<string>
using namespace std;
class SuperPoder{
	string nome;
	int categoria;
	public:
		SuperPoder();
		SuperPoder(string nome,int categoria);
		string getNome();
		int getCategoria();
};
#endif
