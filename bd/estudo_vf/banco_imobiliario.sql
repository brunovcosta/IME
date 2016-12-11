--BANCO IMOBILIÁRIO
-- Este script tem intenção de ser um estudo para a VF de banco de dados.

--DDL
create schema regras;
create sequence casas_seq;
create table regras.casas(
	id integer default nextval('casas_seq') not null,
	nome varchar(255) not null,--string de tamanho < 255
	preco decimal(10,2) not null, --até 10 dígitos, 2 casas decimais
	constraint casas_pk primary key (id),
	constraint casas_nome_uniq unique (nome)
);
create sequence tabuleiros_seq;
create table regras.tabuleiros(
	id integer default nextval('tabuleiros_seq') not null,
	nome varchar(255) not null,
	constraint tabuleiros_pk primary key (id),
	constraint tabuleiros_nome_uniq unique (nome)
);
create table regras.casas_tabuleiros(
	tabuleiro_id integer not null,
	casa_id integer not null,
	posicao integer not null,
	constraint ct_pk primary key (casa_id,tabuleiro_id,posicao),
	constraint ct_tabuleiros_fg foreign key (tabuleiro_id) references regras.tabuleiros (id),
	constraint ct_casas_fg foreign key (casa_id) references regras.casas (id)
);

create schema estados;
create sequence jogadores_seq;
create table estados.jogadores(
	id integer default nextval('jogadores_seq') not null,
	nome varchar(255) not null,
	login varchar(255) not null,
	password_hash char(511) not null,
	constraint jogadores_pk primary key (id)
);
create sequence jogos_seq;
create table estados.jogos(
	id integer default nextval('jogos_seq') not null,
	nome varchar(255) not null,
	tabuleiro_id integer not null,
	constraint jogos_pk primary key (id),
	constraint jt_fg foreign key (tabuleiro_id) references regras.tabuleiros (id)
);
create table estados.jogadores_jogos(
	jogo_id integer not null,
	jogador_id integer not null,
	constraint jj_pk primary key (jogo_id,jogador_id),
	constraint jj_jogo_fg foreign key (jogo_id) references estados.jogos (id),
	constraint jj_jogador_fg foreign key (jogador_id) references estados.jogadores (id)
);
