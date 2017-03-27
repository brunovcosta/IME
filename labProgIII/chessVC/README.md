# VChess

Jogo Multiplayer online feito para a disciplina de Laboratório de Programação III.

## Como jogar

Ao iniciar o servidor entre em
```
localhost:4567#nome_do_jogo
```

E pronto! Basta compartilhar o link do seu ip com seus amigos!

## Server
Para rodar o servidor

```
cd server
sh build_run.sh
```

## Database

Para criar o banco com a tabela de jogos

```
createdb vchess
cd database
cat seed.sql | psql vchess
```

## Requisitos

- Java
- Maven
- Postgresql

