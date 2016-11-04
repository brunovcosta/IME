/*A tarefa deve ser feita em dupla durante a aula.

A entrega deve ser um arquivo TXT, nomeado com os nomes dos alunos do grupo.
E deve incluir os resultados além de duas soluções para cada item.
Ainda, para cada item, uma das soluções deve ser usando subconsultas na cláusula WHERE.
As soluções alternativas podem usar subconsultas na cláusula FROM ou JOINs.
*/
/*
1. Selecione todas as peças que possuem a mesma cor que peça Nut
(Atenção, não liste a própria peça)
*/

select *
from sp.p 
where pname != 'Nut' and color in 
	(select color from sp.p where pname = 'Nut');


/*
2. Seleciona as peças cuja cor é igual a cor de alguma outra peça. (Isto
é, cuja cor não é única)
*/

select  *
from sp.p a
where color in 
	(select color from sp.p b where a.color = b.color and a.pname != b.pname );



/*
3. Quais as cores de peças cuja média de peso é igual ou superior à média
das peças em geral?
*/

select  distinct color
from sp.p a
group by color
having avg(weight)>=
 (select avg(weight) from sp.p)  ;

/*
4. Quais as peças que são mais pesadas que todas as peças da cor "Blue?
*/

select  *
from sp.p 
where weight >
 (select max(weight) from sp.p where color='Blue');


/*
5. Selecione as peças cujo peso é maior que a média das peças de sua cor.
*/

select  *
from sp.p a
where weight >
(select avg(weight)
 from sp.p b
 where a.color=b.color);


/*
6. Liste as cidades onde há peças e fornecedores.
*/

select  distinct city
from sp.p
where exists
(select city
 from sp.s
where s.city=p.city);


/*
7. Liste as cidades onde há peças e não há fornecedores
*/

select  distinct city
from sp.p
where not exists
(select city
 from sp.s
where s.city=p.city);


/*
8. Liste as cidades onde há fornecedores e não há peças
*/

select  distinct city
from sp.s
where not exists
(select city
 from sp.p
where s.city=p.city);



/*
9.  Liste os fornecedores que fornecem TODAS as peças
*/

select scod from (select sp.scod,count(*) from sp.sp group by sp.scod having
count(*) = (select count(*) from sp.p)) a;

/*
10. Obter o código dos fornecedores com maior Status da tabela "S".
*/
select scod from sp.s where status = (select max(status) from sp.s);

/*
11. Obter os nomes de fornecedores que não fornecem a peça 2.
*/

select sp.s.scod from sp.s
 where sp.s.scod not in
(select scod from sp.sp where pcod=2);

/*
12. Obtenha os pares de fornecedor e peça, em que o fornecedor indicado,
não fornece a peça indicada.
*/
select sp.s.scod,sp.p.pcod from sp.s,sp.p
where (sp.s.scod,sp.p.pcod) not in
(select sp.sp.scod,sp.sp.pcod from (sp.s inner join sp.sp on sp.s.scod = sp.sp.scod));

/*
13. Obter o número de fornecedores que não fornecem algumas peças.
*/

select count(*) from (select sp.s.scod,count(sp.sp.pcod)  from (sp.s
left join sp.sp on sp.s.scod = sp.sp.scod) 
group by 1
having count(sp.sp.pcod) != ( select count(*) from sp.p )) a;

/*
14. Obtenha uma lista dos fornecedores (código), as respectivas peças
(código). Na lista devem constar todos os fornecedores, mesmo os que não
fornecem peça alguma. (use junção externa)
*/

select distinct
	sp.s.scod,
	sp.sp.pcod
from sp.s
	left join sp.sp on sp.sp.scod = sp.s.scod;
-------------------------------------------------------------------------------
select distinct
	sp.sp.scod,
	sp.sp.pcod
from
	sp.s,
	sp.sp
where
	sp.s.scod = sp.sp.scod
union select
	scod,
	null
from
	sp.s
where sp.s.scod not in (select scod from sp.sp)
;

/*
15. Obtenha uma lista dos fornecedores (código e nome)., as respectivas
peças (código) e quantidades fornecidas, desde que a qtde fornecida seja
maior do que 300. Na lista devem constar todos os fornecedores, mesmo os
que não fornecem mais de 300. (use junção externa)
*/
select
	s.scod
	,s.sname
	,sp.pcod
	,sum(sp.qty)
from sp.s
	left join sp.sp
		on sp.s.scod=sp.sp.scod
group by 1,2,3
order by 1,2,3
;
-------------------------------------------------------------------------------
select
	sp.s.scod,
	sp.s.sname,
	sp.sp.pcod,
	sum(sp.sp.qty)
from 
	sp.s,sp.sp
where
	sp.s.scod = sp.sp.scod
group by 1,2,3
order by 1,2,3
;