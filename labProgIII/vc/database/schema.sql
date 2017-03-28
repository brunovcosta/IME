create table incoming(
	user_name varchar not null,
	-- I) Data do gasto
	created_at timestamp default current_timestamp,
	-- II) Descrição do gasto
	description varchar not null,
	-- V) Valor do gasto
	amount integer check (amount > 0) not null
);

create table outcoming(
	user_name varchar not null,
	-- I) Data do gasto
	created_at timestamp default current_timestamp,
	-- II) Descrição do gasto
	description varchar not null,
	-- V) Valor do gasto
	amount integer check (amount > 0) not null
);

-- III) Saldo inicial, antes do gasto
-- IV) Saldo final, depois do gasto
create view balance as
select 
	user_name,
	created_at,
	description,
	amount
from incoming
union select
	user_name,
	created_at,
	description,
	-amount
from outcoming;
