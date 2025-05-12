CREATE DATABASE vendas;

USE vendas;

CREATE TABLE cliente(
	cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL, -- campo n pode ser nulo
    email VARCHAR(100) UNIQUE,
    cidade VARCHAR(100)
);

CREATE TABLE pedido(
	pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    datapedido DATE NOT NULL,
    FOREIGN KEY(cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE produto(
	produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nomeproduto VARCHAR(100) NOT NULL,
    precounitario DECIMAL(10,2) NOT NULL
);

CREATE TABLE itempedido(
	itempedido_id INT PRIMARY KEY AUTO_INCREMENT,
	pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    FOREIGN KEY(pedido_id) REFERENCES pedido(pedido_id),
    FOREIGN KEY(produto_id) REFERENCES produto(produto_id)
);

INSERT INTO cliente VALUES
(NULL, 'Abimeleque', 'abimeleque@gmail.com','Jerusálem'),
(NULL, 'Melquisedeque', 'malquisedeque@gmail.com', 'Mesopotâmia'),
(NULL, 'Geroboão', 'geroboão@gmail.com', 'Canaã');

INSERT INTO pedido VALUES
(NULL, 'Túnica', 72,50),
(NULL, 'Pergaminho', 99,40),
(NULL, 'Cajado', 55,90);

INSERT INTO pedido VALUES(1, 2, '2025-05-09', );
