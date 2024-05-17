CREATE OR REPLACE VIEW cliente_view AS
SELECT c.s_nome_cliente, d.s_rua_domicilio, d.i_numero_domicilio, d.s_regiao_domicilio
FROM cliente c
JOIN domicilio d ON c.i_domicilio_domicilio = d.i_domicilio_domicilio;

SELECT * FROM cliente_view;

CREATE VIEW cliente AS
    SELECT i_cliente_cliente, s_cpf_cliente, EXTRACT(DAY FROM d_nascimento_cliente) AS dia_nascimento
    FROM cliente;