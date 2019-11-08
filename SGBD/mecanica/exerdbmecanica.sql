use dbmecanica;
/*
SELECT
FROM 
WHERE
GROUP BY
HAVING
ORDER BY
*/
-- 1 Crie uma consulta SQL que liste o nome e o telefone de cada proprietário, ordenado pelo nome;
desc proprietario;
SELECT 
 nome, 
 telefone_residencial,
 telefone_comercial
FROM
proprietario
ORDER BY nome;


-- 2 Crie uma consulta SQL que liste todos os serviços realizados pela oficina, ordenado pelo nome do serviço;

SELECT 
	nome 
FROM 
	servico
ORDER BY nome;

-- 3 Crie uma consulta SQL que liste todos os produtos vendidos pela oficina, ordenado pelo nome do produto;

SELECT 
	nome
FROM 
	produto
ORDER BY nome;

-- 4 Crie uma consulta SQL que liste a quantidade de veículo por marca de veiculo;

select * from veiculo;

SELECT
	marca,
    count(marca) as Veiculos
FROM
	veiculo
GROUP BY marca;


-- 5 Liste os proprietários que fazem aniversario nos próximos 45 dias, listar quando será a data de aniversario, ordenado pela data de aniversario;
desc proprietario;

SELECT 
	nome,
	year(now()),
    year(dt_nascimento),
    year(now()) - year(dt_nascimento)
FROM 
	proprietario;


select nome, dt_nascimento from proprietario;

SELECT 
	date_add(dt_nascimento, interval year(now) - year(dt_nascimento) year),
    proprietario.nome
FROM
	proprietario;

-- 6 Crie uma consulta SQL que liste todos os proprietários de veículos e seus respectivos carros, o proprietário deve ser listado mesmo não tendo carro;

SELECT
	veiculo.idveiculo,
	proprietario.nome
FROM
	proprietario
LEFT JOIN veiculo on 
	veiculo.idproprietario = proprietario.idproprietario;

-- 7 Crie uma consulta SQL que liste todos os carros e seus respectivos proprietários, ordenados por nome do proprietário;

SELECT 
	veiculo.idveiculo,
    proprietario.nome
FROM 
	veiculo
INNER JOIN proprietario on 
	proprietario.idproprietario = veiculo.idproprietario;

-- 8 Crie uma consulta SQL que liste todos os mecânicos cadastrados na oficina;

SELECT
	nome
FROM 
	mecanico;
	
-- 9 Crie uma consulta SQL que liste o nome e o valor de todos os produtos já utilizados em um orçamento pela oficina;

SELECT
	produto.idproduto,
	produto.nome,
    produto.valor
FROM produto
INNER JOIN item_produto on 
	produto.idproduto = item_produto.idproduto
GROUP BY produto.nome
ORDER BY produto.idproduto;

-- 10 Crie uma consulta SQL que liste todos os orçamentos realizadas no carro com o código(IDVEICULO) igual à 3,
-- você deve listar a quantidade de serviço realizado e a soma total dos valores do serviço;
select * from item_servico;
select * from orcamento;

SELECT
	orcamento.idveiculo,
    veiculo.marca,
    veiculo.modelo,
    veiculo.placa,
    sum(item_servico.QTDE), 
	sum(servico.valor * item_servico.qtde) 
 FROM 
	item_servico 
 INNER JOIN servico on 
 item_servico.idservico = servico.idservico
 INNER JOIN orcamento on 
	orcamento.idorcamento = item_servico.idorcamento
INNER JOIN veiculo on
	veiculo.idveiculo = orcamento.idveiculo
 WHERE orcamento.idveiculo = 2
 GROUP BY orcamento.idveiculo, veiculo.marca,
    veiculo.modelo,
    veiculo.placa;

-- 11 Crie uma consulta SQL que liste todos os orçamentos realizadas no carro com o código(IDVEICULO) igual à 3, 
-- você deve listar a quantidade de produto utilizado e a soma total de produto utilizado;

SELECT 
    orcamento.idveiculo,
    sum(produto.valor * item_produto.qtde)
FROM 
	orcamento
LEFT JOIN item_produto on
	orcamento.idorcamento = item_produto.idorcamento
INNER JOIN produto on 
	item_produto.idproduto = produto.idproduto
WHERE orcamento.idveiculo = 2
GROUP BY 	orcamento.idveiculo
    ;
	

-- 12 Crie uma consulta SQL que liste todas os orçamentos realizadas no carro com o código(idcarro) igual à 2, 
-- liste também o nome do mecânico responsável pela manutenção;

SELECT 
	orcamento.idorcamento,
    orcamento.idveiculo,
    mecanico.nome as Nome_Mecanico
FROM
	orcamento
LEFT JOIN mecanico on 
 orcamento.idmecanico = mecanico.idmecanico
 WHERE orcamento.idveiculo = 2;
 

