/*
1. Selecione todas as peças que possuem a mesma cor que peça Nut
(Atenção, não liste a própria peça)
*/

select *
from sp.p 
where pname != 'Nut' and color in 
	(select color from sp.p where pname = 'Nut')


/*
2. Seleciona as peças cuja cor é igual a cor de alguma outra peça. (Isto
é, cuja cor não é única)
*/

select  *
from sp.p a
where color in 
	(select color from sp.p b where a.color = b.color and a.pname != b.pname )  



/*
3. Quais as cores de peças cuja média de peso é igual ou superior à média
das peças em geral?
*/

select  distinct color
from sp.p a
group by color
having avg(weight)>=
 (select avg(weight) from sp.p)  

/*
4. Quais as peças que são mais pesadas que todas as peças da cor "Blue?
*/

select  *
from sp.p 
where weight >
 (select max(weight) from sp.p where color='Blue')


/*
5. Selecione as peças cujo peso é maior que a média das peças de sua cor.
*/

select  *
from sp.p a
where weight >
(select avg(weight)
 from sp.p b
 where a.color=b.color)


/*
6. Liste as cidades onde há peças e fornecedores.
*/

select  distinct city
from sp.p
where exists
(select city
 from sp.s
where s.city=p.city)


/*
7. Liste as cidades onde há peças e não há fornecedores
*/

select  distinct city
from sp.p
where not exists
(select city
 from sp.s
where s.city=p.city)


/*
8. Liste as cidades onde há fornecedores e não há peças
*/

select  distinct city
from sp.s
where not exists
(select city
 from sp.p
where s.city=p.city)



/*
9.  Liste os fornecedores que fornecem TODAS as peças
*/
/*
10. Obter o código dos fornecedores com maior Status da tabela "S".
*/
/*
11. Obter os nomes de fornecedores que não fornecem a peça 2.
*/
/*
12. Obtenha os pares de fornecedor e peça, em que o fornecedor indicado,
não fornece a peça indicada.
*/
/*
13. Obter o número de fornecedores que não fornecem algumas peças.
*/
/*
14. Obtenha uma lista dos fornecedores (código), as respectivas peças
(código). Na lista devem constar todos os fornecedores, mesmo os que não
fornecem peça alguma. (use junção externa)
*/
/*
15. Obtenha uma lista dos fornecedores (código e nome)., as respectivas
peças (código) e quantidades fornecidas, desde que a qtde fornecida seja
maior do que 300. Na lista devem constar todos os forn
*/
