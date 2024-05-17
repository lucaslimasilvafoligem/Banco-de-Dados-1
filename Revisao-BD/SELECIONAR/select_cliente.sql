SELECT * FROM cliente;

SELECT * FROM tipocliente;

SELECT UPPER(c.s_nome_cliente)
FROM cliente c
WHERE SUBSTR(c.s_cpf_cliente, -4) = '8910';

SELECT MAX(c.i_cliente_cliente)
FROM cliente c;