-- 13 Crie uma consulta SQL que liste a quantidade de orçamentos por carro, desde que o ano de fabricação seja 2014;


SELECT 
	veiculo.idveiculo,
	count(orcamento.idorcamento) as Orcamentos
FROM 
	orcamento
RIGHT JOIN veiculo on 
	orcamento.idveiculo = veiculo.idveiculo
WHERE veiculo.ano_fabricacao = 2014
GROUP BY VEICULO.idveiculo;


-- 14 Crie uma consulta SQL que liste a media do valor pago em cada orçamento;

select * from orcamento;
show tables;
desc item_servico;
desc orcamento;
desc item_servico;
select * from orcamento;


update item_servico set qtde = 1 where idservico= 2;
-- valores serviço
select IDORCAMENTO, item_servico.IDSERVICO, QTDE, servico.valor from item_servico inner join servico on item_servico.idservico = servico.idservico order by idorcamento;

-- valores serviço por orçamento
select IDORCAMENTO, item_servico.IDSERVICO, QTDE, sum(servico.valor * qtde) from item_servico inner join servico on item_servico.idservico = servico.idservico GROUP BY IDORCAMENTO order by idorcamento;

-- valores produto
select idorcamento, item_produto.idproduto, qtde, produto.valor from item_produto inner join produto on item_produto.idproduto = produto.idproduto;
update item_produto set qtde = 1 where idorcamento = 3;
-- valores produto por orcamento
select idorcamento, item_produto.idproduto, qtde, sum(produto.valor * item_produto.qtde) from item_produto inner join produto on item_produto.idproduto = produto.idproduto GROUP BY idorcamento;

select * from orcamento;
select * from servico;
select * from item_produto;
SELECT distinct
	item_produto.idorcamento,
    item_servico.idorcamento,
    sum(produto.valor),
    sum(servico.valor),
    produto.valor,
    servico.valor,
    avg(produto.valor + servico.valor) as Media
FROM 
	orcamento
INNER JOIN item_servico on 
	item_servico.idorcamento = orcamento.idorcamento
INNER JOIN servico on 
	item_servico.idservico = servico.idservico
INNER JOIN item_produto on 
	item_produto.idorcamento = orcamento.idorcamento
INNER JOIN produto on 
	item_produto.idproduto = produto.idproduto
GROUP BY item_produto.idorcamento, item_servico.idorcamento, produto.valor,
    servico.valor;
    
    -- CORREÇÃO 
    
SELECT 
		AVG(valores.total)
from (
SELECT 
	item_produto.idorcamento, 
    sum(produto.valor * item_produto.qtde) as total
FROM item_produto 
INNER JOIN  produto on 
 item_produto.idproduto = produto.idproduto 
 GROUP BY idorcamento
 
 UNION
    
SELECT 
	orcamento.idorcamento,
    sum(item_servico.qtde * servico.valor) as total
FROM 
	orcamento
INNER JOIN item_servico on 
	orcamento.idorcamento = item_servico.idorcamento
INNER JOIN servico on 
	item_servico.idservico = servico.idservico
GROUP BY orcamento.idorcamento ) AS Valores;

-- 15 Crie uma consulta SQL que liste a quantidade de orçamentos realizados por mês e ano, a soma dos valores pagos, 
-- e a média paga em cada mês e ano;
    

SELECT 
	count(valores.idorcamento),
	year(valores.dt_orcamento) as Ano,
    (Case month(valores.dt_orcamento)
		when 1 then 'Janeiro'
			when 2 then 'Fevereiro'
            when 3 then 'Março'
            when 4 then 'Abril'
            when 5 then 'Maio'
            when 6 then 'Junho'
            when 7 then 'Julho'
            when 8 then 'Agosto'
            when 9 then 'Setembro'
            when 10 then 'Outubro'
            when 11 then 'Novembro'
            when 12 then 'Dezembro'
            END) as Mes ,
            avg(valores.total) as Media,
            sum(valores.total) as Total
           
FROM
			( 
			SELECT 
			item_produto.idorcamento, 
            orcamento.dt_orcamento,
			sum(produto.valor * item_produto.qtde) as total
		FROM item_produto 
		INNER JOIN  produto on 
		 item_produto.idproduto = produto.idproduto
         INNER JOIN orcamento on 
			orcamento.idorcamento = item_produto.idorcamento
		 GROUP BY idorcamento
		 
		 UNION
			
		SELECT 
			orcamento.idorcamento,
            orcamento.dt_orcamento,
			sum(item_servico.qtde * servico.valor) as total
		FROM 
			orcamento
		INNER JOIN item_servico on 
			orcamento.idorcamento = item_servico.idorcamento
		INNER JOIN servico on 
			item_servico.idservico = servico.idservico
		GROUP BY orcamento.idorcamento ) AS Valores
        
group BY  month(dt_orcamento), year(dt_orcamento);





