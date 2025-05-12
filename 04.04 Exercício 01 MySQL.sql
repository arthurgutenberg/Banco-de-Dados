CREATE DATABASE loja;

USE loja;
/*
TABELA NAO FORMALIZADA, FORMA ERRADA
*/
CREATE TABLE tabela_nao_normalizada(
	nome_cliente VARCHAR(70),
	telefone_cliente VARCHAR(15),
	telefone2_cliente VARCHAR(15),
	pedido_descricao VARCHAR(50),
	pedido_quantidade INTEGER,
	pedido_valor_produto FLOAT
);

/*
TABELA NAO FORMALIZADA, 1° FORMA CORRETA
*/
CREATE TABLE cliente(
	id_cliente INTEGER PRIMARY KEY AUTO_INCREMENT,
	nome_cliente VARCHAR(70),
	telefone_cliente VARCHAR(15),
	pedido_descricao VARCHAR(50),
	pedido_quantidade INTEGER,
	pedido_valor_produto FLOAT
);

INSERT INTO cliente
VALUES(null, "Arthur Gutenberg", "(61) 93456-7812", "cachorro", 2, 397.90);

INSERT INTO cliente(nome_cliente, telefone_cliente)
VALUES("Josenice", "(61) 92187-6543"), ("Jocilene", "(61) 92143-6587");

/*seleciona tudo da tabela cliente*/
SELECT * FROM cliente;

SELECT nome_clinte FROM cliente WHERE id_cliente = 1;

/*conta todos os registros da tabela cliente*/
SELECT 	COUNT(*) AS "CONTAGEM DE PESSOAS" FROM cliente;