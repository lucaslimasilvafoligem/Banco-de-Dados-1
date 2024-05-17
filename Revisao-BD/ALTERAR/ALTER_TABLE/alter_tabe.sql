ALTER TABLE clientes MODIFY s_cpf_cliente CHAR(11);

ALTER TABLE cliente ADD i_domicilio_domicilio INT;

ALTER TABLE cliente ADD CONSTRAINT fk_domicilio_cliente
    FOREIGN KEY (i_domicilio_domicilio) 
    REFERENCES domicilio(i_domicilio_domicilio);

ALTER TABLE cliente MODIFY s_cpf_cliente CHAR(11) UNIQUE;

ALTER TABLE cliente ADD i_tipo_cliente INT DEFAULT 1;

ALTER TABLE cliente DROP COLUMN i_tipo_cliente;

ALTER TABLE cliente ADD i_tipocliente_tipocliente INT NOT NULL;

ALTER TABLE cliente ADD CONSTRAINT fk_tipo_cliente 
    FOREIGN KEY (i_tipocliente_tipocliente) 
    REFERENCES tipocliente(i_tipocliente_tipocliente);
