#include<iostream>
#include<string>
using namespace std;
class A{
	public: 
		void faz(){
			cout<<"sou do tipo A"<<endl;
		};
};
class B : public A{
	public:
		void faz(){
			cout<<"sou do tipo B"<<endl;
		}
};
class C : public A{
	public:
		void faz(){
			cout<<"sou do tipo C"<<endl;
		}
};

int main(){
	A *lista[] = {new B,new C};
	lista[0]->faz();
	lista[1]->faz();
	return 0;
}
