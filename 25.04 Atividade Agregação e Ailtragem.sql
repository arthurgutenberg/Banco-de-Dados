CREATE DATABASE atv_agr_fil;

USE atv_agr_fil;

CREATE TABLE produtos(
	id_produtos INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
	preco DECIMAL(10,2),
    categoria VARCHAR(50)
);

INSERT INTO produtos (nome, preco, categoria) VALUES
("Teclado", 200, "Eletrônicos"),
("Mouse", 100, "Eletrônicos"),
("TV de Tudo", 300, "Obsoleto"),
("Disquete", 5, "Obsoleto"),
("Agenda", 50, "Papelaria");

SELECT *FROM produtos;

-- 1. Mostrar os produtos da categoria "Eletrônicos"
SELECT * FROM  produtos WHERE categoria = "Eletrônicos";

-- 2. Mostrar os produtos com nome que começa com "T"
SELECT * FROM produtos WHERE nome LIKE "T%";

-- 3. Contar quantos produtos têm preço acima de 100
SELECT COUNT(*) FROM produtos WHERE preco > 100;

-- 4. Mostrar a média de preços dos produtos
SELECT AVG (preco) FROM produtos;

-- 5. Atualizar o preço do produto "Mouse" para 75.90
SET SQL_SAFE_UPDATES=0;
UPDATE produtos SET preco = 75.90 WHERE id_produtos = 2;
SELECT *FROM produtos;

-- 6. Apagar os produtos da categoria "Obsoleto"
DELETE FROM produtos WHERE categoria = "Obsoleto";
SELECT *FROM produtos;