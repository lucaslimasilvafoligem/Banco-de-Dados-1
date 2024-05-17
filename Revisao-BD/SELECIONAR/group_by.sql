SELECT
    i_tipo_cliente,
    count(i_cliente_cliente) as Qtde
FROM cliente
GROUP BY i_tipo_cliente;
