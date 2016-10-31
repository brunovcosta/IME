Trabalho de redes::Sockets
======================
##Compilação
```
cc server.c -o server
cc client.c -o client
```

##Segue neste projeto dois programas
- server.c
	Servidor que escuta a porta 5001.
	A cada mensagem com um caminho de arquivo, ele retorna este mesmo para download.
	Nota: a transferencia de arquivo limita-se ao tamanho máximo de pacote TCP(< 64k).

	Uso: ./server
- client.c
	Cliente que conecta-se ao servidor acima e faz requisição de um arquivo.
	
	Uso: ./client <endereço IP> <porta> <arquivo>
	Exemplo: ./client 127.0.0.1 5001 exemplo.jpg

##Autores
- Bruno Vieira Costa
- Lucas Ricarte Rogério Teixeira
