#include<stdio.h>
#include<pthread.h>

int s=0;

struct {
	int x;
	int y;
} player;
struct {
	int width;
	int height;
} room;

void render(){
	for (int t=0;t<room
	
}
int main(int argc,char** argv){
	pthread_t tid;
	pthread_create(&tid,NULL,&loop,NULL);
	_getch();
	return 0;
}
