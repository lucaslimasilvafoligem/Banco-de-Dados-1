DELETE FROM cliente c
WHERE c.d_nascimento_cliente IS NOT NULL AND EXTRACT(YEAR FROM c.d_nascimento_cliente) <> 2002;
