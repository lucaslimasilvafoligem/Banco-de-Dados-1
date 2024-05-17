CREATE OR REPLACE TRIGGER cliente_before_update
BEFORE UPDATE OF i_domicilio_domicilio ON cliente
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF :NEW.i_domicilio_domicilio IS NOT NULL THEN
        SELECT COUNT(*) INTO v_count 
        FROM domicilio 
        WHERE i_domicilio_domicilio = :NEW.i_domicilio_domicilio;
        
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Não é possível atualizar a foreign key de cliente para domicílio porque o domicílio associado não existe.');
        END IF;

        IF :OLD.i_domicilio_domicilio IS NOT NULL AND :NEW.i_domicilio_domicilio != :OLD.i_domicilio_domicilio THEN
            SELECT COUNT(*) INTO v_count 
            FROM cliente c 
            WHERE c.i_domicilio_domicilio = :OLD.i_domicilio_domicilio;
            IF v_count = 0 THEN
                DELETE FROM domicilio WHERE i_domicilio_domicilio = :OLD.i_domicilio_domicilio;
            END IF;
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER cliente_before_update
BEFORE UPDATE OF i_domicilio_domicilio ON cliente
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.i_domicilio_domicilio IS NOT NULL THEN
        SELECT 1
        INTO v_result
        FROM domicilio
        WHERE i_domicilio_domicilio = :NEW.i_domicilio_domicilio;
        
        IF SQL%NOTFOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Não é possível atualizar a foreign key de cliente para domicílio porque o domicílio associado não existe.');
        END IF;

        IF :OLD.i_domicilio_domicilio IS NOT NULL AND :NEW.i_domicilio_domicilio != :OLD.i_domicilio_domicilio THEN
            BEGIN
                SELECT 1
                INTO v_result
                FROM cliente c 
                WHERE c.i_domicilio_domicilio = :OLD.i_domicilio_domicilio
                AND ROWNUM = 1;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    DELETE FROM domicilio WHERE i_domicilio_domicilio = :OLD.i_domicilio_domicilio;
            END;
        END IF;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER cliente_before_delete
BEFORE DELETE ON cliente
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF :OLD.i_domicilio_domicilio IS NOT NULL THEN
        SELECT COUNT(*) INTO v_count 
        FROM cliente c 
        WHERE c.i_domicilio_domicilio = :OLD.i_domicilio_domicilio

        IF v_count = 0 THEN
            DELETE FROM domicilio WHERE i_domicilio_domicilio = :OLD.i_domicilio_domicilio;
        END IF;
    END IF;
END;
/

