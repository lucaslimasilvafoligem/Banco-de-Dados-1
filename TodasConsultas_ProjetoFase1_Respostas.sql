-- consulta 1

select ct.nome AS Nome, ct.end_rua AS Rua, ct.end_num AS Nmr, ct.end_bairro AS Bairro, ct.end_cidade AS Cidade
from cliente ct, cliente e
where ct.cliente_indica = e.codcli and
      LOWER(e.nome) = 'joão da silva';

-- consulta 2

SELECT nome AS Nome ,cnpj as CNPJ ,email AS Email
from fornecedor
where  HOME_PAGE IS NULL;

-- consulta 3

SELECT MAX(NF.VALOR_TOTAL) AS MAIOR_VALOR_COMPRA
FROM ORDEM_DE_COMPRA OC
JOIN CLIENTE CT ON OC.CODIGO_CLIENTE = CT.CODCLI
JOIN NOTA_FISCAL NF ON OC.CODORDEM = NF.COD_ORDEM_COMPRA
WHERE EXTRACT(YEAR FROM CT.DATA_NASCIMENTO) BETWEEN 1990 AND 1999
  AND lower(CT.END_CIDADE) = 'campina grande';

-- consulta 4

SELECT COUNT(*) as Aguardando_Pagamento 
FROM ORDEM_DE_COMPRA  
where STATUS = 'AGUARDANDO PAGAMENTO';

-- consulta 5

SELECT n.CODNF
FROM NOTA_FISCAL n
WHERE n.VALOR_TOTAL >= 3000 and n.VALOR_TOTAL <= 10000;

-- consulta 6

select DISTINCT ct.nome
from cliente








 ct
join ordem_de_compra oc on ct.codcli = oc.codigo_cliente
join nota_fiscal nf on oc.codordem = nf.codnf
where nf.valor_total between 500 and 5000 and 
      LOWER(ct.end_cidade) = 'campina grande' and
      ct.pontos > 100;

-- consulta 7

SELECT NOME
FROM PRODUTO
WHERE EXTRACT(YEAR FROM DATA_FABRICACAO) = 2019
  AND PRECO_VENDA >= 2000
  AND EXTRACT(YEAR FROM DATA_VALIDADE) >= 2022;

-- consulta 8

select DISTINCT t.nome AS TRANSPORTADORAS
from ordem_de_compra oc
join transportadora t on oc.codigo_transportadora = t.codtrans
where oc.valor_frete > 100;

-- consulta 9

select ct.nome AS CATEGORIAS
from categoria ct
inner join produto p on p.cod_categoria = ct.codcat
group by ct.nome
having AVG(p.preco_venda) > 1000;


-- consulta 10

select f.nome
from fornecedor f
inner join fornecimento fo on f.codforn = fo.codigo_fornecedor
inner join produto p on fo.codigo_produto = p.codprod
group by f.nome
having avg(p.preco_venda) <= 163;

-- Consulta 11

select nome as Nomes_Fornecedores
from (select f.nome, COUNT(*) AS TOTAL_FORNECIMENTOS
from fornecedor f,fornecimento fn 
where f.codforn = fn.codigo_fornecedor
GROUP BY f.nome
ORDER BY COUNT(*) DESC
FETCH FIRST 3 ROWS ONLY);
