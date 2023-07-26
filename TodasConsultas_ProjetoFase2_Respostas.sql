-- Questão 1:

CREATE OR REPLACE PROCEDURE ajusta_preco(CODIGO_CAT IN NUMBER) AS
BEGIN
  UPDATE PRODUTO
  SET PRECO_VENDA = PRECO_VENDA + 100,
      PRECO_COMPRA = PRECO_COMPRA + 100
  WHERE COD_CATEGORIA = CODIGO_CAT;

  COMMIT;
END;

-- Questão 2:

CREATE OR REPLACE FUNCTION get_total_prod_comprados(p_data_compra DATE) RETURN NUMBER IS
    total_valor NUMBER := 0;
BEGIN
    SELECT SUM(NF.VALOR_TOTAL) INTO total_valor
    FROM ORDEM_DE_COMPRA OC, NOTA_FISCAL NF
    WHERE OC.CODORDEM = NF.COD_ORDEM_COMPRA
        AND OC.DATA_COMPRA <= p_data_compra;

    RETURN total_valor;
END;

-- Questão 3:

CREATE OR REPLACE FUNCTION calcula_total_fornecedor(codigo_fornecedor_entrada INTEGER) RETURN NUMBER IS
    valor_total_fornecimentos NUMBER := 0;
BEGIN 
    SELECT SUM(p.quantidade * p.preco_compra) INTO valor_total_fornecimentos
    FROM fornecedor fncd
    JOIN fornecimento fnct ON fncd.codforn = fnct.codigo_fornecedor
    JOIN produto p ON p.codprod = fnct.codigo_produto
    WHERE fncd.codforn = codigo_fornecedor_entrada;

    RETURN valor_total_fornecimentos;
END;

-- Questão 4:

create or replace view questao4(codigo_ordem)
    as select oc.codordem
    from ordem_de_compra oc
    inner join transportadora t on oc.codigo_transportadora = t.codtrans
    inner join nota_fiscal nf on nf.cod_ordem_compra = oc.codordem
    where nf.valor_total > 10000 and t.nome = 'Azul Cargo'
    group by oc.codordem;

-- Questão 5:

create view listaTrans(Transportadora, VendasTransportadas)
as select t.nome, count(*)
   from transportadora t,ordem_de_compra oc
   where t.codtrans = oc.codigo_transportadora
   group by t.nome;

-- Questão 5:

 CREATE OR REPLACE VIEW LISTATRANS ("TRANSPORTADORA", "VENDASTRANSPORTADAS") AS 
  select t.codtrans, count(*)
   from transportadora t,ordem_de_compra oc
   where t.codtrans = oc.codigo_transportadora
   group by t.codtrans;


-- Questão 6:

create view ProdutosFornecidosCategoria
as select *
    from (select f.codforn, p.cod_categoria, count(*) as Produtos_CatForn
        from fornecimento fn, fornecedor f, produto p
        where fn.codigo_fornecedor = f.codforn 
            and fn.codigo_produto = p.codprod
        group by f.codforn, p.cod_categoria)
        natural join fornecedor;

-- Questão 7:

CREATE OR REPLACE TRIGGER TRG_MODIFICA_NOME_TRANSPORTADORA
BEFORE INSERT OR UPDATE OF NOME ON TRANSPORTADORA
FOR EACH ROW
BEGIN
    IF INSTR(:NEW.NOME, ' ') > 0 THEN
        :NEW.NOME := INITCAP(SUBSTR(:NEW.NOME, 1, INSTR(:NEW.NOME, ' ') - 1)) || SUBSTR(:NEW.NOME, INSTR(:NEW.NOME, ' '));
    ELSE
        :NEW.NOME := INITCAP(:NEW.NOME);
    END IF;
END;

-- Questão 8:

create or replace trigger nome_maiusculo
before insert or update of cpf on cliente
for each row
begin
    :new.nome := upper(:old.nome);
    :new.sobrenome := upper(:old.sobrenome);
end;

-- Questão 9:

CREATE OR REPLACE TRIGGER TRG_ATUALIZA_END_BAIRRO
BEFORE INSERT OR UPDATE OF END_BAIRRO ON CLIENTE
FOR EACH ROW
BEGIN
    IF :NEW.END_BAIRRO IS NULL THEN
        :NEW.END_BAIRRO := 'CENTRO';
    END IF;
END;
