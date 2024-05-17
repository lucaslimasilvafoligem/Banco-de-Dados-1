SELECT c.i_cliente_cliente, c.s_nome_cliente, c.s_cpf_cliente, tc.s_desctipocliente_tipocliente
FROM cliente c
INNER JOIN tipocliente tc ON c.i_tipocliente_tipocliente = tc.i_tipocliente_tipocliente;
