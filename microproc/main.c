int soma(int a,int b){
	return a+b;
}
int sub(int a,int b){
	return a-b;
}
int vex(int a,int b){
	return a*b;
}
int div(int a,int b){
	return a/b;
}
int mod(int a,int b){
	return a%b;
}
int main(){
  int a=0;
  int b=2;
  soma(a,b);
  sub(a,b);
  vex(a,b);
  div(mod(a,b),div(b,a));
  return 0;
}
