-- VChess
-- Este script gera as tabelas utilizadas no VChess

drop table games;
drop sequence games_seq;
create sequence games_seq;
create table games(
	id integer default nextval('games_seq') not null primary key,
	name varchar not null not null unique,
	fen varchar not null default 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
);
