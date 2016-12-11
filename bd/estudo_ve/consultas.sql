-- Ano de conclusão
select
	schooling_year,
	schooling,
	count(*)
from
	users 
group by
	schooling_year,schooling
order by
	count(schooling_year) desc
;

--Usuários com por atividade
select
	users.login,
	l.target,
	sum(l.count) as total
from
	users
left join
	(select
		user_id,
		target,
		count(*)
	from
		logs
	group by
		target,user_id
	order by
		count desc) l
on
	l.user_id = users.id
where
	l.count is not null
group by
	l.target,
	users.login
order by
	total desc
;
--Usuários que mais buscam
select
	users.name,
	users.email,
	l.count
from
	users
left join
	(select
		user_id,
		count(*)
	from
		logs
	where
		target = 'question-search'
	group by
		user_id
	order by
		count desc) l
on
	users.id = l.user_id
;
