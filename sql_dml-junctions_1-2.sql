/*1) Utilizando as tabelas PECA, FORNECEDOR e EXPEDICAO, gere os produtos
cartesianos entre:
(a) A tabela fornecedor e peca.
(b) A tabela fornecedor e expedicao.
(c) A tabela peca e expedicao.
(d) A tabela fornecedor, peca e expedicao.
Para cada item acima, informe o número de registros gerados no produto cartesiano e
o porquê deste número.
*/
select* from fornecedor;
select* from peca;
select* from expedicao;

--(a) A tabela fornecedor e peca.
select fornecedor.*, peca.*
from fornecedor, peca;
--30 registros, 5 registros de fornecedores * 6 registros de pecas.

--(b) A tabela fornecedor e expedicao.
select fornecedor.*, expedicao.*
from fornecedor, expedicao;
--60 registros, 5 registros de fornecedores * 12 registros de expedicao.

--(c) A tabela peca e expedicao.
select peca.*, expedicao.*
from peca, expedicao;
--72 registros, 6 registros de pecas * 12 registros de expedicao.

--(d) A tabela fornecedor, peca e expedicao.
select fornecedor.*, peca.*, expedicao.*
from fornecedor, peca, expedicao;
--360 registros, 5 registros de fornecedores * 6 registros de pecas * 12 registros de expedicao.

/*
2) Utilizando as tabelas PECA, FORNECEDOR e EXPEDICAO, execute as consultas
solicitadas abaixo para exercitar o conceito de JUNÇÃO. Notar que existem várias
respostas possíveis para cada item.
*/
--(a) Listar o nome dos fornecedores de cada uma das expedições realizadas.
select fornecedor.sname
from fornecedor inner join expedicao
on fornecedor.cods = expedicao.cods
-- OU EQUIJOIN
select distinct f.sname
from fornecedor f, expedicao e
where f.cods = e.cods;

--(b) Listar o nome das peças que foram expedidas, sem repetições.
select distinct peca.pname
from peca inner join expedicao
on peca.codp = expedicao.codp;

--(c) Listar o nome das peças que foram expedidas pelo fornecedor "Jones".
select peca.pname
from peca inner join expedicao
on peca.codp = expedicao.codp
inner join fornecedor on expedicao.cods = fornecedor.cods
where sname = 'Jones';
-- OU EQUIJOIN
select p.pname
from peca p, expedicao e, fornecedor f
where
p.codp = e.codp
and
f.cods = e.cods
and
lower(f.sname) = 'jones';


--(d) Listar o nome e a cidade dos fornecedores que expediram peças vermelhas ou azuis.
select fornecedor.sname, fornecedor.city
from fornecedor inner join expedicao
on fornecedor.cods = expedicao.cods
inner join peca on peca.codp = expedicao.codp
where (peca.color = 'Red' or peca.color = 'Blue')


--(e) Listar o nome e a cidade dos fornecedores que expediram peças vermelhas ou azuis, sem repetir linhas.
select distinct f.sname, f.city
from fornecedor f inner join expedicao e on f.cods = e.cods
inner join peca p on p.codp = e.codp		
where
lower(p.color) in  ('blue', 'red');


--(f) Listar o nome dos fornecedores e o nome das peças que encontram-se nas mesmas cidades.
select f.sname, p.pname
from fornecedor f, peca p
where
f.city = p.city
--ou
select f.sname, p.pname
from fornecedor f inner join peca p on f.city = p.city;
--ou
select f.sname, p.pname
from fornecedor f inner join peca p using(city);


--(g) Listar o nome das peças que foram expedidas e o nome dos respectivos fornecedores.
select p.pname, f.sname
from peca p inner join expedicao e on p.codp = e.codp
			inner join fornecedor f on f.cods = e.cods


--(h) Listar o nome das peças que foram expedidas e o nome dos respectivos fornecedores, daquelas expedições acima ou igual a 300 unidades.
select p.pname, f.sname
from peca p inner join expedicao e on p.codp= e.codp
			inner join fornecedor f on f.cods = e.cods
where
e.qty >=300;


--(i) Listar o nome, a cor e a quantidade de peças expedidas pelo fornecedor Clark.
select p.pname, p.color, e.qty
from peca p, fornecedor f, expedicao e
where
p.codp = e.codp
and
f.cods = e.cods
and
lower(f.sname)='clark'


--(j) Listar todas as expedições realizadas pelos fornecedores cujo status é maior ou igual a 30.
select e.*
from expedicao e inner join fornecedor f on e.cods= f.cods
where
cast (f.status as int)>=30


