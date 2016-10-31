#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h> 
#include <arpa/inet.h>

#define NRCON 5    /* Numero de conexoes */
#define BUFFSIZE 32
#define PORTA 5001

//função que calcula o tamanho de um arquivo em bytes
int fsize(FILE *fp){
    int prev=ftell(fp);
    fseek(fp, 0L, SEEK_END);
    int sz=ftell(fp);
    fseek(fp,prev,SEEK_SET);
    return sz;
}

int main(void) {
	int ssocket, csocket;
	struct sockaddr_in end_servidor, end_cliente;

	if ((ssocket = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
		perror("Erro criação socket");
		exit(-1);
	}

	/* Construct the server sockaddr_in structure */
	memset(&end_servidor, 0, sizeof(end_servidor)); /* Clear struct */
	end_servidor.sin_family = AF_INET; /* Internet/IP */
	end_servidor.sin_addr.s_addr = htonl(INADDR_ANY); /* Incoming addr */
//	end_servidor.sin_port = htons("5001"); /* server port */
	end_servidor.sin_port = htons(PORTA); /* server port */
	/* Bind the server socket */
	if (bind(ssocket, (struct sockaddr *) &end_servidor, sizeof(end_servidor))
			< 0) {
		perror("erro bind");
		exit(-1);
	}

	/* Listen on the server socket */
	if (listen(ssocket, NRCON) < 0) {
		perror("erro listen");
		exit(-1);
	}
	/* Run until cancelled */
	while (1) {
		unsigned int clientlen = sizeof(end_cliente);
		/* Wait for client connection */
		if ((csocket = accept(ssocket, (struct sockaddr *) &end_cliente,
				&clientlen)) < 0) {
			perror("erro accept");
			exit(-1);
		}
		fprintf(stdout, "Cliente conectado: %s\n",
				inet_ntoa(end_cliente.sin_addr));

		//--------------------------
		char path[256]={};
		recv(csocket,path,255,0);
		printf("%s\n",path);

		FILE *pFile = fopen(path,"rb");
		void *fileBuffer = malloc(fsize(pFile));
		fread(fileBuffer,1,fsize(pFile),pFile);

		int fileSize = fsize(pFile);
		send(csocket,&fileSize,sizeof(int),0);

		send(csocket,fileBuffer,fsize(pFile),0);
		//--------------------------
	}
	close(ssocket);

	exit(0);
}
