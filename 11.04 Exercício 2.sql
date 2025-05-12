CREATE DATABASE exec2;

USE exec2;

CREATE TABLE produtos(
	id_produtos INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (35),
    preco FLOAT,
    categoria VARCHAR (25)

);

INSERT INTO produtos
VALUES(null, "Cacho_de_Banana", 14.99, "alimento");

INSERT INTO produtos(nome, preco)
VALUES("Maca_Turma_da_Monica", 3.45);

INSERT INTO produtos
VALUES(null, "Minecraft", 24.98, "jogo");

SELECT * FROM produtos;

SELECT * FROM produtos
WHERE categoria = 'alimento';

SELECT COUNT(*) FROM produtos;