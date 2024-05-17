CREATE OR REPLACE PROCEDURE saudar_cliente IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Olá, Cliente!');
END;

BEGIN
    saudar_cliente;
END;

CREATE OR REPLACE PROCEDURE saudar_cliente_nome (
    p_nome_cliente IN VARCHAR2
) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Olá, ' || p_nome_cliente || '!');
END;


BEGIN
    saudar_cliente_nome('João');
END;


CREATE OR REPLACE PROCEDURE calcular_idade(
    idCliente IN NUMBER,
    idade OUT NUMBER
) IS
    dt DATE;
BEGIN

    SELECT d_nascimento_cliente
    INTO dt
    FROM cliente
    WHERE i_cliente_cliente = idCliente;

    idade := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM dt);

    IF EXTRACT(MONTH FROM SYSDATE) < EXTRACT(MONTH FROM dt) OR
       (EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM dt) AND EXTRACT(DAY FROM SYSDATE) < EXTRACT(DAY FROM dt)) THEN
        idade := idade - 1;
    END IF;
END;