--BANCO IMOBILIÁRIO
-- Este script tem intenção de ser um estudo para a VF de banco de dados.

--DDL
create schema regras;
create sequence casas_seq;
create table regras.casas(
	id integer default nextval('casas_seq') not null,
	nome varchar(255) not null,--string de tamanho < 255
	preco decimal(10,2) not null, --até 10 dígitos, 2 casas decimais
	pontuacao integer not null,
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
	constraint ct_pk primary key (tabuleiro_id,posicao),
	constraint ct_tabuleiros_fg foreign key (tabuleiro_id) references regras.tabuleiros (id)
		on delete cascade
		on update cascade,
	constraint ct_casas_fg foreign key (casa_id) references regras.casas (id)
		on delete cascade
		on update cascade,
	constraint ct_posicao_positiva check(posicao>0)
);

create schema estados;
create sequence jogadores_seq;
create table estados.jogadores(
	id integer default nextval('jogadores_seq') not null,
	nome varchar(255) not null,
	login varchar(255) not null,
	password_hash char(511) not null,
	constraint jogador_login_uniq unique (login),
	constraint jogadores_pk primary key (id)
);
create sequence jogos_seq;
create table estados.jogos(
	id integer default nextval('jogos_seq') not null,
	nome varchar(255) not null,
	tabuleiro_id integer not null,
	constraint jogos_pk primary key (id),
	constraint jt_fg foreign key (tabuleiro_id) references regras.tabuleiros (id)
		on delete cascade
		on update cascade
);
create table estados.jogadas(
	jogo_id integer not null,
	jogador_id integer not null,
	posicao integer not null,
	pontuacao integer default 0 not null,
	dinheiro integer default 500 not null,
	compra boolean default false not null,
	constraint jj_pk primary key (jogo_id,jogador_id),
	constraint jj_jogo_fg foreign key (jogo_id) references estados.jogos (id)
		on delete cascade
		on update cascade,
	constraint jj_jogador_fg foreign key (jogador_id) references estados.jogadores (id)
		on delete cascade
		on update cascade
);
--TRIGGERS
create function transacoes() returns trigger as
' begin
	if new.compra = true and new.dinheiro >= all (
				select c.preco
				from estados.jogos j
				left join regras.casas_tabuleiros ct
				on ct.tabuleiro_id = j.tabuleiro_id
				left join regras.casas c
				on c.id = ct.casa_id
				where
					ct.posicao = new.posicao
			)
	then
		update estados.jogadas
		set
			dinheiro = dinheiro - (
				select c.preco
				from estados.jogos j
				left join regras.casas_tabuleiros ct
				on ct.tabuleiro_id = j.tabuleiro_id
				left join regras.casas c
				on c.id = ct.casa_id
				where
					ct.posicao = new.posicao
			)
		where
			jogador.id = new.jogador_id and
			jogo_id = new.jogo.id
	end if;
end;' language plpgsql; 
create trigger ao_caminhar
	before update
	of posicao
	on estados.jogadas
	for each row
	execute procedure transacoes();


