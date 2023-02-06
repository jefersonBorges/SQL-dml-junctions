--3) Usando as mesmas tabelas anteriores, execute as consultas abaixo:
set search_path = exercicio;

--(a) Listar o nome de todos os fornecedores que estejam em cidades que comecem com a letra "L";
select fornecedor.sname, fornecedor.city
from fornecedor
where
	city like 'L%';
	
/*
like:
'%' = qualquer coisa, inclusive nada;

'_'= um caractere somente;


*/
	
/*(b) Listar o nome de todos os fornecedores que estejam em cidades que comecemcom a letra "L"
ou em cidades que terminem com o termo "ris";*/
select fornecedor.sname, fornecedor.city
from fornecedor
where city like 'L%' or city like '%ris';

--(c) Listar as peças que estejam em cidades com exatamente 6 letras;
select peca.pname, peca.city
from peca
where length(city)=6;

/*
ou
select peca.pname, peca.city
from peca
where city like '______';
*/

--(d) Listar a quantidade total de peças expedidas pelo fornecedor "Jones";
select fornecedor.sname as fornecedor,  sum (expedicao.qty) as Total_expedido
from fornecedor inner join expedicao
on fornecedor.cods = expedicao.cods
where fornecedor.sname = 'Jones'
group by fornecedor.sname;


--(e) Listar a média total de peças expedidas pelo fornecedor "Jones";
select fornecedor.sname as fornecedor, round(avg(expedicao.qty),2) as media_expedicoes
from fornecedor inner join expedicao
on fornecedor.cods = expedicao.cods
where lower (fornecedor.sname) = 'jones'
group by fornecedor.sname;

--(f) Listar a quantidade total de peças expedidas por fornecedores da cidade de "Londres";
select fornecedor.city as cidade, sum (expedicao.qty) as quantidade_expedida
from fornecedor inner join expedicao
on fornecedor.cods = expedicao.cods
where lower (fornecedor.city) = 'london'
group by fornecedor.city;

--(g) Listar a quantidade total de peças fornecidas, agrupando por nome de fornecedor;
select fornecedor.sname as nome_fornecedor, sum(expedicao.qty) as quantidade_total_expedida
from fornecedor inner join expedicao
on fornecedor.cods = expedicao.cods
group by fornecedor.sname;

/*(h) Listar a quantidade total de peças fornecidas, agrupando por nome de fornecedor, mas mostrar somente
aqueles fornecedores que expediram mais de 300 peças;*/
select fornecedor.sname as nome_fornecedor, sum(expedicao.qty) as quantidade_expedida
from fornecedor inner join expedicao
on fornecedor.cods = expedicao.cods
group by fornecedor.sname
having sum(expedicao.qty)>300;

--(i) Quais peças (código e nome) possuem a mesma cor da peça P1 (considerando que ninguém sabe a cor da peça P1);
select peca.codp as codigo_peca, peca.pname as nome_peca, peca.color as cor_peca
from peca
group by peca.codp, peca.pname
having peca.color = (select peca.color from peca where lower(peca.codp) = 'p1')
/*
select codp, pname
from peca
where color =(select color from peca where codp = 'P1')
*/
/*
select codp, pname
from peca
where color in (select color from peca where codp = 'P1' or codp = 'P2')
*/
/* para não está em :
select codp, pname
from peca
where color not in (select color from peca where codp = 'P1' or codp = 'P2')
*/

--(j) Listar, usando o conceito de subconsulta, o código das peças vermelhas que foram expedidas.
select peca.codp as peca_codigo, peca.pname as nome_peca, peca.color as cor_peca, expedicao.qty as expedicao
from peca inner join expedicao
on peca.codp = expedicao.codp
where lower(peca.color) = 'red'
group by peca.codp, expedicao.qty; 