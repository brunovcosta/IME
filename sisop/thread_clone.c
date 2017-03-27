#include <sched.h>
#include <stdio.h>
void loop(){
	while(1)
		puts("thread");
}
int main(){
	clone();
	while(1)
		puts("main");
	return 0;
}
